import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../config/env_config.dart';

part 'ai_service.g.dart';

@Riverpod(keepAlive: true)
AIService aiService(Ref ref) {
  return AIService(
    apiKey: EnvConfig.instance.geminiApiKey,
  );
}

class AIService {
  final GenerativeModel _model;

  AIService({required String apiKey})
      : _model = GenerativeModel(
          model: 'gemini-1.5-flash',
          apiKey: apiKey,
        );

  Future<String?> generateText(String prompt) async {
    try {
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      return response.text;
    } catch (e) {
      // Handle error appropriately (log it, rethrow, etc.)
      return null;
    }
  }
}
