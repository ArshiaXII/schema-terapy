# MySchema

A comprehensive Flutter mobile application for schema therapy assessment and analysis, designed to help users identify their core personality schemas through scientifically-backed questionnaires and receive personalized AI-powered insights.

## 🎯 Features

### Core Functionality
- **Schema Assessment**: Scientifically-backed questionnaire to identify personality schemas
- **AI Analysis**: Personalized insights and recommendations based on results
- **Interactive Chat**: Conversational AI to explore schema results in depth
- **Progress Tracking**: Monitor growth and schema evolution over time

### User Experience
- **Onboarding Flow**: 3-page introduction to the app's benefits
- **Authentication**: Secure login/signup with social media options
- **Freemium Model**: Free basic analysis with premium detailed insights
- **Responsive Design**: Optimized for all phone sizes and orientations

### Design System
- **Calming Aesthetic**: Soft teal primary color with professional styling
- **Typography**: Poppins for headings, Inter for body text
- **Animations**: Smooth transitions and micro-interactions
- **Accessibility**: High contrast ratios and readable fonts

## 🏗️ Architecture

### State Management
- **Provider Pattern**: Clean separation of business logic and UI
- **User Provider**: Manages authentication, subscription, and profile data
- **Reactive UI**: Automatic updates when state changes

### Screen Structure
```
lib/
├── core/
│   ├── theme/
│   │   └── app_theme.dart          # Design system and styling
│   └── providers/
│       └── user_provider.dart      # User state management
├── screens/
│   ├── onboarding_screen.dart      # 3-page app introduction
│   ├── auth_screen.dart            # Login/signup with social options
│   ├── home_screen.dart            # Main dashboard
│   ├── questionnaire_screen.dart   # Schema assessment
│   ├── paywall_screen.dart         # Premium subscription
│   ├── results_screen.dart         # Detailed analysis results
│   ├── chat_screen.dart            # AI conversation interface
│   └── user_profile_screen.dart    # Account management
└── main.dart                       # App entry point
```

## 🎨 Design System

### Color Palette
- **Primary**: `#4F9A94` (Soft Teal)
- **Background**: `#F5F5F5` (Light Grey)
- **Text**: `#333333` (Dark Grey)
- **Accent**: `#5DB075` (Green)
- **Error**: `#E74C3C` (Red)
- **Warning**: `#F39C12` (Orange)

### Typography
- **Headings**: Poppins (Bold/Semi-bold)
- **Body**: Inter (Regular/Medium)
- **Responsive**: Auto-sizing text for different screen sizes

### Spacing System
- **XS**: 4px
- **S**: 8px
- **M**: 16px
- **L**: 24px
- **XL**: 32px
- **XXL**: 48px

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.1.0)
- Dart SDK
- Android Studio / VS Code
- iOS Simulator / Android Emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd myschema_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Development Setup

1. **Enable hot reload** for faster development
2. **Use Flutter Inspector** for UI debugging
3. **Run tests** with `flutter test`
4. **Check code quality** with `flutter analyze`

## 📱 Screens Overview

### 1. Onboarding Screen
- 3 swipeable pages introducing key benefits
- Skip option for returning users
- Smooth animations and engaging visuals

### 2. Authentication Screen
- Toggle between login and signup
- Social authentication (Google, Apple)
- Form validation and error handling

### 3. Home Screen
- Personalized welcome message
- Main action card (questionnaire or results)
- Progress tracking and subscription status

### 4. Questionnaire Screen
- Multi-step schema assessment
- Progress indicator and navigation
- Slider-based answer input (1-6 scale)

### 5. Paywall Screen
- Premium feature highlights
- Subscription plan comparison
- Persuasive design with clear value proposition

### 6. Results Screen
- Schema profile summary
- Expandable detailed analysis cards
- Floating action button for AI chat

### 7. Chat Screen
- Conversational AI interface
- Context-aware responses about user's schemas
- Typing indicators and smooth animations

### 8. Profile Screen
- User information and avatar
- Subscription management
- Account settings and logout

## 🔧 Customization

### Adding New Schemas
1. Update the questionnaire questions in `questionnaire_screen.dart`
2. Modify the scoring logic in the `_calculateResults()` method
3. Add new schema result cards in `results_screen.dart`

### Modifying the Design
1. Update colors and spacing in `app_theme.dart`
2. Change fonts by updating the Google Fonts imports
3. Modify animations by adjusting the AnimationController parameters

### Integrating Real APIs
1. Replace mock data in `user_provider.dart` with actual API calls
2. Add HTTP client dependencies (dio, http)
3. Implement proper error handling and loading states

## 🧪 Testing

### Unit Tests
```bash
flutter test
```

### Widget Tests
```bash
flutter test test/widget_test.dart
```

### Integration Tests
```bash
flutter drive --target=test_driver/app.dart
```

## 📦 Dependencies

### Core Dependencies
- **flutter**: Flutter SDK
- **provider**: State management
- **google_fonts**: Typography
- **cupertino_icons**: iOS-style icons

### Development Dependencies
- **flutter_test**: Testing framework
- **flutter_lints**: Code quality rules

## 🚀 Deployment

### Android
1. Build APK: `flutter build apk`
2. Build App Bundle: `flutter build appbundle`
3. Upload to Google Play Console

### iOS
1. Build iOS: `flutter build ios`
2. Archive in Xcode
3. Upload to App Store Connect

## 📄 License

This project is a template/demo application. Please ensure you have proper licensing for any production use.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📞 Support

For questions or support, please refer to the Flutter documentation or create an issue in the repository.

---

**MySchema** - Empowering self-understanding through technology 🧠✨
