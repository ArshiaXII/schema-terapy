# SchemaFlow iOS Deployment Guide

This guide will help you deploy the SchemaFlow Flutter app to iOS devices and the App Store.

## 📱 Prerequisites

### 1. Development Environment
- **macOS** (required for iOS development)
- **Xcode 15+** (latest version recommended)
- **Flutter SDK** (3.1.0 or higher)
- **CocoaPods** (for iOS dependencies)

### 2. Apple Developer Account
- **Apple Developer Program** membership ($99/year)
- **App Store Connect** access
- **iOS Distribution Certificate**
- **App Store Provisioning Profile**

## 🚀 Step-by-Step Deployment

### Step 1: Setup iOS Project

1. **Navigate to the Flutter project:**
   ```bash
   cd schemaflow_app
   ```

2. **Create iOS platform support:**
   ```bash
   flutter create --platforms=ios .
   ```

3. **Install dependencies:**
   ```bash
   flutter pub get
   cd ios
   pod install
   cd ..
   ```

### Step 2: Configure iOS Settings

1. **Open iOS project in Xcode:**
   ```bash
   open ios/Runner.xcworkspace
   ```

2. **Update Bundle Identifier:**
   - Select `Runner` project in Xcode
   - Go to `Signing & Capabilities`
   - Change Bundle Identifier to: `com.yourcompany.schemaflow`

3. **Configure App Information:**
   - **Display Name**: SchemaFlow
   - **Version**: 1.0.0
   - **Build Number**: 1

4. **Add App Icons:**
   - Create app icons (1024x1024 for App Store)
   - Add to `ios/Runner/Assets.xcassets/AppIcon.appiconset/`

### Step 3: API Configuration for iOS

1. **Update API Base URL:**
   ```dart
   // In lib/services/api_service.dart
   static const String _baseUrl = "https://your-production-api.com";
   ```

2. **Add Network Permissions:**
   ```xml
   <!-- In ios/Runner/Info.plist -->
   <key>NSAppTransportSecurity</key>
   <dict>
       <key>NSAllowsArbitraryLoads</key>
       <true/>
   </dict>
   ```

### Step 4: Build and Test

1. **Build for iOS Simulator:**
   ```bash
   flutter build ios --simulator
   ```

2. **Run on iOS Simulator:**
   ```bash
   flutter run -d ios
   ```

3. **Build for Physical Device:**
   ```bash
   flutter build ios --release
   ```

### Step 5: App Store Preparation

1. **Create App Store Connect Record:**
   - Go to [App Store Connect](https://appstoreconnect.apple.com)
   - Create new app with Bundle ID: `com.yourcompany.schemaflow`

2. **Prepare App Store Assets:**
   - **App Icon**: 1024x1024 PNG
   - **Screenshots**: Various iOS device sizes
   - **App Description**: Schema therapy assessment app
   - **Keywords**: schema therapy, psychology, mental health
   - **Privacy Policy**: Required for health apps

3. **Build Archive:**
   ```bash
   flutter build ipa
   ```

4. **Upload to App Store:**
   - Use Xcode Organizer or Transporter app
   - Upload the `.ipa` file from `build/ios/ipa/`

## 🔧 Important Configuration

### Environment Variables
Create a production `.env` file:
```env
GOOGLE_API_KEY="your-production-google-api-key"
MY_APP_SECRET_KEY="your-production-api-key"
```

### API Endpoints
Update the API service for production:
```dart
class ApiService {
  static const String _baseUrl = "https://your-backend.herokuapp.com";
  static const String _apiKey = "your-production-api-key";
}
```

### App Store Guidelines Compliance

1. **Privacy Policy**: Required for apps that collect user data
2. **Content Rating**: Set appropriate age rating
3. **Health Data**: Comply with health app guidelines
4. **User Authentication**: Implement secure login
5. **Data Encryption**: Ensure API communications are encrypted

## 📋 Pre-Submission Checklist

- [ ] App builds successfully for iOS
- [ ] All screens work on various iOS devices
- [ ] API integration works with production backend
- [ ] App icons and screenshots prepared
- [ ] Privacy policy created and linked
- [ ] App Store Connect record created
- [ ] TestFlight testing completed
- [ ] App Store review guidelines compliance verified

## 🔍 Testing Strategy

### 1. Device Testing
- **iPhone SE** (small screen)
- **iPhone 14** (standard size)
- **iPhone 14 Pro Max** (large screen)
- **iPad** (tablet layout)

### 2. Feature Testing
- [ ] Onboarding flow
- [ ] User authentication
- [ ] Questionnaire completion
- [ ] API communication
- [ ] Premium features
- [ ] Offline functionality

### 3. Performance Testing
- [ ] App launch time < 3 seconds
- [ ] Smooth animations
- [ ] Memory usage optimization
- [ ] Battery usage optimization

## 🚨 Common Issues & Solutions

### Issue: Build Fails
**Solution**: Update Xcode and Flutter to latest versions

### Issue: API Not Working
**Solution**: Check network permissions and HTTPS configuration

### Issue: App Store Rejection
**Solution**: Review App Store guidelines and update accordingly

## 📞 Support Resources

- **Flutter iOS Documentation**: https://docs.flutter.dev/deployment/ios
- **App Store Connect Help**: https://developer.apple.com/support/app-store-connect/
- **Xcode Documentation**: https://developer.apple.com/documentation/xcode

## 🎯 Next Steps After Deployment

1. **Monitor App Performance**: Use App Store Connect analytics
2. **User Feedback**: Respond to reviews and ratings
3. **Updates**: Regular app updates with new features
4. **Marketing**: Promote the app to target audience

---

**Ready for iOS deployment!** 🚀📱

Follow this guide step-by-step to successfully deploy SchemaFlow to the App Store.
