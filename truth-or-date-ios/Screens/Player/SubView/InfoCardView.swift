//
//  InfoCardView.swift
//  truth-or-date-ios
//
//  Created by Nguyen Quang on 13/08/2022.
//

import UIKit
import SnapKit

class InfoCardView: UIView {
    let containerView = UIView()
    let topRightLabel = StyleLabel(font: .init(name: "Chalkboard SE Bold", size: 18),
                                   textAlignment: .right)
    let leftBottomLabel = StyleLabel(font: .init(name: "Chalkboard SE Bold", size: 18),
                                     textAlignment: .right)
    
    let topLeftLabel = StyleLabel(font: .init(name: "Chalkboard SE Bold", size: 24),
                                  textAlignment: .right)
    let rightBottomLabel = StyleLabel(font: .init(name: "Chalkboard SE Bold", size: 24),
                                      textAlignment: .right)
    
    let centerLabel = StyleLabel(font: .init(name: "Chalkboard SE Bold", size: 24),
                                 textAlignment: .center)
    
    init(viewModel: PlayCard) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubviews(containerView)
        containerView.addSubviews([topRightLabel,
                                   leftBottomLabel,
                                   topLeftLabel,
                                   rightBottomLabel,
                                   centerLabel])
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        topRightLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        leftBottomLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-12)
        }
        topLeftLabel.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(12)
        }
        rightBottomLabel.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview().offset(-12)
        }
        centerLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        containerView.layer.cornerRadius = 12
        containerView.backgroundColor = .red
    }
    
    func settingView(model: PlayCard, mess: String? = "") {
        topRightLabel.text = model.title.uppercased()
        leftBottomLabel.text = model.title.uppercased()
        topLeftLabel.text = model == .dare ? "!" : "?"
        rightBottomLabel.text = model == .dare ? "!" : "?"
        centerLabel.text = "\(mess ?? "")\n(\("Click-To-Continue".localizedString()))"
    }
}
