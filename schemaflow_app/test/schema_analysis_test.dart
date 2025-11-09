import 'package:flutter_test/flutter_test.dart';
import 'package:myschema_app/services/schema_analysis_service.dart';
import 'package:myschema_app/models/schema_therapy_data.dart';

void main() {
  group('Schema Analysis Service Tests', () {
    test('Calculate schema scores from answers', () {
      // Create sample answers (25 questions, 1-6 scale)
      final answers = <int, int>{
        1: 5, // Question 1: score 5
        2: 4, // Question 2: score 4
        3: 6, // Question 3: score 6
        4: 3, // Question 4: score 3
        5: 5, // Question 5: score 5
        6: 4,
        7: 5,
        8: 3,
        9: 4,
        10: 5,
        11: 6,
        12: 4,
        13: 5,
        14: 3,
        15: 4,
        16: 5,
        17: 6,
        18: 4,
        19: 5,
        20: 3,
        21: 4,
        22: 5,
        23: 6,
        24: 4,
        25: 5,
      };

      final schemaScores = SchemaAnalysisService.calculateSchemaScores(answers);

      // Verify that all schemas have scores
      expect(schemaScores.isNotEmpty, true);
      
      // Verify that scores are within valid range (0-6)
      for (final score in schemaScores.values) {
        expect(score >= 0 && score <= 6, true);
      }

      // Print results for debugging
      print('Schema Scores:');
      schemaScores.forEach((schemaId, score) {
        final schema = SchemaTherapyDatabase.getSchemaById(schemaId);
        print('  ${schema?.nameEn}: $score');
      });
    });

    test('Calculate domain scores from schema scores', () {
      final schemaScores = <int, double>{
        1: 4.5,
        2: 3.5,
        3: 5.0,
        4: 2.5,
        5: 4.0,
        6: 3.5,
        7: 4.5,
        8: 3.0,
        9: 5.5,
        10: 2.5,
        11: 4.0,
        12: 3.5,
        13: 5.0,
        14: 2.0,
        15: 4.5,
        16: 3.5,
        17: 5.5,
        18: 2.5,
      };

      final domainScores =
          SchemaAnalysisService.calculateDomainScores(schemaScores);

      // Verify that all 5 domains have scores
      expect(domainScores.length, 5);

      // Verify that scores are within valid range
      for (final score in domainScores.values) {
        expect(score >= 0 && score <= 6, true);
      }

      // Print results
      print('Domain Scores:');
      domainScores.forEach((domainId, score) {
        print('  Domain $domainId: $score');
      });
    });

    test('Get top schemas by score', () {
      final schemaScores = <int, double>{
        1: 5.5,
        2: 3.2,
        3: 4.8,
        4: 2.1,
        5: 5.0,
        6: 3.5,
        7: 4.2,
        8: 2.8,
        9: 5.2,
        10: 1.5,
        11: 4.5,
        12: 3.0,
        13: 5.8,
        14: 2.5,
        15: 4.0,
        16: 3.2,
        17: 5.3,
        18: 2.0,
      };

      final topSchemas =
          SchemaAnalysisService.getTopSchemas(schemaScores, topN: 5);

      // Verify we got 5 schemas
      expect(topSchemas.length, 5);

      // Verify they are sorted by score (highest first)
      for (int i = 0; i < topSchemas.length - 1; i++) {
        expect(
          topSchemas[i].value >= topSchemas[i + 1].value,
          true,
          reason:
              'Schemas should be sorted by score in descending order',
        );
      }

      // Print results
      print('Top 5 Schemas:');
      for (int i = 0; i < topSchemas.length; i++) {
        final schema =
            SchemaTherapyDatabase.getSchemaById(topSchemas[i].key);
        print('  ${i + 1}. ${schema?.nameEn}: ${topSchemas[i].value}');
      }
    });

    test('Validate questionnaire answers', () {
      // Valid answers
      final validAnswers = <int, int>{
        1: 3,
        2: 4,
        3: 5,
        4: 2,
        5: 6,
      };

      final validResult =
          SchemaAnalysisService.validateAnswers(validAnswers, 5);
      expect(validResult.isValid, true);
      expect(validResult.errors.isEmpty, true);

      // Invalid answers - not all questions answered
      final incompleteAnswers = <int, int>{
        1: 3,
        2: 4,
      };

      final incompleteResult =
          SchemaAnalysisService.validateAnswers(incompleteAnswers, 5);
      expect(incompleteResult.isValid, false);
      expect(incompleteResult.errors.isNotEmpty, true);

      // Invalid answers - out of range
      final invalidAnswers = <int, int>{
        1: 7, // Invalid: > 6
        2: 4,
        3: 5,
        4: 2,
        5: 6,
      };

      final invalidResult =
          SchemaAnalysisService.validateAnswers(invalidAnswers, 5);
      expect(invalidResult.isValid, false);
      expect(invalidResult.errors.isNotEmpty, true);
    });

    test('Get score interpretation', () {
      expect(
        SchemaAnalysisService.getScoreInterpretation(0.5),
        contains('Very Low'),
      );
      expect(
        SchemaAnalysisService.getScoreInterpretation(1.5),
        contains('Low'),
      );
      expect(
        SchemaAnalysisService.getScoreInterpretation(2.5),
        contains('Moderate'),
      );
      expect(
        SchemaAnalysisService.getScoreInterpretation(3.5),
        contains('High'),
      );
      expect(
        SchemaAnalysisService.getScoreInterpretation(4.5),
        contains('Very High'),
      );
      expect(
        SchemaAnalysisService.getScoreInterpretation(5.5),
        contains('Extremely High'),
      );
    });
  });
}

