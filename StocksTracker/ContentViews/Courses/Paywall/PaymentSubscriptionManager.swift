import Foundation
import StoreKit

class SubscriptionManager: NSObject, ObservableObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    private var productsRequest: SKProductsRequest?
    @Published var availableProducts: [SKProduct] = []
    @Published var buyedSub = UserDefaults.standard.bool(forKey: "subscription_buyed")
    
    override init() {
        super.init()
        SKPaymentQueue.default().add(self)
        
        fetchAvailableProducts()
    }
    
    // Запрос доступных продуктов
    func fetchAvailableProducts() {
        let productIdentifiers: Set<String> = ["com.tratradappstocks.StocksTraker.premium"]
        productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
        productsRequest?.delegate = self
        productsRequest?.start()
    }
    
    // Обработчик получения продуктов
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        availableProducts = response.products
        for product in availableProducts {
            
        }
    }
    
    // Покупка подписки
    func purchaseProduct(product: SKProduct) {
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    // Восстановление покупок
    func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    // Обработка транзакций
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                handlePurchase(transaction: transaction)
            case .failed:
                handleFailedTransaction(transaction: transaction)
            case .restored:
                handleRestoredTransaction(transaction: transaction)
            case .deferred, .purchasing:
                break
            @unknown default:
                break
            }
        }
    }
    
    // Обработка успешной покупки
    private func handlePurchase(transaction: SKPaymentTransaction) {
        // Обработка активации подписки
        buyedSub = true
        UserDefaults.standard.set(true, forKey: "subscription_buyed")
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    // Обработка неудачной покупки
    private func handleFailedTransaction(transaction: SKPaymentTransaction) {
        if let error = transaction.error as NSError?, error.code != SKError.paymentCancelled.rawValue {
            print("Transaction failed: \(error.localizedDescription)")
        }
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    // Обработка восстановления покупок
    private func handleRestoredTransaction(transaction: SKPaymentTransaction) {
        print("Restored: \(transaction.payment.productIdentifier)")
        SKPaymentQueue.default().finishTransaction(transaction)
    }
}
