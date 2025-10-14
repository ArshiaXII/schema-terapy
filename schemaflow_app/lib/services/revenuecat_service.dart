import 'package:flutter/foundation.dart' show kIsWeb;

// Conditional imports for RevenueCat (not supported on web)
import 'package:purchases_flutter/purchases_flutter.dart'
    if (dart.library.html) 'revenuecat_web_stub.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart'
    if (dart.library.html) 'revenuecat_web_stub.dart';

/// Centralized RevenueCat integration
class RevenueCatService {
  RevenueCatService._();
  static final RevenueCatService instance = RevenueCatService._();

  /// Default entitlement id to unlock premium content
  static const String defaultEntitlementId = 'full_analysis';

  bool _configured = false;

  Future<void> init({required String apiKey, String? appUserId}) async {
    if (_configured) return;

    // Skip RevenueCat init on web (not supported)
    if (kIsWeb) {
      _configured = true;
      return;
    }

    await Purchases.configure(PurchasesConfiguration(apiKey));
    _configured = true;
  }

  Future<bool> hasEntitlement([String entitlementId = defaultEntitlementId]) async {
    if (kIsWeb) {
      // For web screenshots, return false (show paywall)
      return false;
    }
    final info = await Purchases.getCustomerInfo();
    return info.entitlements.active[entitlementId] != null;
  }

  /// Shows the default RevenueCat Paywall UI (based on current offering).
  /// Returns true if the expected entitlement is active after dismissal.
  Future<bool> presentPaywallAndCheck({String entitlementId = defaultEntitlementId}) async {
    if (kIsWeb) {
      // For web screenshots, simulate user cancelling
      return false;
    }
    try {
      await PurchasesUI.presentPaywall();
      // Check entitlements after paywall dismissal
      final info = await Purchases.getCustomerInfo();
      return info.entitlements.active[entitlementId] != null;
    } catch (_) {
      return false;
    }
  }

  /// Attempts to restore previous purchases. Returns true if entitlement is active.
  Future<bool> restorePurchasesAndCheck({String entitlementId = defaultEntitlementId}) async {
    if (kIsWeb) {
      // For web screenshots, simulate no purchases to restore
      return false;
    }
    try {
      final info = await Purchases.restorePurchases();
      return info.entitlements.active[entitlementId] != null;
    } catch (_) {
      return false;
    }
  }
}

