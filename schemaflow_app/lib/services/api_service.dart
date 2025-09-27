import 'dart:convert';
import 'package:http/http.dart' as http;

/// Service class for handling all API communication with the FastAPI backend
class ApiService {
  // Base URL for the FastAPI backend (local development)
  static const String _baseUrl = "http://127.0.0.1:8000";
  
  // API Key for authentication (X-API-Key header)
  // This should match the MY_APP_SECRET_KEY in your FastAPI backend's .env file
  static const String _apiKey = "schema-therapy-flutter-api-key-2024";
  
  // Singleton pattern for API service
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();
  
  /// Common headers for all API requests
  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'X-API-Key': _apiKey,
  };
  
  /// Analyze schemas using the FastAPI backend
  /// 
  /// Takes a list of schema names and returns the AI analysis text
  /// 
  /// Example usage:
  /// ```dart
  /// final analysis = await ApiService().analyzeSchemas(['Terk Edilme', 'Kusurluluk']);
  /// print(analysis);
  /// ```
  Future<String> analyzeSchemas(List<String> schemas) async {
    try {
      // Prepare the request URL
      final url = Uri.parse('$_baseUrl/analyze-schemas/');
      
      // Prepare the request body
      final body = jsonEncode({
        'schemas': schemas,
      });
      
      print('🔄 Making API request to: $url');
      print('📤 Request body: $body');
      
      // Make the POST request
      final response = await http.post(
        url,
        headers: _headers,
        body: body,
      );
      
      print('📥 Response status: ${response.statusCode}');
      print('📥 Response body: ${response.body}');
      
      // Check if the request was successful
      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        
        // Extract the analysis text from the response
        final String analysis = responseData['analysis'] ?? 'No analysis available';
        
        print('✅ API request successful');
        return analysis;
        
      } else {
        // Handle HTTP errors
        final errorMessage = 'API request failed with status ${response.statusCode}: ${response.body}';
        print('❌ $errorMessage');
        throw Exception(errorMessage);
      }
      
    } catch (e) {
      // Handle network or parsing errors
      final errorMessage = 'Failed to analyze schemas: $e';
      print('❌ $errorMessage');
      throw Exception(errorMessage);
    }
  }
  
  /// Test the API connection
  /// 
  /// This method can be used to verify that the backend is reachable
  Future<bool> testConnection() async {
    try {
      final url = Uri.parse('$_baseUrl/');
      final response = await http.get(url);
      
      print('🔍 Testing API connection...');
      print('📥 Response status: ${response.statusCode}');
      
      return response.statusCode == 200;
    } catch (e) {
      print('❌ API connection test failed: $e');
      return false;
    }
  }
  
  /// Get API health status
  /// 
  /// Useful for checking if the backend is running and healthy
  Future<Map<String, dynamic>?> getHealthStatus() async {
    try {
      final url = Uri.parse('$_baseUrl/health');
      final response = await http.get(url, headers: _headers);
      
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return null;
    } catch (e) {
      print('❌ Health check failed: $e');
      return null;
    }
  }
}
