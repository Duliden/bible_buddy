import 'dart:async';
import 'package:in_app_purchase/in_app_purchase.dart';

class PurchaseService {
  static final InAppPurchase _iap = InAppPurchase.instance;
  static const String _premiumId = 'premium_plan';
  static late StreamSubscription<List<PurchaseDetails>> _subscription;

  // Initialize the purchase service and listen to purchase updates
  static Future<void> init() async {
    final Stream<List<PurchaseDetails>> purchaseUpdated = _iap.purchaseStream;
    _subscription = purchaseUpdated.listen(
      _onPurchaseUpdated,
      onDone: () => _subscription.cancel(),
      onError: (error) {
        // handle error
      },
    );
  }

  // Check if premium purchase is already made/past purchases include premium
  static Future<bool> isPremiumAvailable() async {
    final QueryPurchaseDetailsResponse response = await _iap.queryPastPurchases();
    for (var purchase in response.pastPurchases) {
      if (purchase.productID == _premiumId &&
          purchase.status == PurchaseStatus.purchased) {
        return true;
      }
    }
    return false;
  }

  // Initiate purchase of premium non-consumable
  static Future<void> buyPremium() async {
    final ProductDetailsResponse response =
        await _iap.queryProductDetails({_premiumId});
    if (response.productDetails.isEmpty) {
      // Product not found
      return;
    }
    final product = response.productDetails.first;
    final purchaseParam = PurchaseParam(productDetails: product);
    await _iap.buyNonConsumable(purchaseParam: purchaseParam);
  }

  // Handle incoming purchase updates
  static void _onPurchaseUpdated(List<PurchaseDetails> purchases) {
    for (var purchase in purchases) {
      switch (purchase.status) {
        case PurchaseStatus.pending:
          // show pending UI
          break;
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          // verify purchase and unlock premium features
          break;
        case PurchaseStatus.error:
          // handle error
          break;
      }
      if (purchase.pendingCompletePurchase) {
        _iap.completePurchase(purchase);
      }
    }
  }

  // Dispose of the purchase stream subscription
  static Future<void> dispose() async {
    await _subscription.cancel();
  }
}
