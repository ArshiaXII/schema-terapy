// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'MySchema';

  @override
  String get startTestButton => 'Start Test';

  @override
  String get question1 =>
      'I worry that people I feel close to will leave or abandon me.';

  @override
  String get question2 =>
      'I feel that I am fundamentally flawed or defective as a person.';

  @override
  String get question3 =>
      'I have trouble trusting people because I expect them to hurt or betray me.';

  @override
  String get question4 =>
      'I feel like I don\'t fit in anywhere or belong with any group of people.';

  @override
  String get question5 =>
      'I rarely get the love, attention, and affection I need from others.';

  @override
  String get question6 =>
      'I feel like I\'m not as capable or accomplished as most people.';

  @override
  String get question7 =>
      'I have trouble making decisions and managing daily responsibilities on my own.';

  @override
  String get question8 =>
      'I worry constantly about potential disasters or bad things happening.';

  @override
  String get question9 =>
      'I have trouble maintaining my own identity in close relationships.';

  @override
  String get question10 =>
      'I often sacrifice my own needs to please others or avoid conflict.';

  @override
  String get categoryAbandonment => 'Abandonment';

  @override
  String get categoryDefectiveness => 'Defectiveness';

  @override
  String get categoryMistrust => 'Mistrust';

  @override
  String get categorySocialIsolation => 'Social Isolation';

  @override
  String get categoryEmotionalDeprivation => 'Emotional Deprivation';

  @override
  String get categoryFailure => 'Failure';

  @override
  String get categoryDependence => 'Dependence';

  @override
  String get categoryVulnerability => 'Vulnerability';

  @override
  String get categoryEnmeshment => 'Enmeshment';

  @override
  String get categorySubjugation => 'Subjugation';

  @override
  String get notAtAll => 'Not at all';

  @override
  String get completely => 'Completely';

  @override
  String get howMuchApplies => 'How much does this apply to you?';

  @override
  String questionProgress(int current, int total) {
    return 'Question $current of $total';
  }

  @override
  String get analyzingAnswers => 'Analyzing your answers...';

  @override
  String get analysisMayTakeTime => 'This may take a few moments';

  @override
  String get appTagline => 'Your Path to Self-Understanding';

  @override
  String get authCreateAccount => 'Create Account';

  @override
  String get authWelcomeBack => 'Welcome Back';

  @override
  String get authFullNameLabel => 'Full Name';

  @override
  String get authEmailLabel => 'Email';

  @override
  String get authPasswordLabel => 'Password';

  @override
  String get authPleaseEnterName => 'Please enter your name';

  @override
  String get authPleaseEnterEmail => 'Please enter your email';

  @override
  String get authPleaseEnterValidEmail => 'Please enter a valid email';

  @override
  String get authPleaseEnterPassword => 'Please enter your password';

  @override
  String get authPasswordMin => 'Password must be at least 6 characters';

  @override
  String get authSignIn => 'Sign In';

  @override
  String get authSignUp => 'Sign Up';

  @override
  String get authOrContinueWith => 'Or continue with';

  @override
  String get authGoogle => 'Google';

  @override
  String get authApple => 'Apple';

  @override
  String get authGoogleSoon => 'Google sign in coming soon!';

  @override
  String get authAppleSoon => 'Apple sign in coming soon!';

  @override
  String get authAlreadyHaveAccount => 'Already have an account?';

  @override
  String get authDontHaveAccount => 'Don\'t have an account?';

  @override
  String get splashTagline => 'Your Path to Self-Understanding';

  @override
  String get mockAnalysisFallback =>
      'This schema represents a significant pattern in your psychological makeup that affects how you perceive yourself and relate to others. Understanding this pattern is the first step toward personal growth and healing.';

  @override
  String get next => 'Next';

  @override
  String get complete => 'Complete';

  @override
  String get userDefaultName => 'User';

  @override
  String greetingHello(String name) {
    return 'Hello, $name! 👋';
  }

  @override
  String get homeExplorePrompt => 'Ready to explore your inner world?';

  @override
  String get analysisReady => 'Your Analysis is Ready!';

  @override
  String get analysisAwaits => 'Your Analysis Awaits';

  @override
  String get viewResults => 'View Results';

  @override
  String get beginQuestionnaire => 'Begin Questionnaire';

  @override
  String get progress => 'Progress';

  @override
  String get status => 'Status';

  @override
  String get premium => 'Premium';

  @override
  String get free => 'Free';

  @override
  String get yourJourney => 'Your Journey';

  @override
  String get schemaAnalysisReport => 'Schema Analysis Report';

  @override
  String get completedToday => 'Completed today';

  @override
  String get noReportsYet => 'No reports yet';

  @override
  String get completeFirstQuestionnaire =>
      'Complete your first questionnaire to see your analysis here.';

  @override
  String get homeCompletedDescription =>
      'Explore your detailed analysis and insights.';

  @override
  String get homePromptDescription =>
      'Start your first questionnaire to get a personalized analysis.';

  @override
  String get paywallPurchaseFailedPrefix => 'Purchase failed: ';

  @override
  String get paywallPurchaseFailed =>
      'Purchase could not be completed. Please try again.';

  @override
  String get paywallNoPurchaseAvailable =>
      'No purchase options available at this time. Please try again later.';

  @override
  String get paywallHeaderTitle => 'Unlock Your Full Schema Analysis';

  @override
  String get paywallHeaderSubtitle =>
      'Get your complete report with insights, exercises, and AI chat.';

  @override
  String get paywallFeatureCompleteTitle => 'Complete Report';

  @override
  String get paywallFeatureCompleteDesc =>
      'Detailed analysis of all your schemas with personalized insights.';

  @override
  String get paywallFeatureRelationshipTitle => 'Relationships & Career';

  @override
  String get paywallFeatureRelationshipDesc =>
      'See how your schemas impact love, friendships, and work.';

  @override
  String get paywallFeatureOriginsTitle => 'Origins & Patterns';

  @override
  String get paywallFeatureOriginsDesc =>
      'Understand where your patterns come from and why they persist.';

  @override
  String get paywallFeatureGrowthTitle => 'Growth Plan';

  @override
  String get paywallFeatureGrowthDesc =>
      'Actionable steps and exercises to support healing.';

  @override
  String get paywallFeatureAiChatTitle => 'AI Chat';

  @override
  String get paywallFeatureAiChatDesc =>
      'Ask questions and get guidance tailored to your results.';

  @override
  String get paywallSummaryTitle =>
      'You\'re moments away from your personalized guidance';

  @override
  String get paywallSummarySubtitle => 'One-time purchase. Lifetime access.';

  @override
  String get paywallPrice => '\$9.99';

  @override
  String get paywallSummaryNote => 'Cancel anytime in settings.';

  @override
  String get paywallRecommendedBadge => 'RECOMMENDED';

  @override
  String get paywallConfirmCta => 'Get My Full Report';

  @override
  String get paywallRestorePurchase => 'Restore Purchase';

  @override
  String get paywallRestoreSoon => 'Restore purchase coming soon!';

  @override
  String paywallUnlockCta(String price) {
    return 'Unlock Full Report ($price)';
  }

  @override
  String get teaserAppBarTitle => 'Analysis Preview';

  @override
  String get teaserBadgeInitial => 'Initial Analysis Preview';

  @override
  String get teaserHeaderTitle => 'Your Personality Analysis';

  @override
  String get teaserHeaderSubtitle =>
      'Based on your responses, we\'ve identified your primary psychological pattern.';

  @override
  String get teaserPrimaryTendency => 'Your Primary Tendency';

  @override
  String get teaserSectionTitle => 'Analysis Preview';

  @override
  String get teaserUnlockNote => 'Unlock to read more';

  @override
  String get teaserCtaHeading => 'This is just the beginning';

  @override
  String get teaserCtaIntro => 'The full report will reveal:';

  @override
  String get teaserBenefit1 =>
      'How this schema affects your relationships and career';

  @override
  String get teaserBenefit2 =>
      'The origins of this pattern in your past experiences';

  @override
  String get teaserBenefit3 => 'Personalized steps for growth and healing';

  @override
  String get teaserBenefit4 => 'Detailed coping strategies and exercises';

  @override
  String get teaserBenefit5 =>
      'Professional insights from schema therapy experts';

  @override
  String get resultsFabChatWithAi => 'Chat with AI';

  @override
  String get resultsAppBarTitle => 'Your Schema Profile';

  @override
  String get resultsShareSoon => 'Share feature coming soon!';

  @override
  String get resultsProfileTitle => 'The Perfectionist';

  @override
  String get resultsProfileSubtitle => 'High Standards & Achievement Profile';

  @override
  String get resultsCompletedToday => 'Analysis completed today';

  @override
  String resultsScoreLabel(double score) {
    return 'Score: $score/6.0';
  }

  @override
  String get resultsSectionOverview => 'General Overview';

  @override
  String get resultsSectionEffects => 'Potential Effects';

  @override
  String get resultsSectionNextSteps => 'Next Steps';

  @override
  String get resultsSeverityLow => 'Low';

  @override
  String get resultsSeverityModerate => 'Moderate';

  @override
  String get resultsSeverityHigh => 'High';

  @override
  String get chatWelcomeMessage =>
      'Hello! I\'m your AI Schema Analyst. I\'ve reviewed your questionnaire results and I\'m here to help you understand your schema profile better.\n\nYou can ask me questions like:\n• \"Why do I have such high perfectionism?\"\n• \"How can I work on my abandonment fears?\"\n• \"What\'s the connection between my schemas?\"\n• \"Can you give me specific exercises for my situation?\"\n\nWhat would you like to explore about your results?';

  @override
  String get chatRespPerfectionism =>
      'I can see you\'re interested in understanding your perfectionism better. Based on your high score in this area, this is indeed one of your dominant schemas.\n\nPerfectionism often develops when we learn early in life that our worth depends on flawless performance. Here are some key insights:\n\nWhy it developed: Likely from childhood experiences where mistakes were criticized or where love felt conditional on achievement.\nHow it shows up: You probably set extremely high standards, have trouble delegating, and feel anxious when things aren\'t just right.\nWorking with it: Start by identifying areas where \'good enough\' is sufficient. Practice the 80/20 rule—often 80% effort gives you the results you need.\n\nWould you like me to suggest some specific exercises for managing perfectionist tendencies?';

  @override
  String get chatRespAbandonment =>
      'Abandonment fears can be really challenging, especially in close relationships. Your results show this is an area where you experience significant distress.\n\nUnderstanding the pattern: You might find yourself either clinging too tightly to relationships or pushing people away before they can leave you.\nThe underlying fear: \'People I care about will inevitably leave me or be taken away.\'\n\nHealing approaches:\n• Practice self-soothing techniques when you feel that familiar panic\n• Communicate your needs directly rather than testing relationships\n• Build a support network so you\'re not dependent on one person\n\nRemember, this schema developed as a protection mechanism. Your brain learned to be hypervigilant about abandonment to keep you safe.\n\nWhat specific relationship patterns have you noticed in yourself?';

  @override
  String get chatRespExercises =>
      'Great question! Here are some practical exercises tailored to your schema profile:\n\nFor Perfectionism:\n1) The \'Good Enough\' Challenge: Choose one task daily where you intentionally aim for 80% instead of 100%\n2) Mistake Journal: Write down one mistake daily and one thing you learned from it\n3) Time Boxing: Set strict time limits for tasks to prevent endless tweaking\n\nFor Abandonment Fears:\n1) Soothing Kit: Create a list of 5 things that comfort you when you feel abandoned\n2) Reality Testing: When you feel someone is pulling away, write down 3 alternative explanations\n3) Independence Building: Do one enjoyable activity alone each week\n\nGeneral Schema Work:\n• Daily mindfulness practice (even 5 minutes helps)\n• Schema journaling: Notice when schemas are triggered\n• Self-compassion breaks when you catch yourself in schema mode\n\nWhich of these resonates most with you? I can provide more detailed guidance on any specific exercise.';

  @override
  String get chatRespDefault =>
      'That\'s a thoughtful question. Based on your schema profile, I can see you\'re really committed to understanding yourself better.\n\nYour dominant schemas (Perfectionism and Abandonment) often work together—the fear of being left can drive perfectionist behaviors as a way to prevent abandonment.\n\nHere\'s what I\'d suggest exploring:\n• How these patterns first developed in your life\n• What triggers them most strongly now\n• Small, manageable steps to work with them\n\nSchema work is a journey, not a destination. Be patient and compassionate with yourself as you explore these deep patterns.\n\nIs there a specific situation or relationship where you\'d like to understand your schemas better?';

  @override
  String get chatTitle => 'AI Schema Analyst';

  @override
  String get chatOnline => 'Online';

  @override
  String get chatInputHint => 'Ask about your schema results...';

  @override
  String get profileSignOutTitle => 'Sign Out';

  @override
  String get profileSignOutQuestion => 'Are you sure you want to sign out?';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonSignOut => 'Sign Out';

  @override
  String get profileFailedSignOutPrefix => 'Failed to sign out: ';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileSubscriptionStatus => 'Subscription Status';

  @override
  String get profileCurrentPlan => 'Current Plan';

  @override
  String get profileMemberSince => 'Member Since';

  @override
  String get profileUpgradeSoon => 'Upgrade feature coming soon!';

  @override
  String get profileUpgradePremium => 'Upgrade to Premium';

  @override
  String get profileEditTitle => 'Edit Profile';

  @override
  String get profileEditSubtitle => 'Update your name and email';

  @override
  String get profileEditSoon => 'Edit profile coming soon!';

  @override
  String get profileManageSubTitle => 'Manage Subscription';

  @override
  String get profileManageSubSubtitle => 'View billing and cancel subscription';

  @override
  String get profileManageSubSoon => 'Subscription management coming soon!';

  @override
  String get profileLanguageTitle => 'Language / Dil';

  @override
  String get profileHelpTitle => 'Help & Support';

  @override
  String get profileHelpSubtitle => 'Get help with your account';

  @override
  String get profileHelpSoon => 'Help & support coming soon!';

  @override
  String get profilePrivacyTitle => 'Privacy Policy';

  @override
  String get profilePrivacySubtitle => 'Read our privacy policy';

  @override
  String get profilePrivacySoon => 'Privacy policy coming soon!';

  @override
  String get profileSignOutButton => 'Sign Out';

  @override
  String get citationsTitle => 'Medical & Research Sources';

  @override
  String get citationsDescription =>
      'This analysis is based on Schema Therapy, a scientifically-validated psychotherapy approach.';

  @override
  String get citationSchemaTherapy =>
      'Schema Therapy: A Practitioner\'s Guide by Jeffrey E. Young, Janet S. Klosko, and Marjorie E. Weishaar';

  @override
  String get citationResearch =>
      'Research on Schema Therapy effectiveness published in peer-reviewed journals';

  @override
  String get citationDisclaimer =>
      'This app provides educational information and is not a substitute for professional mental health treatment. Please consult with a licensed therapist or mental health professional for diagnosis and treatment.';

  @override
  String get learnMore => 'Learn More';

  @override
  String get helpTitle => 'Help & Support';

  @override
  String get helpFaqTitle => 'Frequently Asked Questions';

  @override
  String get helpContactTitle => 'Contact Support';

  @override
  String get helpContactEmail => 'support@myschema.app';

  @override
  String get helpFaq1 => 'What is Schema Therapy?';

  @override
  String get helpFaq1Answer =>
      'Schema Therapy is an integrative psychotherapy approach that combines elements of cognitive-behavioral therapy, attachment theory, and emotion-focused therapy. It helps identify and change deep-rooted patterns of thinking and behavior.';

  @override
  String get helpFaq2 => 'How accurate is this assessment?';

  @override
  String get helpFaq2Answer =>
      'This assessment is based on validated schema therapy questionnaires. However, it\'s designed for self-awareness and educational purposes. For a professional diagnosis, please consult with a licensed therapist.';

  @override
  String get helpFaq3 => 'Can I retake the questionnaire?';

  @override
  String get helpFaq3Answer =>
      'Yes, you can retake the questionnaire anytime from the home screen. Your new results will replace the previous ones.';

  @override
  String get helpFaq4 => 'Is my data private?';

  @override
  String get helpFaq4Answer =>
      'Yes, your data is encrypted and stored securely. We never share your personal information with third parties.';

  @override
  String get helpEmailSubject => 'MySchema Support Request';

  @override
  String get helpEmailBody =>
      'Hello,\n\nI need help with MySchema app:\n\n[Please describe your issue here]\n\nThank you!';

  @override
  String get detailedAssessment => 'Detailed Schema Assessment';

  @override
  String get question => 'Question';

  @override
  String get pleaseAnswerAllQuestions =>
      'Please answer all questions before submitting';

  @override
  String get previous => 'Previous';

  @override
  String get submit => 'Submit';

  @override
  String get completelyDisagree => 'Completely Disagree';

  @override
  String get mostlyDisagree => 'Mostly Disagree';

  @override
  String get slightlyDisagree => 'Slightly Disagree';

  @override
  String get slightlyAgree => 'Slightly Agree';

  @override
  String get mostlyAgree => 'Mostly Agree';

  @override
  String get completelyAgree => 'Completely Agree';

  @override
  String get yourResults => 'Your Assessment Results';

  @override
  String get assessmentSummary => 'Assessment Summary';

  @override
  String get totalQuestions => 'Total Questions';

  @override
  String get completedAt => 'Completed At';

  @override
  String get dominantSchemas => 'Your Dominant Schemas';

  @override
  String get domainBreakdown => 'Domain Breakdown';

  @override
  String get backToHome => 'Back to Home';

  @override
  String get therapyRecommendations => 'Therapy Recommendations';

  @override
  String get personalizedTherapyPlan => 'Personalized Therapy Plan';

  @override
  String get recommendedApproach => 'Recommended Approach';

  @override
  String get suggestedPractices => 'Suggested Practices';

  @override
  String get schemaEducation => 'Schema Education';

  @override
  String get assessmentProgress => 'Assessment Progress';

  @override
  String get progressTracking => 'Progress Tracking';

  @override
  String get yourAssessmentHistory => 'Your Assessment History';

  @override
  String get schemaScoreTrends => 'Schema Score Trends';

  @override
  String get noAssessmentHistory => 'No assessment history yet';

  @override
  String get completeAssessments =>
      'Complete assessments to see your progress over time';

  @override
  String get exportResults => 'Export Results';

  @override
  String get exportAsText => 'Export as Text';

  @override
  String get exportAsCSV => 'Export as CSV';

  @override
  String get shareSummary => 'Share Summary';

  @override
  String get copiedToClipboard => 'Copied to clipboard!';

  @override
  String get viewProgress => 'View Progress';

  @override
  String get premiumFeatures => 'Premium Features';

  @override
  String get detailedAssessmentTitle => 'Detailed Assessment';

  @override
  String get detailedAssessmentSubtitle => 'Deep Analysis';

  @override
  String get schemaEducationTitle => 'Schema Education';

  @override
  String get schemaEducationSubtitle => 'Learn More';

  @override
  String get progressTrackingTitle => 'Progress Tracking';

  @override
  String get progressTrackingSubtitle => 'Your Journey';

  @override
  String get recommendationsTitle => 'Recommendations';

  @override
  String get recommendationsSubtitle => 'Personalized';

  @override
  String get schemaChatTitle => 'Schema Chat';

  @override
  String get schemaChatSubtitle => 'AI Assistant';

  @override
  String get difficultyToHeal => 'Difficulty to Heal';

  @override
  String get impactLevel => 'Impact Level';

  @override
  String whatIsSchema(String schema) {
    return 'What is $schema?';
  }

  @override
  String get childhoodOrigins => 'Childhood Origins';

  @override
  String get howThisSchemaAffectsYou => 'How This Schema Affects You';

  @override
  String get pathToHealing => 'Path to Healing';

  @override
  String get overview => 'Overview';

  @override
  String get origins => 'Origins';

  @override
  String get effects => 'Effects';

  @override
  String get healing => 'Healing';

  @override
  String get completeDetailedAssessmentFirst =>
      'Please complete the Detailed Assessment first';
}
