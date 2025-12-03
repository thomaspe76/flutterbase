import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:android_play_install_referrer/android_play_install_referrer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Service für Referral-/Empfehlungssystem via Play Store Install Referrer.
///
/// Funktionsweise Android:
/// 1. User teilt Link: play.google.com/store/apps/details?id=com.app&referrer=ref_USER123
/// 2. Neuer User installiert App
/// 3. App liest Referrer beim ersten Start aus
/// 4. Referral wird in Firestore gespeichert
///
/// iOS: Benötigt Firebase Dynamic Links oder eigenen Redirect-Service
class ReferralService {
  final FirebaseFirestore _firestore;

  /// Maximale Anzahl Referral-Belohnungen pro User
  final int maxRewards;

  /// Belohnungsdauer in Tagen (z.B. 7 Tage Premium)
  final int rewardDays;

  /// Firestore Collection Name
  final String collectionName;

  ReferralService({
    FirebaseFirestore? firestore,
    this.maxRewards = 3,
    this.rewardDays = 7,
    this.collectionName = 'referrals',
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Generiert den Referral-Link für einen User
  Future<String> generateReferralLink(String userId) async {
    final packageInfo = await PackageInfo.fromPlatform();
    final packageName = packageInfo.packageName;

    if (Platform.isAndroid) {
      // Play Store Link mit Referrer-Parameter
      return 'https://play.google.com/store/apps/details?id=$packageName&referrer=ref_$userId';
    }

    // iOS: Platzhalter - muss mit Dynamic Links oder eigenem Service implementiert werden
    // return 'https://yourapp.page.link/invite?ref=$userId';
    return 'https://apps.apple.com/app/id[APP_ID]';
  }

  /// Teilt den Referral-Link mit System-Share-Dialog
  Future<void> shareReferralLink({
    required String userId,
    required String shareText,
    String? subject,
  }) async {
    final link = await generateReferralLink(userId);
    final text = shareText.replaceAll('{link}', link);

    await Share.share(
      text,
      subject: subject,
    );
  }

  /// Prüft beim App-Start ob ein Install-Referrer vorhanden ist (nur Android)
  /// Sollte einmalig nach User-Registrierung/Login aufgerufen werden
  Future<String?> checkAndProcessInstallReferrer(String currentUserId) async {
    if (!Platform.isAndroid) return null;

    try {
      final referrerDetails = await AndroidPlayInstallReferrer.installReferrer;
      if (referrerDetails.installReferrer == null) return null;

      final referrerString = referrerDetails.installReferrer!;
      debugPrint('[ReferralService] Install Referrer: $referrerString');

      String? referrerId;

      // Parse: "ref_USER_ID" oder "ref_USER_ID&utm_source=..."
      if (referrerString.contains('ref_')) {
        final match =
            RegExp(r'ref_([a-zA-Z0-9_-]+)').firstMatch(referrerString);
        referrerId = match?.group(1);
      }

      // Validierung: Nicht sich selbst referrieren
      if (referrerId != null &&
          referrerId.isNotEmpty &&
          referrerId != currentUserId) {
        final processed = await _processReferral(referrerId, currentUserId);
        return processed ? referrerId : null;
      }
    } catch (e) {
      debugPrint('[ReferralService] Error: $e');
    }

    return null;
  }

  Future<bool> _processReferral(String referrerId, String newUserId) async {
    try {
      // Prüfen ob Referral bereits verarbeitet wurde
      final existingReferral = await _firestore
          .collection(collectionName)
          .where('newUserId', isEqualTo: newUserId)
          .limit(1)
          .get();

      if (existingReferral.docs.isNotEmpty) {
        debugPrint('[ReferralService] Already processed for user');
        return false;
      }

      // Prüfen ob Referrer max Rewards erreicht hat
      final referrerRewards = await _firestore
          .collection(collectionName)
          .where('referrerId', isEqualTo: referrerId)
          .where('status', isEqualTo: 'completed')
          .get();

      if (referrerRewards.docs.length >= maxRewards) {
        debugPrint('[ReferralService] Referrer reached max rewards');
        return false;
      }

      // Referral speichern
      await _firestore.collection(collectionName).add({
        'referrerId': referrerId,
        'newUserId': newUserId,
        'createdAt': FieldValue.serverTimestamp(),
        'status': 'pending', // pending -> completed (nach Reward-Vergabe)
        'platform': Platform.operatingSystem,
        'rewardDays': rewardDays,
      });

      debugPrint(
          '[ReferralService] Referral recorded: $referrerId -> $newUserId');
      return true;
    } catch (e) {
      debugPrint('[ReferralService] Error processing: $e');
      return false;
    }
  }

  /// Holt die Anzahl abgeschlossener Referrals für einen User
  Future<int> getCompletedReferralCount(String userId) async {
    final snapshot = await _firestore
        .collection(collectionName)
        .where('referrerId', isEqualTo: userId)
        .where('status', isEqualTo: 'completed')
        .get();
    return snapshot.docs.length;
  }

  /// Holt alle Referrals für einen User (als Referrer)
  Future<List<Map<String, dynamic>>> getReferrals(String userId) async {
    final snapshot = await _firestore
        .collection(collectionName)
        .where('referrerId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => {
              'id': doc.id,
              ...doc.data(),
            })
        .toList();
  }

  /// Stream für Echtzeit-Updates der Referrals
  Stream<QuerySnapshot> listenForReferrals(String userId) {
    return _firestore
        .collection(collectionName)
        .where('referrerId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// Markiert Referral als abgeschlossen (nach Reward-Vergabe)
  Future<void> completeReferral(String referralDocId) async {
    await _firestore.collection(collectionName).doc(referralDocId).update({
      'status': 'completed',
      'completedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Prüft ob User noch Referral-Rewards erhalten kann
  Future<bool> canReceiveReward(String userId) async {
    final count = await getCompletedReferralCount(userId);
    return count < maxRewards;
  }
}
