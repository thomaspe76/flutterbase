// ignore_for_file: deprecated_member_use
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:android_play_install_referrer/android_play_install_referrer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:share_plus/share_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Referral-Service für Empfehlungsprogramme.
///
/// Android: Play Store Install Referrer (kostenlos, nativ)
/// iOS: Firebase Dynamic Links (benötigt Konfiguration)
class ReferralService {
  final FirebaseFirestore _firestore;
  final FirebaseDynamicLinks _dynamicLinks;

  final int maxRewards;
  final int rewardDays;
  final String collectionName;

  // Für Dynamic Links (iOS)
  final String? dynamicLinkDomain; // z.B. 'yourapp.page.link'
  final String? iosBundleId;
  final String? iosAppStoreId;
  final String? androidPackageName;

  ReferralService({
    FirebaseFirestore? firestore,
    FirebaseDynamicLinks? dynamicLinks,
    this.maxRewards = 3,
    this.rewardDays = 7,
    this.collectionName = 'referrals',
    this.dynamicLinkDomain,
    this.iosBundleId,
    this.iosAppStoreId,
    this.androidPackageName,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _dynamicLinks = dynamicLinks ?? FirebaseDynamicLinks.instance;

  // === LINK GENERATION ===

  /// Generiert Referral-Link
  Future<String> generateReferralLink(String userId) async {
    final packageInfo = await PackageInfo.fromPlatform();
    final packageName = androidPackageName ?? packageInfo.packageName;

    // Android: Direkter Play Store Link mit Referrer
    if (Platform.isAndroid) {
      return 'https://play.google.com/store/apps/details?id=$packageName&referrer=ref_$userId';
    }

    // iOS: Firebase Dynamic Link
    if (Platform.isIOS && dynamicLinkDomain != null) {
      try {
        final parameters = DynamicLinkParameters(
          uriPrefix: 'https://$dynamicLinkDomain',
          link: Uri.parse('https://$dynamicLinkDomain/refer?ref=$userId'),
          androidParameters: AndroidParameters(packageName: packageName),
          iosParameters: IOSParameters(
            bundleId: iosBundleId ?? packageName,
            appStoreId: iosAppStoreId,
          ),
        );
        final shortLink = await _dynamicLinks.buildShortLink(parameters);
        return shortLink.shortUrl.toString();
      } catch (e) {
        debugPrint('[ReferralService] Dynamic Link failed: $e');
      }
    }

    // Fallback
    return 'https://apps.apple.com/app/id${iosAppStoreId ?? "APP_ID"}';
  }

  /// Teilt Referral-Link
  Future<void> shareReferralLink({
    required String userId,
    required String shareText,
    String? subject,
  }) async {
    final link = await generateReferralLink(userId);
    final text = shareText.replaceAll('{link}', link);
    await Share.share(text, subject: subject);
  }

  // === REFERRER DETECTION ===

  /// Prüft Install Referrer (Android) oder Dynamic Link (iOS)
  Future<String?> checkAndProcessReferrer(String currentUserId) async {
    String? referrerId;

    if (Platform.isAndroid) {
      referrerId = await _checkAndroidReferrer();
    } else if (Platform.isIOS) {
      referrerId = await _checkIOSDynamicLink();
    }

    if (referrerId != null && referrerId != currentUserId) {
      final success = await _processReferral(referrerId, currentUserId);
      return success ? referrerId : null;
    }

    return null;
  }

  Future<String?> _checkAndroidReferrer() async {
    try {
      final details = await AndroidPlayInstallReferrer.installReferrer;
      if (details.installReferrer == null) return null;

      final referrer = details.installReferrer!;
      debugPrint('[ReferralService] Android referrer: $referrer');

      // Parse: ref_USER_ID
      final match = RegExp(r'ref_([a-zA-Z0-9_-]+)').firstMatch(referrer);
      return match?.group(1);
    } catch (e) {
      debugPrint('[ReferralService] Android referrer error: $e');
      return null;
    }
  }

  Future<String?> _checkIOSDynamicLink() async {
    try {
      final initialLink = await _dynamicLinks.getInitialLink();
      if (initialLink == null) return null;

      final uri = initialLink.link;
      debugPrint('[ReferralService] iOS dynamic link: $uri');

      return uri.queryParameters['ref'];
    } catch (e) {
      debugPrint('[ReferralService] iOS dynamic link error: $e');
      return null;
    }
  }

  // === REFERRAL PROCESSING ===

  Future<bool> _processReferral(String referrerId, String newUserId) async {
    try {
      // Bereits verarbeitet?
      final existing = await _firestore
          .collection(collectionName)
          .where('newUserId', isEqualTo: newUserId)
          .limit(1)
          .get();

      if (existing.docs.isNotEmpty) {
        debugPrint('[ReferralService] Already processed');
        return false;
      }

      // Max Rewards erreicht?
      final rewards = await _firestore
          .collection(collectionName)
          .where('referrerId', isEqualTo: referrerId)
          .where('status', isEqualTo: 'completed')
          .get();

      if (rewards.docs.length >= maxRewards) {
        debugPrint('[ReferralService] Max rewards reached');
        return false;
      }

      // Speichern
      await _firestore.collection(collectionName).add({
        'referrerId': referrerId,
        'newUserId': newUserId,
        'createdAt': FieldValue.serverTimestamp(),
        'status': 'pending',
        'platform': Platform.operatingSystem,
        'rewardDays': rewardDays,
      });

      debugPrint('[ReferralService] Recorded: $referrerId → $newUserId');
      return true;
    } catch (e) {
      debugPrint('[ReferralService] Process error: $e');
      return false;
    }
  }

  // === QUERIES ===

  Future<int> getCompletedCount(String userId) async {
    final snapshot = await _firestore
        .collection(collectionName)
        .where('referrerId', isEqualTo: userId)
        .where('status', isEqualTo: 'completed')
        .get();
    return snapshot.docs.length;
  }

  Future<bool> canReceiveReward(String userId) async {
    final count = await getCompletedCount(userId);
    return count < maxRewards;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> watchReferrals(String userId) {
    return _firestore
        .collection(collectionName)
        .where('referrerId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> completeReferral(String docId) async {
    await _firestore.collection(collectionName).doc(docId).update({
      'status': 'completed',
      'completedAt': FieldValue.serverTimestamp(),
    });
  }
}
