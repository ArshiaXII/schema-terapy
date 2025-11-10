import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import '../models/schema_therapy_data.dart';

// Note: Cloud storage integration (Firebase) will be added for iOS/Android builds
// For now, files are saved locally to the app's documents directory

/// Service for exporting assessment results to PDF, CSV, and text
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

  /// Export assessment results to PDF
  static Future<File?> exportToPDF(
    PremiumQuestionnaireResult result, {
    required String userName,
  }) async {
    try {
      final pdf = pw.Document();

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (context) => [
            pw.Header(
              level: 0,
              child: pw.Text(
                'MySchema Assessment Results',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Text('User: $userName'),
            pw.Text('Date: ${result.completedAt.toString().split('.')[0]}'),
            pw.Text('Questions: ${result.totalQuestions}'),
            pw.SizedBox(height: 20),
            pw.Header(level: 1, child: pw.Text('Schema Scores')),
            pw.SizedBox(height: 10),
            pw.Table(
              border: pw.TableBorder.all(),
              children: [
                pw.TableRow(children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text('Schema', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text('Score', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ),
                ]),
                ...result.schemaScores.entries.map((entry) {
                  final schema = SchemaTherapyDatabase.getSchemaById(entry.key);
                  return pw.TableRow(children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(schema?.nameEn ?? 'Unknown'),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(entry.value.toStringAsFixed(2)),
                    ),
                  ]);
                }).toList(),
              ],
            ),
          ],
        ),
      );

      final output = await getApplicationDocumentsDirectory();
      final file = File('${output.path}/assessment_${DateTime.now().millisecondsSinceEpoch}.pdf');
      await file.writeAsBytes(await pdf.save());

      debugPrint('PDF exported to: ${file.path}');
      return file;
    } catch (e) {
      debugPrint('Error exporting to PDF: $e');
      return null;
    }
  }

  /// Export assessment results to CSV file
  static Future<File?> exportToCSVFile(
    PremiumQuestionnaireResult result, {
    required String userName,
  }) async {
    try {
      final List<List<dynamic>> rows = [];

      rows.add(['MySchema Assessment Results']);
      rows.add(['User', userName]);
      rows.add(['Date', result.completedAt.toString().split('.')[0]]);
      rows.add(['Questions', result.totalQuestions]);
      rows.add([]);
      rows.add(['Schema Scores']);
      rows.add(['Schema', 'Score']);

      for (final entry in result.schemaScores.entries) {
        final schema = SchemaTherapyDatabase.getSchemaById(entry.key);
        rows.add([schema?.nameEn ?? 'Unknown', entry.value.toStringAsFixed(2)]);
      }

      rows.add([]);
      rows.add(['Domain Scores']);
      rows.add(['Domain', 'Score']);

      for (final entry in result.domainScores.entries) {
        rows.add([_getDomainName(entry.key), entry.value.toStringAsFixed(2)]);
      }

      final csv = const ListToCsvConverter().convert(rows);

      final output = await getApplicationDocumentsDirectory();
      final file = File('${output.path}/assessment_${DateTime.now().millisecondsSinceEpoch}.csv');
      await file.writeAsString(csv);

      debugPrint('CSV exported to: ${file.path}');
      return file;
    } catch (e) {
      debugPrint('Error exporting to CSV: $e');
      return null;
    }
  }
}

