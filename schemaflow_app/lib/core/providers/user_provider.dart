import 'package:flutter/foundation.dart';
import '../../models/schema_therapy_data.dart';

/// User subscription types
enum SubscriptionType { none, monthly, yearly }

/// Assessment history entry
class AssessmentHistory {
  final DateTime completedAt;
  final Map<int, double> schemaScores;
  final Map<int, double> domainScores;
  final int totalQuestions;

  const AssessmentHistory({
    required this.completedAt,
    required this.schemaScores,
    required this.domainScores,
    required this.totalQuestions,
  });
}

/// User model for SchemaFlow app
class User {
  final String id;
  final String name;
  final String email;
  final SubscriptionType subscriptionType;
  final DateTime? subscriptionStartDate;
  final bool hasCompletedQuestionnaire;
  final Map<String, dynamic>? schemaResults;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.subscriptionType = SubscriptionType.none,
    this.subscriptionStartDate,
    this.hasCompletedQuestionnaire = false,
    this.schemaResults,
  });

  bool get isPremium => subscriptionType != SubscriptionType.none;
  
  bool get canViewDetailedResults => isPremium;
  
  bool get canUseChatFeature => isPremium;
  
  String get subscriptionDisplayName {
    switch (subscriptionType) {
      case SubscriptionType.monthly:
        return 'Monthly Premium';
      case SubscriptionType.yearly:
        return 'Yearly Premium';
      case SubscriptionType.none:
        return 'Free';
    }
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    SubscriptionType? subscriptionType,
    DateTime? subscriptionStartDate,
    bool? hasCompletedQuestionnaire,
    Map<String, dynamic>? schemaResults,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      subscriptionType: subscriptionType ?? this.subscriptionType,
      subscriptionStartDate: subscriptionStartDate ?? this.subscriptionStartDate,
      hasCompletedQuestionnaire: hasCompletedQuestionnaire ?? this.hasCompletedQuestionnaire,
      schemaResults: schemaResults ?? this.schemaResults,
    );
  }
}

/// User state provider using ChangeNotifier
class UserProvider extends ChangeNotifier {
  User? _currentUser;
  bool _isAuthenticated = false;
  bool _isLoading = false;
  PremiumQuestionnaireResult? _premiumQuestionnaireResult;
  final List<AssessmentHistory> _assessmentHistory = [];

  // Getters
  User? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  bool get isPremium => _currentUser?.isPremium ?? false;
  bool get hasCompletedQuestionnaire => _currentUser?.hasCompletedQuestionnaire ?? false;
  bool get canUseChatFeature => _currentUser?.canUseChatFeature ?? false;
  PremiumQuestionnaireResult? get premiumQuestionnaireResult => _premiumQuestionnaireResult;
  List<AssessmentHistory> get assessmentHistory => _assessmentHistory;
  AssessmentHistory? get latestAssessment => _assessmentHistory.isNotEmpty ? _assessmentHistory.last : null;

  // Authentication methods
  Future<void> signIn(String email, String password) async {
    _setLoading(true);
    
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock user data - replace with actual API call
      _currentUser = User(
        id: '1',
        name: email.split('@')[0].replaceAll('.', ' ').split(' ')
            .map((word) => word[0].toUpperCase() + word.substring(1))
            .join(' '),
        email: email,
        subscriptionType: SubscriptionType.none,
        hasCompletedQuestionnaire: false,
      );
      
      _isAuthenticated = true;
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    _setLoading(true);
    
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock user creation - replace with actual API call
      _currentUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        subscriptionType: SubscriptionType.none,
        hasCompletedQuestionnaire: false,
      );
      
      _isAuthenticated = true;
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut() async {
    _setLoading(true);
    
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));
      
      _currentUser = null;
      _isAuthenticated = false;
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Subscription methods
  Future<void> subscribeToPremium(SubscriptionType type) async {
    if (_currentUser == null) return;
    
    _setLoading(true);
    
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));
      
      _currentUser = _currentUser!.copyWith(
        subscriptionType: type,
        subscriptionStartDate: DateTime.now(),
      );
      
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to subscribe: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> cancelSubscription() async {
    if (_currentUser == null) return;
    
    _setLoading(true);
    
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));
      
      _currentUser = _currentUser!.copyWith(
        subscriptionType: SubscriptionType.none,
        subscriptionStartDate: null,
      );
      
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to cancel subscription: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Questionnaire methods
  Future<void> completeQuestionnaire(Map<String, dynamic> results) async {
    if (_currentUser == null) return;

    _setLoading(true);

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 3));

      _currentUser = _currentUser!.copyWith(
        hasCompletedQuestionnaire: true,
        schemaResults: results,
      );

      notifyListeners();
    } catch (e) {
      throw Exception('Failed to save questionnaire results: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Profile methods
  Future<void> updateProfile({String? name, String? email}) async {
    if (_currentUser == null) return;
    
    _setLoading(true);
    
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));
      
      _currentUser = _currentUser!.copyWith(
        name: name ?? _currentUser!.name,
        email: email ?? _currentUser!.email,
      );
      
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Premium questionnaire methods
  void setPremiumQuestionnaireResult(PremiumQuestionnaireResult result) {
    _premiumQuestionnaireResult = result;
    notifyListeners();
  }

  void clearPremiumQuestionnaireResult() {
    _premiumQuestionnaireResult = null;
    notifyListeners();
  }

  // Assessment history methods
  void addAssessmentToHistory(PremiumQuestionnaireResult result) {
    _assessmentHistory.add(
      AssessmentHistory(
        completedAt: result.completedAt,
        schemaScores: result.schemaScores,
        domainScores: result.domainScores,
        totalQuestions: result.totalQuestions,
      ),
    );
    notifyListeners();
  }

  void clearAssessmentHistory() {
    _assessmentHistory.clear();
    notifyListeners();
  }

  // Helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Initialize user session (call this on app start)
  Future<void> initializeUser() async {
    _setLoading(true);
    
    try {
      // Check for stored authentication token/session
      // This is where you'd check SharedPreferences or secure storage
      await Future.delayed(const Duration(seconds: 1));
      
      // For demo purposes, we'll start with no authenticated user
      _isAuthenticated = false;
      _currentUser = null;
      
    } catch (e) {
      debugPrint('Failed to initialize user: $e');
    } finally {
      _setLoading(false);
    }
  }
}
