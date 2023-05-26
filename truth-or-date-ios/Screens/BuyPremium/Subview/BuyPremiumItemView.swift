//
//  BuyPremiumItemView.swift
//  truth-or-date-ios
//
//  Created by Nguyen Quang on 13/08/2022.
//

import UIKit
import SnapKit

protocol BuyPremiumDelegate: AnyObject {
    func payment(model: Purchase)
}

class BuyPremiumItemView: UIView {
    weak var delegate: BuyPremiumDelegate?
    private let model: Purchase
    
    let containerView = UIView()
    let titleLabel = StyleLabel(font: .init(name: "Chalkboard SE Bold", size: 24))
    let contentLabel = StyleLabel(font: .init(name: "Chalkboard SE", size: 16))
    let iconView = UIImageView()
    let priceButton = StyleButton(titleFont: .init(name: "Chalkboard SE", size: 16) ?? .systemFont(ofSize: 16),
                                  titleColor: .white,
                                  rounded: true, cornerRadius: 8)
    
    init(model: Purchase) {
        self.model = model
        titleLabel.text = model.title
        contentLabel.text = model.body
        iconView.image = model.icon
        containerView.backgroundColor = model.background
        priceButton.setTitle(model.price, for: .normal)
        priceButton.setBackgroundColor(model == .dirty ? .black : .init(hexString: "D05C4D"),
                                       forState: .normal)
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubviews(containerView)
        containerView.addSubviews([titleLabel,
                                   contentLabel,
                                   iconView,
                                   priceButton])
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(12)
        }
        contentLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.left.equalToSuperview().offset(12)
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
        }
//        iconView.snp.makeConstraints { make in
//            make.size.equalTo(80)
//            make.centerX.equalToSuperview()
//            make.top.equalTo(contentLabel.snp.bottom).offset(8)
//        }
        priceButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
//            make.top.equalTo(iconView.snp.bottom).offset(16)
            make.bottom.equalToSuperview().offset(-22)
            make.top.equalTo(contentLabel.snp.bottom).offset(8)
        }
        
        priceButton.addTarget(self, action: #selector(paymentAction), for: .touchUpInside)
    }
    
    @objc func paymentAction() {
        delegate?.payment(model: self.model)
    }
}
