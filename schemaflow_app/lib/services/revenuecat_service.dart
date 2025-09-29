import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

/// Centralized RevenueCat integration
class RevenueCatService {
  RevenueCatService._();
  static final RevenueCatService instance = RevenueCatService._();

  /// Default entitlement id to unlock premium content
  static const String defaultEntitlementId = 'full_analysis';

  bool _configured = false;

  Future<void> init({required String apiKey, String? appUserId}) async {
    if (_configured) return;
    final configuration = PurchasesConfiguration(apiKey)
      ..appUserId = appUserId
      ..observerMode = false; // we handle purchases via SDK

    await Purchases.configure(configuration);
    _configured = true;
  }

  Future<CustomerInfo> getCustomerInfo() async {
    return Purchases.getCustomerInfo();
  }

  Future<bool> hasEntitlement([String entitlementId = defaultEntitlementId]) async {
    final info = await getCustomerInfo();
    return info.entitlements.active[entitlementId] != null;
  }

  Future<Offerings> getOfferings() async {
    return Purchases.getOfferings();
  }

  /// Shows the default RevenueCat Paywall UI (based on current offering).
  /// Returns true if the expected entitlement is active after dismissal.
  Future<bool> presentPaywallAndCheck({String entitlementId = defaultEntitlementId}) async {
    try {
      final result = await PurchasesUI.presentPaywall();
      // result can be null if user dismissed; still check entitlements
      final info = result?.customerInfo ?? await getCustomerInfo();
      return info.entitlements.active[entitlementId] != null;
    } catch (_) {
      return false;
    }
  }

  /// Attempts to restore previous purchases. Returns true if entitlement is active.
  Future<bool> restorePurchasesAndCheck({String entitlementId = defaultEntitlementId}) async {
    try {
      final info = await Purchases.restorePurchases();
      return info.entitlements.active[entitlementId] != null;
    } catch (_) {
      return false;
    }
  }
}

