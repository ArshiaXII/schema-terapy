import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:purchases_flutter/purchases_flutter.dart';

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

