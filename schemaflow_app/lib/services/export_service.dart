import 'package:flutter/foundation.dart';
import '../models/schema_therapy_data.dart';

/// Service for exporting assessment results
class ExportService {
  /// Export assessment results as formatted text
  static String exportAsText(
    PremiumQuestionnaireResult result, {
    required String userName,
  }) {
    final buffer = StringBuffer();

    buffer.writeln('═' * 60);
    buffer.writeln('MYSCHEMA - ASSESSMENT REPORT');
    buffer.writeln('═' * 60);
    buffer.writeln();

    // Header
    buffer.writeln('User: $userName');
    buffer.writeln('Date: ${result.completedAt.toString().split('.')[0]}');
    buffer.writeln('Questions Answered: ${result.totalQuestions}');
    buffer.writeln();

    // Schema Scores
    buffer.writeln('─' * 60);
    buffer.writeln('SCHEMA SCORES');
    buffer.writeln('─' * 60);
    buffer.writeln();

    result.schemaScores.forEach((schemaId, score) {
      final schema = SchemaTherapyDatabase.getSchemaById(schemaId);
      if (schema != null) {
        buffer.writeln('${schema.nameEn}: ${score.toStringAsFixed(2)}/6.0');
      }
    });
    buffer.writeln();

    // Domain Scores
    buffer.writeln('─' * 60);
    buffer.writeln('DOMAIN SCORES');
    buffer.writeln('─' * 60);
    buffer.writeln();

    result.domainScores.forEach((domainId, score) {
      final domainName = _getDomainName(domainId);
      buffer.writeln('$domainName: ${score.toStringAsFixed(2)}/6.0');
    });
    buffer.writeln();

    // Top 5 Schemas
    buffer.writeln('─' * 60);
    buffer.writeln('TOP 5 DOMINANT SCHEMAS');
    buffer.writeln('─' * 60);
    buffer.writeln();

    final topSchemas = result.schemaScores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    for (var i = 0; i < topSchemas.take(5).length; i++) {
      final entry = topSchemas[i];
      final schema = SchemaTherapyDatabase.getSchemaById(entry.key);
      if (schema != null) {
        buffer.writeln('${i + 1}. ${schema.nameEn}');
        buffer.writeln('   Score: ${entry.value.toStringAsFixed(2)}/6.0');
        buffer.writeln('   Description: ${schema.descriptionEn}');
        buffer.writeln();
      }
    }

    buffer.writeln('═' * 60);
    buffer.writeln('End of Report');
    buffer.writeln('═' * 60);

    return buffer.toString();
  }

  /// Export assessment results as CSV
  static String exportAsCSV(
    PremiumQuestionnaireResult result, {
    required String userName,
  }) {
    final buffer = StringBuffer();

    // Header
    buffer.writeln('MySchema Assessment Report');
    buffer.writeln('User,$userName');
    buffer.writeln('Date,${result.completedAt.toString().split('.')[0]}');
    buffer.writeln('Total Questions,${result.totalQuestions}');
    buffer.writeln();

    // Schema Scores
    buffer.writeln('Schema Name,Score');
    result.schemaScores.forEach((schemaId, score) {
      final schema = SchemaTherapyDatabase.getSchemaById(schemaId);
      if (schema != null) {
        buffer.writeln('${schema.nameEn},${score.toStringAsFixed(2)}');
      }
    });
    buffer.writeln();

    // Domain Scores
    buffer.writeln('Domain Name,Score');
    result.domainScores.forEach((domainId, score) {
      final domainName = _getDomainName(domainId);
      buffer.writeln('$domainName,${score.toStringAsFixed(2)}');
    });

    return buffer.toString();
  }

  /// Get domain name from domain ID
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

  /// Generate shareable summary
  static String generateShareableSummary(
    PremiumQuestionnaireResult result, {
    required String userName,
  }) {
    final topSchemas = result.schemaScores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final topSchema = topSchemas.isNotEmpty
        ? SchemaTherapyDatabase.getSchemaById(topSchemas.first.key)
        : null;

    final buffer = StringBuffer();
    buffer.writeln('🧠 MySchema Assessment Results');
    buffer.writeln();
    buffer.writeln('I just completed my schema therapy assessment on MySchema!');
    buffer.writeln();

    if (topSchema != null) {
      buffer.writeln(
          'My dominant schema: ${topSchema.nameEn} (${topSchemas.first.value.toStringAsFixed(1)}/6.0)');
    }

    buffer.writeln();
    buffer.writeln('Discover your schemas: https://myschema.app');

    return buffer.toString();
  }
}

