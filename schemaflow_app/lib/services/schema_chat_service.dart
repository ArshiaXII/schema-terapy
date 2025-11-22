import 'package:flutter/material.dart';
import '../models/schema_therapy_data.dart';

/// Message model for chat
class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

/// Schema-specific chat service
/// Provides responses based on user's test results and schema scores
class SchemaChatService {
  final Map<int, double> schemaScores;
  final SchemaTherapySchema schema;
  final List<ChatMessage> conversationHistory;

  SchemaChatService({
    required this.schemaScores,
    required this.schema,
    List<ChatMessage>? initialHistory,
  }) : conversationHistory = initialHistory ?? [];

  /// Get a response based on user message and schema context
  Future<String> getResponse(String userMessage) async {
    // Add user message to history
    conversationHistory.add(
      ChatMessage(
        text: userMessage,
        isUser: true,
        timestamp: DateTime.now(),
      ),
    );

    // Generate response based on schema and user message
    final response = _generateSchemaResponse(userMessage);

    // Add bot response to history
    conversationHistory.add(
      ChatMessage(
        text: response,
        isUser: false,
        timestamp: DateTime.now(),
      ),
    );

    return response;
  }

  /// Generate a response that stays within schema context
  String _generateSchemaResponse(String userMessage) {
    final lowerMessage = userMessage.toLowerCase();

    // Check if user is asking about their specific schema
    if (_isAskingAboutSchema(lowerMessage)) {
      return _getSchemaExplanation();
    }

    // Check if user is asking about effects
    if (_isAskingAboutEffects(lowerMessage)) {
      return _getEffectsExplanation();
    }

    // Check if user is asking about healing
    if (_isAskingAboutHealing(lowerMessage)) {
      return _getHealingAdvice();
    }

    // Check if user is asking about origins
    if (_isAskingAboutOrigins(lowerMessage)) {
      return _getOriginsExplanation();
    }

    // Default response that relates to their schema
    return _getContextualResponse(userMessage);
  }

  bool _isAskingAboutSchema(String message) {
    return message.contains('what') && message.contains('schema') ||
        message.contains('explain') ||
        message.contains('tell me about');
  }

  bool _isAskingAboutEffects(String message) {
    return message.contains('effect') ||
        message.contains('impact') ||
        message.contains('how does') ||
        message.contains('consequence');
  }

  bool _isAskingAboutHealing(String message) {
    return message.contains('heal') ||
        message.contains('fix') ||
        message.contains('overcome') ||
        message.contains('help') ||
        message.contains('advice') ||
        message.contains('solution');
  }

  bool _isAskingAboutOrigins(String message) {
    return message.contains('origin') ||
        message.contains('childhood') ||
        message.contains('why') ||
        message.contains('cause');
  }

  String _getSchemaExplanation() {
    return '''${schema.nameEn} is a core belief pattern that developed early in your life. 

Based on your test results, your score for this schema is ${schemaScores[schema.id]?.toStringAsFixed(1) ?? 'N/A'}/6, which indicates a ${_getScoreSeverity(schemaScores[schema.id] ?? 0)} level of activation.

${schema.descriptionEn}

This pattern likely affects several areas of your life. Would you like to know more about how it manifests or how to work with it?''';
  }

  String _getEffectsExplanation() {
    final effects = schema.effectsEn.join('\n• ');
    return '''Here are the main ways ${schema.nameEn} affects people:

• $effects

Given your score of ${schemaScores[schema.id]?.toStringAsFixed(1) ?? 'N/A'}/6, you may be experiencing several of these effects. Which one resonates most with you?''';
  }

  String _getHealingAdvice() {
    return '''Here's how you can work with ${schema.nameEn}:

${schema.healingApproachEn}

Since your score is ${schemaScores[schema.id]?.toStringAsFixed(1) ?? 'N/A'}/6, I recommend starting with small, manageable steps. 

What specific situation would you like help with?''';
  }

  String _getOriginsExplanation() {
    return '''${schema.nameEn} typically develops from childhood experiences:

${schema.childhoodOriginEn}

Understanding these origins can help you recognize when this pattern is being triggered. Does this resonate with your own experiences?''';
  }

  String _getContextualResponse(String userMessage) {
    final responses = [
      'That\'s an interesting question. How does this relate to your experience with ${schema.nameEn}?',
      'I appreciate that question. Let me connect it to what we know about ${schema.nameEn} in your case. ${schema.descriptionEn}',
      'That\'s worth exploring. In the context of ${schema.nameEn}, this might manifest as... Can you tell me more about your specific situation?',
      'Good question. With your ${schema.nameEn} pattern at ${schemaScores[schema.id]?.toStringAsFixed(1) ?? 'N/A'}/6, this could be particularly relevant. What aspect concerns you most?',
    ];

    return responses[userMessage.length % responses.length];
  }

  String _getScoreSeverity(double score) {
    if (score <= 2) return 'low';
    if (score <= 3) return 'moderate';
    if (score <= 4) return 'significant';
    if (score <= 5) return 'high';
    return 'very high';
  }

  /// Clear conversation history
  void clearHistory() {
    conversationHistory.clear();
  }
}

