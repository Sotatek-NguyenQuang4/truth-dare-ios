//
//  PlayCardView.swift
//  truth-or-date-ios
//
//  Created by Nguyen Quang on 13/08/2022.
//

import UIKit
import SnapKit

class PlayCardView: UIView {
    let containerView = UIView()
    let backgroundImage = UIImageView(image: UIImage(named: "bg_card"))
    let spaceView = UIView()
    let typeLabel = StyleLabel(font: .init(name: "Chalkduster", size: 24),
                               textColor: .red, textAlignment: .right)
    let centerLabel = StyleLabel(font: .boldSystemFont(ofSize: 90),
                                 textColor: .red, textAlignment: .center)
    let action = UIButton()
    
    init(model: PlayCard) {
        typeLabel.text = model.title
        centerLabel.text = model == .dare ? "!" : "?"
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubviews(containerView)
        containerView.addSubviews([backgroundImage,
                                   typeLabel,
                                   spaceView,
                                   centerLabel,
                                   action])
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        spaceView.snp.makeConstraints { make in
            make.height.equalTo(5)
            make.left.right.bottom.equalToSuperview()
        }
        typeLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalTo(spaceView.snp.top).offset(-12)
        }
        centerLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        action.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.layer.cornerRadius = 12
        backgroundImage.layer.cornerRadius = 12
        backgroundImage.clipsToBounds = true
        backgroundImage.contentMode = .scaleAspectFill
        spaceView.backgroundColor = .red
        backgroundColor = .clear
        containerView.backgroundColor = .clear
        backgroundImage.backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        spaceView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 12)
    }
}

enum PlayCard {
    case truth
    case dare
    
    var title: String {
        switch self {
        case .truth:
            return "Play-Truth".localizedString()
        case .dare:
            return "Play-Dare".localizedString()
        }
    }
}
