//
//  BuyPremiumViewController.swift
//  truth-or-date-ios
//
//  Created by Nguyen Quang on 13/08/2022.
//

import UIKit
import SnapKit
import SwiftyStoreKit

private let dirtyTag = 1236
private let allTag = 1237

protocol PaymentDelegate: AnyObject {
    func reloadApp()
}

class BuyPremiumViewController: BasicViewController {
    var id: String = ""
    weak var delegate: PaymentDelegate?
    
    let containerView = UIView()
    let headerView = UIView()
    let reStorePurchase = StyleButton(title: "RESTORE PURCHASE",
                                      titleFont: .init(name: "Chalkboard SE Bold", size: 14) ?? .boldSystemFont(ofSize: 14),
                                      titleColor: .white,
                                      backgroundColor: .black,
                                      rounded: true, cornerRadius: 8,
                                      contentInsets: .init(top: 0, left: 8, bottom: 0, right: 8))
    let closeButton = StyleButton(image: UIImage(named: "ico_close"))
    let mainStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setupView() {
        view.backgroundColor = .black.withAlphaComponent(0.4)
        
        view.addSubviews(containerView)
        containerView.addSubviews([headerView,
                                   mainStackView])
        headerView.addSubviews([reStorePurchase, closeButton])
        
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        headerView.snp.makeConstraints { make in
            make.height.equalTo(70)
            make.top.left.right.equalToSuperview()
        }
        reStorePurchase.snp.makeConstraints { make in
            make.height.equalTo(45)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(12)
        }
        closeButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.right.centerY.equalToSuperview()
        }
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        containerView.layer.cornerRadius = 12
        containerView.backgroundColor = .white
        
        setupStackView()
                
        closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        reStorePurchase.addTarget(self, action: #selector(reStorePurchaseAction), for: .touchUpInside)
    }
    
    func setupStackView() {
        mainStackView.axis = .vertical
        mainStackView.removeFullyAllArrangedSubviews()
        
        Purchase.allCases.forEach { element in
            let itemView = BuyPremiumItemView(model: element)
            itemView.delegate = self
            mainStackView.addArrangedSubview(itemView)
        }
        
//        SwiftyStoreKit.retrieveProductsInfo(["ulabeginsell14.99"]) { result in
//            if let product = result.retrievedProducts.first {
//                let priceString = product.localizedPrice!
//                print("Product: \(product.localizedDescription), price: \(priceString)")
//            }
//            else if let invalidProductId = result.invalidProductIDs.first {
//                print("Invalid product identifier: \(invalidProductId)")
//            }
//            else {
//                print("Error: \(result.error)")
//            }
//        }
        
        let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: "b2e87b2830fa4a39a433b22e3bb48b24")
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
            switch result {
            case .success(let receipt):
                let productId = "com.thanh.phantruth.or.dare.dirty"
                // Verify the purchase of Consumable or NonConsumable
                let purchaseResult = SwiftyStoreKit.verifyPurchase(
                    productId: productId,
                    inReceipt: receipt)
                    
                switch purchaseResult {
                case .purchased(let receiptItem):
                    print("\(productId) is purchased: \(receiptItem)")
                case .notPurchased:
                    print("The user has never purchased \(productId)")
                }
            case .error(let error):
                print("Receipt verification failed: \(error)")
            }
        }
        
    }
    
    @objc func closeAction() {
        self.dismiss(animated: true)
    }
    
    @objc func reStorePurchaseAction() {
        SwiftyStoreKit.restorePurchases(atomically: false) { results in
            if results.restoreFailedPurchases.count > 0 {
                self.showAlert(title: AppConstant.apiErrorTitle,
                               message: "Restore Failed: \(results.restoreFailedPurchases)",
                               textOk: "OK",
                               okCallBack: {})
            }
            else if results.restoredPurchases.count > 0 {
                for purchase in results.restoredPurchases {
                    // fetch content from your server, then:
                    if purchase.needsFinishTransaction {
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                }
                self.showAlert(title: AppConstant.apiErrorTitle,
                               message: "Restore Success: \(results.restoredPurchases)",
                               textOk: "OK",
                               okCallBack: {})
            }
            else {
                self.showAlert(title: AppConstant.apiErrorTitle,
                               message: "Nothing to Restore",
                               textOk: "OK",
                               okCallBack: {})
            }
        }
    }
    
    /// Gọi thanh toán đến apple
    /// - Parameter package: model
    func paymentApple(paymentId: String) {
        SwiftyStoreKit.purchaseProduct(paymentId, quantity: 1, atomically: true) { result in
            switch result {
            case .success:
                self.fetchReceipt()
            case .error(let error):
                switch error.code {
                case .unknown: print("Unknown error. Please contact support")
                case .clientInvalid: print("Not allowed to make the payment")
                case .paymentCancelled: break
                case .paymentInvalid: print("The purchase identifier was invalid")
                case .paymentNotAllowed: print("The device is not allowed to make the payment")
                case .storeProductNotAvailable: print("The product is not available in the current storefront")
                case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
                case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
                case .cloudServiceRevoked: print("User has revoked permission to use this cloud service")
                default: print((error as NSError).localizedDescription)
                }
            }
        }
    }
    
    /// Kiểm tra lấy hoá đơn thanh toán thành công
    func fetchReceipt() {
        SwiftyStoreKit.fetchReceipt(forceRefresh: false) { result in
            switch result {
            case .success(let receiptData):
                let encryptedReceipt = receiptData.base64EncodedString(options: [])
                print(encryptedReceipt)
                self.reloadApp()
                self.closeAction()
            case .error(let error):
                print(error)
            }
        }
    }
    
    private func reloadApp() {
        AppConstant.isInapp = InAppState.active.rawValue
        AppConstant.listTopicActive.append(id)
        delegate?.reloadApp()
    }
    
}

extension BuyPremiumViewController: BuyPremiumDelegate {
    func payment(model: Purchase) {
        self.paymentApple(paymentId: model.paymentId)
    }
}
