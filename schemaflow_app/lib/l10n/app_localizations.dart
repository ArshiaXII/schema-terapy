import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'MySchema'**
  String get appTitle;

  /// Button text to start the schema test
  ///
  /// In en, this message translates to:
  /// **'Start Test'**
  String get startTestButton;

  /// No description provided for @question1.
  ///
  /// In en, this message translates to:
  /// **'I worry that people I feel close to will leave or abandon me.'**
  String get question1;

  /// No description provided for @question2.
  ///
  /// In en, this message translates to:
  /// **'I feel that I am fundamentally flawed or defective as a person.'**
  String get question2;

  /// No description provided for @question3.
  ///
  /// In en, this message translates to:
  /// **'I have trouble trusting people because I expect them to hurt or betray me.'**
  String get question3;

  /// No description provided for @question4.
  ///
  /// In en, this message translates to:
  /// **'I feel like I don\'t fit in anywhere or belong with any group of people.'**
  String get question4;

  /// No description provided for @question5.
  ///
  /// In en, this message translates to:
  /// **'I rarely get the love, attention, and affection I need from others.'**
  String get question5;

  /// No description provided for @question6.
  ///
  /// In en, this message translates to:
  /// **'I feel like I\'m not as capable or accomplished as most people.'**
  String get question6;

  /// No description provided for @question7.
  ///
  /// In en, this message translates to:
  /// **'I have trouble making decisions and managing daily responsibilities on my own.'**
  String get question7;

  /// No description provided for @question8.
  ///
  /// In en, this message translates to:
  /// **'I worry constantly about potential disasters or bad things happening.'**
  String get question8;

  /// No description provided for @question9.
  ///
  /// In en, this message translates to:
  /// **'I have trouble maintaining my own identity in close relationships.'**
  String get question9;

  /// No description provided for @question10.
  ///
  /// In en, this message translates to:
  /// **'I often sacrifice my own needs to please others or avoid conflict.'**
  String get question10;

  /// No description provided for @categoryAbandonment.
  ///
  /// In en, this message translates to:
  /// **'Abandonment'**
  String get categoryAbandonment;

  /// No description provided for @categoryDefectiveness.
  ///
  /// In en, this message translates to:
  /// **'Defectiveness'**
  String get categoryDefectiveness;

  /// No description provided for @categoryMistrust.
  ///
  /// In en, this message translates to:
  /// **'Mistrust'**
  String get categoryMistrust;

  /// No description provided for @categorySocialIsolation.
  ///
  /// In en, this message translates to:
  /// **'Social Isolation'**
  String get categorySocialIsolation;

  /// No description provided for @categoryEmotionalDeprivation.
  ///
  /// In en, this message translates to:
  /// **'Emotional Deprivation'**
  String get categoryEmotionalDeprivation;

  /// No description provided for @categoryFailure.
  ///
  /// In en, this message translates to:
  /// **'Failure'**
  String get categoryFailure;

  /// No description provided for @categoryDependence.
  ///
  /// In en, this message translates to:
  /// **'Dependence'**
  String get categoryDependence;

  /// No description provided for @categoryVulnerability.
  ///
  /// In en, this message translates to:
  /// **'Vulnerability'**
  String get categoryVulnerability;

  /// No description provided for @categoryEnmeshment.
  ///
  /// In en, this message translates to:
  /// **'Enmeshment'**
  String get categoryEnmeshment;

  /// No description provided for @categorySubjugation.
  ///
  /// In en, this message translates to:
  /// **'Subjugation'**
  String get categorySubjugation;

  /// No description provided for @notAtAll.
  ///
  /// In en, this message translates to:
  /// **'Not at all'**
  String get notAtAll;

  /// No description provided for @completely.
  ///
  /// In en, this message translates to:
  /// **'Completely'**
  String get completely;

  /// No description provided for @howMuchApplies.
  ///
  /// In en, this message translates to:
  /// **'How much does this apply to you?'**
  String get howMuchApplies;

  /// No description provided for @questionProgress.
  ///
  /// In en, this message translates to:
  /// **'Question {current} of {total}'**
  String questionProgress(int current, int total);

  /// No description provided for @analyzingAnswers.
  ///
  /// In en, this message translates to:
  /// **'Analyzing your answers...'**
  String get analyzingAnswers;

  /// No description provided for @analysisMayTakeTime.
  ///
  /// In en, this message translates to:
  /// **'This may take a few moments'**
  String get analysisMayTakeTime;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'Your Path to Self-Understanding'**
  String get appTagline;

  /// No description provided for @authCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get authCreateAccount;

  /// No description provided for @authWelcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get authWelcomeBack;

  /// No description provided for @authFullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get authFullNameLabel;

  /// No description provided for @authEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authEmailLabel;

  /// No description provided for @authPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authPasswordLabel;

  /// No description provided for @authPleaseEnterName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get authPleaseEnterName;

  /// No description provided for @authPleaseEnterEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get authPleaseEnterEmail;

  /// No description provided for @authPleaseEnterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get authPleaseEnterValidEmail;

  /// No description provided for @authPleaseEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get authPleaseEnterPassword;

  /// No description provided for @authPasswordMin.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get authPasswordMin;

  /// No description provided for @authSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get authSignIn;

  /// No description provided for @authSignUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get authSignUp;

  /// No description provided for @authOrContinueWith.
  ///
  /// In en, this message translates to:
  /// **'Or continue with'**
  String get authOrContinueWith;

  /// No description provided for @authGoogle.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get authGoogle;

  /// No description provided for @authApple.
  ///
  /// In en, this message translates to:
  /// **'Apple'**
  String get authApple;

  /// No description provided for @authGoogleSoon.
  ///
  /// In en, this message translates to:
  /// **'Google sign in coming soon!'**
  String get authGoogleSoon;

  /// No description provided for @authAppleSoon.
  ///
  /// In en, this message translates to:
  /// **'Apple sign in coming soon!'**
  String get authAppleSoon;

  /// No description provided for @authAlreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get authAlreadyHaveAccount;

  /// No description provided for @authDontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get authDontHaveAccount;

  /// No description provided for @splashTagline.
  ///
  /// In en, this message translates to:
  /// **'Your Path to Self-Understanding'**
  String get splashTagline;

  /// No description provided for @mockAnalysisFallback.
  ///
  /// In en, this message translates to:
  /// **'This schema represents a significant pattern in your psychological makeup that affects how you perceive yourself and relate to others. Understanding this pattern is the first step toward personal growth and healing.'**
  String get mockAnalysisFallback;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @complete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get complete;

  /// No description provided for @userDefaultName.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get userDefaultName;

  /// No description provided for @greetingHello.
  ///
  /// In en, this message translates to:
  /// **'Hello, {name}! 👋'**
  String greetingHello(String name);

  /// No description provided for @homeExplorePrompt.
  ///
  /// In en, this message translates to:
  /// **'Ready to explore your inner world?'**
  String get homeExplorePrompt;

  /// No description provided for @analysisReady.
  ///
  /// In en, this message translates to:
  /// **'Your Analysis is Ready!'**
  String get analysisReady;

  /// No description provided for @analysisAwaits.
  ///
  /// In en, this message translates to:
  /// **'Your Analysis Awaits'**
  String get analysisAwaits;

  /// No description provided for @viewResults.
  ///
  /// In en, this message translates to:
  /// **'View Results'**
  String get viewResults;

  /// No description provided for @beginQuestionnaire.
  ///
  /// In en, this message translates to:
  /// **'Begin Questionnaire'**
  String get beginQuestionnaire;

  /// No description provided for @progress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progress;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @premium.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get premium;

  /// No description provided for @free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get free;

  /// No description provided for @yourJourney.
  ///
  /// In en, this message translates to:
  /// **'Your Journey'**
  String get yourJourney;

  /// No description provided for @schemaAnalysisReport.
  ///
  /// In en, this message translates to:
  /// **'Schema Analysis Report'**
  String get schemaAnalysisReport;

  /// No description provided for @completedToday.
  ///
  /// In en, this message translates to:
  /// **'Completed today'**
  String get completedToday;

  /// No description provided for @noReportsYet.
  ///
  /// In en, this message translates to:
  /// **'No reports yet'**
  String get noReportsYet;

  /// No description provided for @completeFirstQuestionnaire.
  ///
  /// In en, this message translates to:
  /// **'Complete your first questionnaire to see your analysis here.'**
  String get completeFirstQuestionnaire;

  /// No description provided for @homeCompletedDescription.
  ///
  /// In en, this message translates to:
  /// **'Explore your detailed analysis and insights.'**
  String get homeCompletedDescription;

  /// No description provided for @homePromptDescription.
  ///
  /// In en, this message translates to:
  /// **'Start your first questionnaire to get a personalized analysis.'**
  String get homePromptDescription;

  /// No description provided for @paywallPurchaseFailedPrefix.
  ///
  /// In en, this message translates to:
  /// **'Purchase failed: '**
  String get paywallPurchaseFailedPrefix;

  /// No description provided for @paywallPurchaseFailed.
  ///
  /// In en, this message translates to:
  /// **'Purchase could not be completed. Please try again.'**
  String get paywallPurchaseFailed;

  /// No description provided for @paywallNoPurchaseAvailable.
  ///
  /// In en, this message translates to:
  /// **'No purchase options available at this time. Please try again later.'**
  String get paywallNoPurchaseAvailable;

  /// No description provided for @paywallHeaderTitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock Your Full Schema Analysis'**
  String get paywallHeaderTitle;

  /// No description provided for @paywallHeaderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get your complete report with insights, exercises, and AI chat.'**
  String get paywallHeaderSubtitle;

  /// No description provided for @paywallFeatureCompleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Complete Report'**
  String get paywallFeatureCompleteTitle;

  /// No description provided for @paywallFeatureCompleteDesc.
  ///
  /// In en, this message translates to:
  /// **'Detailed analysis of all your schemas with personalized insights.'**
  String get paywallFeatureCompleteDesc;

  /// No description provided for @paywallFeatureRelationshipTitle.
  ///
  /// In en, this message translates to:
  /// **'Relationships & Career'**
  String get paywallFeatureRelationshipTitle;

  /// No description provided for @paywallFeatureRelationshipDesc.
  ///
  /// In en, this message translates to:
  /// **'See how your schemas impact love, friendships, and work.'**
  String get paywallFeatureRelationshipDesc;

  /// No description provided for @paywallFeatureOriginsTitle.
  ///
  /// In en, this message translates to:
  /// **'Origins & Patterns'**
  String get paywallFeatureOriginsTitle;

  /// No description provided for @paywallFeatureOriginsDesc.
  ///
  /// In en, this message translates to:
  /// **'Understand where your patterns come from and why they persist.'**
  String get paywallFeatureOriginsDesc;

  /// No description provided for @paywallFeatureGrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'Growth Plan'**
  String get paywallFeatureGrowthTitle;

  /// No description provided for @paywallFeatureGrowthDesc.
  ///
  /// In en, this message translates to:
  /// **'Actionable steps and exercises to support healing.'**
  String get paywallFeatureGrowthDesc;

  /// No description provided for @paywallFeatureAiChatTitle.
  ///
  /// In en, this message translates to:
  /// **'AI Chat'**
  String get paywallFeatureAiChatTitle;

  /// No description provided for @paywallFeatureAiChatDesc.
  ///
  /// In en, this message translates to:
  /// **'Ask questions and get guidance tailored to your results.'**
  String get paywallFeatureAiChatDesc;

  /// No description provided for @paywallSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re moments away from your personalized guidance'**
  String get paywallSummaryTitle;

  /// No description provided for @paywallSummarySubtitle.
  ///
  /// In en, this message translates to:
  /// **'One-time purchase. Lifetime access.'**
  String get paywallSummarySubtitle;

  /// No description provided for @paywallPrice.
  ///
  /// In en, this message translates to:
  /// **'\$9.99'**
  String get paywallPrice;

  /// No description provided for @paywallSummaryNote.
  ///
  /// In en, this message translates to:
  /// **'Cancel anytime in settings.'**
  String get paywallSummaryNote;

  /// No description provided for @paywallRecommendedBadge.
  ///
  /// In en, this message translates to:
  /// **'RECOMMENDED'**
  String get paywallRecommendedBadge;

  /// No description provided for @paywallConfirmCta.
  ///
  /// In en, this message translates to:
  /// **'Get My Full Report'**
  String get paywallConfirmCta;

  /// No description provided for @paywallRestorePurchase.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchase'**
  String get paywallRestorePurchase;

  /// No description provided for @paywallRestoreSoon.
  ///
  /// In en, this message translates to:
  /// **'Restore purchase coming soon!'**
  String get paywallRestoreSoon;

  /// No description provided for @paywallUnlockCta.
  ///
  /// In en, this message translates to:
  /// **'Unlock Full Report ({price})'**
  String paywallUnlockCta(String price);

  /// No description provided for @teaserAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Analysis Preview'**
  String get teaserAppBarTitle;

  /// No description provided for @teaserBadgeInitial.
  ///
  /// In en, this message translates to:
  /// **'Initial Analysis Preview'**
  String get teaserBadgeInitial;

  /// No description provided for @teaserHeaderTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Personality Analysis'**
  String get teaserHeaderTitle;

  /// No description provided for @teaserHeaderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Based on your responses, we\'ve identified your primary psychological pattern.'**
  String get teaserHeaderSubtitle;

  /// No description provided for @teaserPrimaryTendency.
  ///
  /// In en, this message translates to:
  /// **'Your Primary Tendency'**
  String get teaserPrimaryTendency;

  /// No description provided for @teaserSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Analysis Preview'**
  String get teaserSectionTitle;

  /// No description provided for @teaserUnlockNote.
  ///
  /// In en, this message translates to:
  /// **'Unlock to read more'**
  String get teaserUnlockNote;

  /// No description provided for @teaserCtaHeading.
  ///
  /// In en, this message translates to:
  /// **'This is just the beginning'**
  String get teaserCtaHeading;

  /// No description provided for @teaserCtaIntro.
  ///
  /// In en, this message translates to:
  /// **'The full report will reveal:'**
  String get teaserCtaIntro;

  /// No description provided for @teaserBenefit1.
  ///
  /// In en, this message translates to:
  /// **'How this schema affects your relationships and career'**
  String get teaserBenefit1;

  /// No description provided for @teaserBenefit2.
  ///
  /// In en, this message translates to:
  /// **'The origins of this pattern in your past experiences'**
  String get teaserBenefit2;

  /// No description provided for @teaserBenefit3.
  ///
  /// In en, this message translates to:
  /// **'Personalized steps for growth and healing'**
  String get teaserBenefit3;

  /// No description provided for @teaserBenefit4.
  ///
  /// In en, this message translates to:
  /// **'Detailed coping strategies and exercises'**
  String get teaserBenefit4;

  /// No description provided for @teaserBenefit5.
  ///
  /// In en, this message translates to:
  /// **'Professional insights from schema therapy experts'**
  String get teaserBenefit5;

  /// No description provided for @resultsFabChatWithAi.
  ///
  /// In en, this message translates to:
  /// **'Chat with AI'**
  String get resultsFabChatWithAi;

  /// No description provided for @resultsAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Schema Profile'**
  String get resultsAppBarTitle;

  /// No description provided for @resultsShareSoon.
  ///
  /// In en, this message translates to:
  /// **'Share feature coming soon!'**
  String get resultsShareSoon;

  /// No description provided for @resultsProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'The Perfectionist'**
  String get resultsProfileTitle;

  /// No description provided for @resultsProfileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'High Standards & Achievement Profile'**
  String get resultsProfileSubtitle;

  /// No description provided for @resultsCompletedToday.
  ///
  /// In en, this message translates to:
  /// **'Analysis completed today'**
  String get resultsCompletedToday;

  /// No description provided for @resultsScoreLabel.
  ///
  /// In en, this message translates to:
  /// **'Score: {score}/6.0'**
  String resultsScoreLabel(double score);

  /// No description provided for @resultsSectionOverview.
  ///
  /// In en, this message translates to:
  /// **'General Overview'**
  String get resultsSectionOverview;

  /// No description provided for @resultsSectionEffects.
  ///
  /// In en, this message translates to:
  /// **'Potential Effects'**
  String get resultsSectionEffects;

  /// No description provided for @resultsSectionNextSteps.
  ///
  /// In en, this message translates to:
  /// **'Next Steps'**
  String get resultsSectionNextSteps;

  /// No description provided for @resultsSeverityLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get resultsSeverityLow;

  /// No description provided for @resultsSeverityModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get resultsSeverityModerate;

  /// No description provided for @resultsSeverityHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get resultsSeverityHigh;

  /// No description provided for @chatWelcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Hello! I\'m your AI Schema Analyst. I\'ve reviewed your questionnaire results and I\'m here to help you understand your schema profile better.\n\nYou can ask me questions like:\n• \"Why do I have such high perfectionism?\"\n• \"How can I work on my abandonment fears?\"\n• \"What\'s the connection between my schemas?\"\n• \"Can you give me specific exercises for my situation?\"\n\nWhat would you like to explore about your results?'**
  String get chatWelcomeMessage;

  /// No description provided for @chatRespPerfectionism.
  ///
  /// In en, this message translates to:
  /// **'I can see you\'re interested in understanding your perfectionism better. Based on your high score in this area, this is indeed one of your dominant schemas.\n\nPerfectionism often develops when we learn early in life that our worth depends on flawless performance. Here are some key insights:\n\nWhy it developed: Likely from childhood experiences where mistakes were criticized or where love felt conditional on achievement.\nHow it shows up: You probably set extremely high standards, have trouble delegating, and feel anxious when things aren\'t just right.\nWorking with it: Start by identifying areas where \'good enough\' is sufficient. Practice the 80/20 rule—often 80% effort gives you the results you need.\n\nWould you like me to suggest some specific exercises for managing perfectionist tendencies?'**
  String get chatRespPerfectionism;

  /// No description provided for @chatRespAbandonment.
  ///
  /// In en, this message translates to:
  /// **'Abandonment fears can be really challenging, especially in close relationships. Your results show this is an area where you experience significant distress.\n\nUnderstanding the pattern: You might find yourself either clinging too tightly to relationships or pushing people away before they can leave you.\nThe underlying fear: \'People I care about will inevitably leave me or be taken away.\'\n\nHealing approaches:\n• Practice self-soothing techniques when you feel that familiar panic\n• Communicate your needs directly rather than testing relationships\n• Build a support network so you\'re not dependent on one person\n\nRemember, this schema developed as a protection mechanism. Your brain learned to be hypervigilant about abandonment to keep you safe.\n\nWhat specific relationship patterns have you noticed in yourself?'**
  String get chatRespAbandonment;

  /// No description provided for @chatRespExercises.
  ///
  /// In en, this message translates to:
  /// **'Great question! Here are some practical exercises tailored to your schema profile:\n\nFor Perfectionism:\n1) The \'Good Enough\' Challenge: Choose one task daily where you intentionally aim for 80% instead of 100%\n2) Mistake Journal: Write down one mistake daily and one thing you learned from it\n3) Time Boxing: Set strict time limits for tasks to prevent endless tweaking\n\nFor Abandonment Fears:\n1) Soothing Kit: Create a list of 5 things that comfort you when you feel abandoned\n2) Reality Testing: When you feel someone is pulling away, write down 3 alternative explanations\n3) Independence Building: Do one enjoyable activity alone each week\n\nGeneral Schema Work:\n• Daily mindfulness practice (even 5 minutes helps)\n• Schema journaling: Notice when schemas are triggered\n• Self-compassion breaks when you catch yourself in schema mode\n\nWhich of these resonates most with you? I can provide more detailed guidance on any specific exercise.'**
  String get chatRespExercises;

  /// No description provided for @chatRespDefault.
  ///
  /// In en, this message translates to:
  /// **'That\'s a thoughtful question. Based on your schema profile, I can see you\'re really committed to understanding yourself better.\n\nYour dominant schemas (Perfectionism and Abandonment) often work together—the fear of being left can drive perfectionist behaviors as a way to prevent abandonment.\n\nHere\'s what I\'d suggest exploring:\n• How these patterns first developed in your life\n• What triggers them most strongly now\n• Small, manageable steps to work with them\n\nSchema work is a journey, not a destination. Be patient and compassionate with yourself as you explore these deep patterns.\n\nIs there a specific situation or relationship where you\'d like to understand your schemas better?'**
  String get chatRespDefault;

  /// No description provided for @chatTitle.
  ///
  /// In en, this message translates to:
  /// **'AI Schema Analyst'**
  String get chatTitle;

  /// No description provided for @chatOnline.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get chatOnline;

  /// No description provided for @chatInputHint.
  ///
  /// In en, this message translates to:
  /// **'Ask about your schema results...'**
  String get chatInputHint;

  /// No description provided for @profileSignOutTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get profileSignOutTitle;

  /// No description provided for @profileSignOutQuestion.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get profileSignOutQuestion;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get commonSignOut;

  /// No description provided for @profileFailedSignOutPrefix.
  ///
  /// In en, this message translates to:
  /// **'Failed to sign out: '**
  String get profileFailedSignOutPrefix;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileSubscriptionStatus.
  ///
  /// In en, this message translates to:
  /// **'Subscription Status'**
  String get profileSubscriptionStatus;

  /// No description provided for @profileCurrentPlan.
  ///
  /// In en, this message translates to:
  /// **'Current Plan'**
  String get profileCurrentPlan;

  /// No description provided for @profileMemberSince.
  ///
  /// In en, this message translates to:
  /// **'Member Since'**
  String get profileMemberSince;

  /// No description provided for @profileUpgradeSoon.
  ///
  /// In en, this message translates to:
  /// **'Upgrade feature coming soon!'**
  String get profileUpgradeSoon;

  /// No description provided for @profileUpgradePremium.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium'**
  String get profileUpgradePremium;

  /// No description provided for @profileEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get profileEditTitle;

  /// No description provided for @profileEditSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Update your name and email'**
  String get profileEditSubtitle;

  /// No description provided for @profileEditSoon.
  ///
  /// In en, this message translates to:
  /// **'Edit profile coming soon!'**
  String get profileEditSoon;

  /// No description provided for @profileManageSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Manage Subscription'**
  String get profileManageSubTitle;

  /// No description provided for @profileManageSubSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View billing and cancel subscription'**
  String get profileManageSubSubtitle;

  /// No description provided for @profileManageSubSoon.
  ///
  /// In en, this message translates to:
  /// **'Subscription management coming soon!'**
  String get profileManageSubSoon;

  /// No description provided for @profileLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'Language / Dil'**
  String get profileLanguageTitle;

  /// No description provided for @profileHelpTitle.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get profileHelpTitle;

  /// No description provided for @profileHelpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get help with your account'**
  String get profileHelpSubtitle;

  /// No description provided for @profileHelpSoon.
  ///
  /// In en, this message translates to:
  /// **'Help & support coming soon!'**
  String get profileHelpSoon;

  /// No description provided for @profilePrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get profilePrivacyTitle;

  /// No description provided for @profilePrivacySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Read our privacy policy'**
  String get profilePrivacySubtitle;

  /// No description provided for @profilePrivacySoon.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy coming soon!'**
  String get profilePrivacySoon;

  /// No description provided for @profileSignOutButton.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get profileSignOutButton;

  /// No description provided for @citationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Medical & Research Sources'**
  String get citationsTitle;

  /// No description provided for @citationsDescription.
  ///
  /// In en, this message translates to:
  /// **'This analysis is based on Schema Therapy, a scientifically-validated psychotherapy approach.'**
  String get citationsDescription;

  /// No description provided for @citationSchemaTherapy.
  ///
  /// In en, this message translates to:
  /// **'Schema Therapy: A Practitioner\'s Guide by Jeffrey E. Young, Janet S. Klosko, and Marjorie E. Weishaar'**
  String get citationSchemaTherapy;

  /// No description provided for @citationResearch.
  ///
  /// In en, this message translates to:
  /// **'Research on Schema Therapy effectiveness published in peer-reviewed journals'**
  String get citationResearch;

  /// No description provided for @citationDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'This app provides educational information and is not a substitute for professional mental health treatment. Please consult with a licensed therapist or mental health professional for diagnosis and treatment.'**
  String get citationDisclaimer;

  /// No description provided for @learnMore.
  ///
  /// In en, this message translates to:
  /// **'Learn More'**
  String get learnMore;

  /// No description provided for @helpTitle.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpTitle;

  /// No description provided for @helpFaqTitle.
  ///
  /// In en, this message translates to:
  /// **'Frequently Asked Questions'**
  String get helpFaqTitle;

  /// No description provided for @helpContactTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get helpContactTitle;

  /// No description provided for @helpContactEmail.
  ///
  /// In en, this message translates to:
  /// **'support@myschema.app'**
  String get helpContactEmail;

  /// No description provided for @helpFaq1.
  ///
  /// In en, this message translates to:
  /// **'What is Schema Therapy?'**
  String get helpFaq1;

  /// No description provided for @helpFaq1Answer.
  ///
  /// In en, this message translates to:
  /// **'Schema Therapy is an integrative psychotherapy approach that combines elements of cognitive-behavioral therapy, attachment theory, and emotion-focused therapy. It helps identify and change deep-rooted patterns of thinking and behavior.'**
  String get helpFaq1Answer;

  /// No description provided for @helpFaq2.
  ///
  /// In en, this message translates to:
  /// **'How accurate is this assessment?'**
  String get helpFaq2;

  /// No description provided for @helpFaq2Answer.
  ///
  /// In en, this message translates to:
  /// **'This assessment is based on validated schema therapy questionnaires. However, it\'s designed for self-awareness and educational purposes. For a professional diagnosis, please consult with a licensed therapist.'**
  String get helpFaq2Answer;

  /// No description provided for @helpFaq3.
  ///
  /// In en, this message translates to:
  /// **'Can I retake the questionnaire?'**
  String get helpFaq3;

  /// No description provided for @helpFaq3Answer.
  ///
  /// In en, this message translates to:
  /// **'Yes, you can retake the questionnaire anytime from the home screen. Your new results will replace the previous ones.'**
  String get helpFaq3Answer;

  /// No description provided for @helpFaq4.
  ///
  /// In en, this message translates to:
  /// **'Is my data private?'**
  String get helpFaq4;

  /// No description provided for @helpFaq4Answer.
  ///
  /// In en, this message translates to:
  /// **'Yes, your data is encrypted and stored securely. We never share your personal information with third parties.'**
  String get helpFaq4Answer;

  /// No description provided for @helpEmailSubject.
  ///
  /// In en, this message translates to:
  /// **'MySchema Support Request'**
  String get helpEmailSubject;

  /// No description provided for @helpEmailBody.
  ///
  /// In en, this message translates to:
  /// **'Hello,\n\nI need help with MySchema app:\n\n[Please describe your issue here]\n\nThank you!'**
  String get helpEmailBody;

  /// No description provided for @detailedAssessment.
  ///
  /// In en, this message translates to:
  /// **'Detailed Schema Assessment'**
  String get detailedAssessment;

  /// No description provided for @question.
  ///
  /// In en, this message translates to:
  /// **'Question'**
  String get question;

  /// No description provided for @pleaseAnswerAllQuestions.
  ///
  /// In en, this message translates to:
  /// **'Please answer all questions before submitting'**
  String get pleaseAnswerAllQuestions;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @completelyDisagree.
  ///
  /// In en, this message translates to:
  /// **'Completely Disagree'**
  String get completelyDisagree;

  /// No description provided for @mostlyDisagree.
  ///
  /// In en, this message translates to:
  /// **'Mostly Disagree'**
  String get mostlyDisagree;

  /// No description provided for @slightlyDisagree.
  ///
  /// In en, this message translates to:
  /// **'Slightly Disagree'**
  String get slightlyDisagree;

  /// No description provided for @slightlyAgree.
  ///
  /// In en, this message translates to:
  /// **'Slightly Agree'**
  String get slightlyAgree;

  /// No description provided for @mostlyAgree.
  ///
  /// In en, this message translates to:
  /// **'Mostly Agree'**
  String get mostlyAgree;

  /// No description provided for @completelyAgree.
  ///
  /// In en, this message translates to:
  /// **'Completely Agree'**
  String get completelyAgree;

  /// No description provided for @yourResults.
  ///
  /// In en, this message translates to:
  /// **'Your Assessment Results'**
  String get yourResults;

  /// No description provided for @assessmentSummary.
  ///
  /// In en, this message translates to:
  /// **'Assessment Summary'**
  String get assessmentSummary;

  /// No description provided for @totalQuestions.
  ///
  /// In en, this message translates to:
  /// **'Total Questions'**
  String get totalQuestions;

  /// No description provided for @completedAt.
  ///
  /// In en, this message translates to:
  /// **'Completed At'**
  String get completedAt;

  /// No description provided for @dominantSchemas.
  ///
  /// In en, this message translates to:
  /// **'Your Dominant Schemas'**
  String get dominantSchemas;

  /// No description provided for @domainBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Domain Breakdown'**
  String get domainBreakdown;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// No description provided for @therapyRecommendations.
  ///
  /// In en, this message translates to:
  /// **'Therapy Recommendations'**
  String get therapyRecommendations;

  /// No description provided for @personalizedTherapyPlan.
  ///
  /// In en, this message translates to:
  /// **'Personalized Therapy Plan'**
  String get personalizedTherapyPlan;

  /// No description provided for @recommendedApproach.
  ///
  /// In en, this message translates to:
  /// **'Recommended Approach'**
  String get recommendedApproach;

  /// No description provided for @suggestedPractices.
  ///
  /// In en, this message translates to:
  /// **'Suggested Practices'**
  String get suggestedPractices;

  /// No description provided for @schemaEducation.
  ///
  /// In en, this message translates to:
  /// **'Schema Education'**
  String get schemaEducation;

  /// No description provided for @assessmentProgress.
  ///
  /// In en, this message translates to:
  /// **'Assessment Progress'**
  String get assessmentProgress;

  /// No description provided for @progressTracking.
  ///
  /// In en, this message translates to:
  /// **'Progress Tracking'**
  String get progressTracking;

  /// No description provided for @yourAssessmentHistory.
  ///
  /// In en, this message translates to:
  /// **'Your Assessment History'**
  String get yourAssessmentHistory;

  /// No description provided for @schemaScoreTrends.
  ///
  /// In en, this message translates to:
  /// **'Schema Score Trends'**
  String get schemaScoreTrends;

  /// No description provided for @noAssessmentHistory.
  ///
  /// In en, this message translates to:
  /// **'No assessment history yet'**
  String get noAssessmentHistory;

  /// No description provided for @completeAssessments.
  ///
  /// In en, this message translates to:
  /// **'Complete assessments to see your progress over time'**
  String get completeAssessments;

  /// No description provided for @exportResults.
  ///
  /// In en, this message translates to:
  /// **'Export Results'**
  String get exportResults;

  /// No description provided for @exportAsText.
  ///
  /// In en, this message translates to:
  /// **'Export as Text'**
  String get exportAsText;

  /// No description provided for @exportAsCSV.
  ///
  /// In en, this message translates to:
  /// **'Export as CSV'**
  String get exportAsCSV;

  /// No description provided for @shareSummary.
  ///
  /// In en, this message translates to:
  /// **'Share Summary'**
  String get shareSummary;

  /// No description provided for @copiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard!'**
  String get copiedToClipboard;

  /// No description provided for @viewProgress.
  ///
  /// In en, this message translates to:
  /// **'View Progress'**
  String get viewProgress;

  /// No description provided for @premiumFeatures.
  ///
  /// In en, this message translates to:
  /// **'Premium Features'**
  String get premiumFeatures;

  /// No description provided for @detailedAssessmentTitle.
  ///
  /// In en, this message translates to:
  /// **'Detailed Assessment'**
  String get detailedAssessmentTitle;

  /// No description provided for @detailedAssessmentSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Deep Analysis'**
  String get detailedAssessmentSubtitle;

  /// No description provided for @schemaEducationTitle.
  ///
  /// In en, this message translates to:
  /// **'Schema Education'**
  String get schemaEducationTitle;

  /// No description provided for @schemaEducationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Learn More'**
  String get schemaEducationSubtitle;

  /// No description provided for @progressTrackingTitle.
  ///
  /// In en, this message translates to:
  /// **'Progress Tracking'**
  String get progressTrackingTitle;

  /// No description provided for @progressTrackingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your Journey'**
  String get progressTrackingSubtitle;

  /// No description provided for @recommendationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Recommendations'**
  String get recommendationsTitle;

  /// No description provided for @recommendationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Personalized'**
  String get recommendationsSubtitle;

  /// No description provided for @schemaChatTitle.
  ///
  /// In en, this message translates to:
  /// **'Schema Chat'**
  String get schemaChatTitle;

  /// No description provided for @schemaChatSubtitle.
  ///
  /// In en, this message translates to:
  /// **'AI Assistant'**
  String get schemaChatSubtitle;

  /// No description provided for @difficultyToHeal.
  ///
  /// In en, this message translates to:
  /// **'Difficulty to Heal'**
  String get difficultyToHeal;

  /// No description provided for @impactLevel.
  ///
  /// In en, this message translates to:
  /// **'Impact Level'**
  String get impactLevel;

  /// No description provided for @whatIsSchema.
  ///
  /// In en, this message translates to:
  /// **'What is {schema}?'**
  String whatIsSchema(String schema);

  /// No description provided for @childhoodOrigins.
  ///
  /// In en, this message translates to:
  /// **'Childhood Origins'**
  String get childhoodOrigins;

  /// No description provided for @howThisSchemaAffectsYou.
  ///
  /// In en, this message translates to:
  /// **'How This Schema Affects You'**
  String get howThisSchemaAffectsYou;

  /// No description provided for @pathToHealing.
  ///
  /// In en, this message translates to:
  /// **'Path to Healing'**
  String get pathToHealing;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @origins.
  ///
  /// In en, this message translates to:
  /// **'Origins'**
  String get origins;

  /// No description provided for @effects.
  ///
  /// In en, this message translates to:
  /// **'Effects'**
  String get effects;

  /// No description provided for @healing.
  ///
  /// In en, this message translates to:
  /// **'Healing'**
  String get healing;

  /// No description provided for @completeDetailedAssessmentFirst.
  ///
  /// In en, this message translates to:
  /// **'Please complete the Detailed Assessment first'**
  String get completeDetailedAssessmentFirst;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
