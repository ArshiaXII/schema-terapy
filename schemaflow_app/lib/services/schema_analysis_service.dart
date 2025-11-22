import 'package:flutter/foundation.dart';
import '../models/schema_therapy_data.dart';
import '../models/premium_questions.dart';

/// Service for analyzing questionnaire responses and calculating schema scores
class SchemaAnalysisService {
  /// Calculate schema scores from questionnaire answers
  /// Returns a map of schemaId -> score (0-6)
  static Map<int, double> calculateSchemaScores(
    Map<int, int> answers,
  ) {
    final schemaScores = <int, double>{};

    // Initialize all schemas with 0
    for (final schema in SchemaTherapyDatabase.allSchemas) {
      schemaScores[schema.id] = 0;
    }

    // Count answers per schema
    final schemaCounts = <int, int>{};
    final schemaAnswerSums = <int, int>{};

    for (final question in PremiumQuestionsDatabase.allQuestions) {
      if (answers.containsKey(question.id)) {
        final schemaId = question.schemaId;
        final answer = answers[question.id]!;

        schemaCounts[schemaId] = (schemaCounts[schemaId] ?? 0) + 1;
        schemaAnswerSums[schemaId] = (schemaAnswerSums[schemaId] ?? 0) + answer;
      }
    }

    // Calculate average score for each schema
    schemaCounts.forEach((schemaId, count) {
      if (count > 0) {
        final sum = schemaAnswerSums[schemaId] ?? 0;
        final average = sum / count;
        schemaScores[schemaId] = average;
      }
    });

    debugPrint('Schema Scores Calculated:');
    schemaScores.forEach((schemaId, score) {
      final schema = SchemaTherapyDatabase.getSchemaById(schemaId);
      debugPrint('  ${schema?.nameEn}: $score');
    });

    return schemaScores;
  }

  /// Calculate domain scores from schema scores
  /// Returns a map of domainId -> score (0-6)
  static Map<int, double> calculateDomainScores(
    Map<int, double> schemaScores,
  ) {
    final domainScores = <int, double>{};

    // Initialize all domains
    for (int i = 1; i <= 5; i++) {
      domainScores[i] = 0;
    }

    // Get schemas by domain
    final schemasByDomain = <int, List<SchemaTherapySchema>>{};
    for (int i = 1; i <= 5; i++) {
      schemasByDomain[i] = SchemaTherapyDatabase.allSchemas
          .where((s) => s.domain.index + 1 == i)
          .toList();
    }

    // Calculate average score per domain
    schemasByDomain.forEach((domainId, schemas) {
      if (schemas.isNotEmpty) {
        double sum = 0;
        for (final schema in schemas) {
          sum += schemaScores[schema.id] ?? 0;
        }
        domainScores[domainId] = sum / schemas.length;
      }
    });

    debugPrint('Domain Scores Calculated:');
    domainScores.forEach((domainId, score) {
      final domainName = _getDomainName(domainId);
      debugPrint('  $domainName: $score');
    });

    return domainScores;
  }

  /// Get top N schemas by score
  static List<MapEntry<int, double>> getTopSchemas(
    Map<int, double> schemaScores, {
    int topN = 5,
  }) {
    final sorted = schemaScores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted.take(topN).toList();
  }

  /// Get schema interpretation based on score
  static String getScoreInterpretation(double score) {
    if (score < 1.0) {
      return 'Very Low - This schema has minimal impact on your life';
    } else if (score < 2.0) {
      return 'Low - This schema has limited influence';
    } else if (score < 3.0) {
      return 'Moderate - This schema has some influence';
    } else if (score < 4.0) {
      return 'High - This schema significantly affects your behavior';
    } else if (score < 5.0) {
      return 'Very High - This schema strongly influences your life';
    } else {
      return 'Extremely High - This is a dominant schema requiring attention';
    }
  }

  /// Validate questionnaire answers
  static ValidationResult validateAnswers(
    Map<int, int> answers,
    int totalQuestions,
  ) {
    final errors = <String>[];

    if (answers.isEmpty) {
      errors.add('No answers provided');
    }

    if (answers.length != totalQuestions) {
      errors.add(
        'Not all questions answered: ${answers.length}/$totalQuestions',
      );
    }

    for (final answer in answers.values) {
      if (answer < 1 || answer > 6) {
        errors.add('Invalid answer value: $answer (must be 1-6)');
      }
    }

    return ValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
    );
  }

  static String _getDomainName(int domainId) {
    switch (domainId) {
      case 1:
        return 'Disconnection & Rejection';
      case 2:
        return 'Impaired Autonomy & Performance';
      case 3:
        return 'Impaired Limits';
      case 4:
        return 'Other-Directedness';
      case 5:
        return 'Over-vigilance & Inhibition';
      default:
        return 'Unknown Domain';
    }
  }
}

/// Validation result for questionnaire answers
class ValidationResult {
  final bool isValid;
  final List<String> errors;

  ValidationResult({
    required this.isValid,
    required this.errors,
  });

  String get errorMessage => errors.join('\n');
}

