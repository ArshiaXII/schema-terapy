// Stub file for web platform where RevenueCat is not supported

class Purchases {
  static Future<void> configure(PurchasesConfiguration config) async {
    throw UnsupportedError('RevenueCat not supported on web');
  }
  
  static Future<CustomerInfo> getCustomerInfo() async {
    throw UnsupportedError('RevenueCat not supported on web');
  }
  
  static Future<CustomerInfo> restorePurchases() async {
    throw UnsupportedError('RevenueCat not supported on web');
  }
}

class PurchasesConfiguration {
  final String apiKey;
  PurchasesConfiguration(this.apiKey);
}

class PurchasesUI {
  static Future<void> presentPaywall() async {
    throw UnsupportedError('RevenueCat not supported on web');
  }
}

class CustomerInfo {
  final EntitlementInfos entitlements = EntitlementInfos();
}

class EntitlementInfos {
  final Map<String, dynamic> active = {};
}
