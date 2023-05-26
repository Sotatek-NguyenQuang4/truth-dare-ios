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
    var listPayment: [Purchase] = []
    weak var delegate: PaymentDelegate?
    
    let scrollView = UIScrollView()
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
        
        view.addSubviews(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubviews([headerView,
                                   mainStackView])
        headerView.addSubviews([reStorePurchase, closeButton])
        
        scrollView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(400)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        containerView.backgroundColor = .red
        containerView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
            make.height.greaterThanOrEqualToSuperview().priority(.required)
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

        closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        reStorePurchase.addTarget(self, action: #selector(reStorePurchaseAction), for: .touchUpInside)

        let url = "https://raw.githubusercontent.com/Sotatek-NguyenQuang4/truth-dare-ios/main/truth-or-date-ios/Payments.geojson"
        BaseAPI.share.fetchData(urlString: url,
                                responseType: [Purchase].self) { result in
            switch result {
            case .success(let success):
                self.listPayment = success
                self.setupStackView()
            case .failure(let error):
                print(error.message)
                self.listPayment = [
                    Purchase(title: "DIRT +",
                             body: "Turn up the heat and bring the night to a whole new leve. Contains 500+ cards.",
                             paymentId: "com.thanh.phantruth.or.dare.dirt",
                             price: "0.99$"),
                    Purchase(title: "ALL CONTENT",
                             body: "Buy both Dirty+ and Dirty Extrene abd save 900000.00 đ. Most value",
                             paymentId: "com.thanh.phantruth.or.dare.all.content",
                             price: "3.99$"),
                ]
                self.setupStackView()
            }
        }
    }
    
    func setupStackView() {
        mainStackView.axis = .vertical
        mainStackView.removeFullyAllArrangedSubviews()
        
//        let Purchase = ids.map {  }
        
        listPayment.enumerated().forEach { index, element in
            let itemView = BuyPremiumItemView(model: element,
                                              background: index % 2 == 0 ? .black : .init(hexString: "D05C4D"))
            itemView.delegate = self
            mainStackView.addArrangedSubview(itemView)
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
