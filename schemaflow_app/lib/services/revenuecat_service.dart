import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;
import 'package:purchases_flutter/purchases_flutter.dart';

/// Centralized RevenueCat integration
class RevenueCatService {
  RevenueCatService._();
  static final RevenueCatService instance = RevenueCatService._();

  /// Default entitlement id to unlock premium content
  static const String defaultEntitlementId = 'full_analysis';

  /// Product identifiers for different purchase options
  static const String oneTimeAnalysisProductId = 'myschema_full_analysis';
  static const String proMonthlyProductId = 'myschema_pro_monthly';
  static const String proAnnualProductId = 'myschema_pro_annual';

  bool _configured = false;
  List<Package>? _packages;

  Future<void> init({required String apiKey, String? appUserId}) async {
    if (_configured) return;

    // Skip RevenueCat init on web (not supported)
    if (kIsWeb) {
      _configured = true;
      return;
    }

    try {
      await Purchases.configure(PurchasesConfiguration(apiKey));
      if (appUserId != null) {
        await Purchases.logIn(appUserId);
      }
      _configured = true;
    } catch (e) {
      debugPrint('RevenueCat init error: $e');
      _configured = true; // Mark as configured even on error to prevent retries
    }
  }

  Future<bool> hasEntitlement([String entitlementId = defaultEntitlementId]) async {
    if (kIsWeb) {
      // For web screenshots, return false (show paywall)
      return false;
    }
    try {
      final info = await Purchases.getCustomerInfo();
      return info.entitlements.active[entitlementId] != null;
    } catch (e) {
      debugPrint('Error checking entitlement: $e');
      return false;
    }
  }

  /// Get available packages for purchase
  Future<List<Package>> getPackages() async {
    if (kIsWeb) {
      return [];
    }
    try {
      if (_packages != null) {
        return _packages!;
      }
      final offerings = await Purchases.getOfferings();
      if (offerings.current != null) {
        _packages = offerings.current!.availablePackages;
        return _packages!;
      }
      return [];
    } catch (e) {
      debugPrint('Error getting packages: $e');
      return [];
    }
  }

  /// Purchase a specific package
  Future<bool> purchasePackage(Package package) async {
    if (kIsWeb) {
      return false;
    }
    try {
      await Purchases.purchasePackage(package);
      // After successful purchase, check entitlement
      final info = await Purchases.getCustomerInfo();
      return info.entitlements.active.containsKey(defaultEntitlementId);
    } catch (e) {
      debugPrint('Purchase error: $e');
      rethrow;
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
    } catch (e) {
      debugPrint('Restore purchases error: $e');
      return false;
    }
  }
}

