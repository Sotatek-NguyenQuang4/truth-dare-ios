//
//  PlayerViewController.swift
//  truth-or-date-ios
//
//  Created by Nguyen Quang on 13/08/2022.
//

import UIKit
import SnapKit

class PlayViewController: BasicViewController {
    private let viewModel: PlayViewModel
    
    private let nameLabel = StyleLabel(font: .init(name: "Chalkduster", size: 30),
                                       textColor: .red)
    private let chooseOneLabel = StyleLabel(text: "CHOOSE ONE",
                                            font: .init(name: "Chalkduster", size: 18))
    private let topStackView = UIStackView()
    private let bottomStackView = UIStackView()
    private let contentPlayView = InfoCardView(viewModel: .dare)
    
    init(viewModel: PlayViewModel) {
        self.viewModel = viewModel
        nameLabel.text = viewModel.namePlayer
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localizable()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func localizable() {
        chooseOneLabel.text = "Play-Choose-One".localizedString()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubviews([nameLabel,
                          chooseOneLabel,
                          topStackView,
                          bottomStackView,
                          contentPlayView])
        
        nameLabel.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        chooseOneLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
        }
        topStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(AppConstant.cardSize.height)
            make.bottom.equalTo(bottomStackView.snp.top).offset(-16)
        }
        bottomStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(AppConstant.cardSize.height)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-5)
        }
        contentPlayView.snp.makeConstraints { make in
            make.top.equalTo(topStackView.snp.top)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalTo(bottomStackView.snp.bottom).offset(5)
        }
        buildTopStackView()
        buildBottomStackView()
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.continueAction(_:)))
        self.contentPlayView.addGestureRecognizer(gesture)
        contentPlayView.isHidden = true
    }
    
    private func buildBottomStackView() {
        bottomStackView.removeFullyAllArrangedSubviews()
        
        bottomStackView.spacing = 16
        bottomStackView.axis = .horizontal
        bottomStackView.distribution = .fillEqually
        let dareView = PlayCardView(model: .dare)
        bottomStackView.addArrangedSubview(dareView)
        
        let truthView = PlayCardView(model: .truth)
        bottomStackView.addArrangedSubview(truthView)
        
        dareView.action.tag = 1
        dareView.action.addTarget(self, action: #selector(dareAction), for: .touchUpInside)
        truthView.action.tag = 1
        truthView.action.addTarget(self, action: #selector(truthAction), for: .touchUpInside)
    }
    
    private func buildTopStackView() {
        topStackView.removeFullyAllArrangedSubviews()
        
        topStackView.spacing = 16
        topStackView.axis = .horizontal
        topStackView.distribution = .fillEqually
        
        let truthView = PlayCardView(model: .truth)
        topStackView.addArrangedSubview(truthView)
        
        let dareView = PlayCardView(model: .dare)
        topStackView.addArrangedSubview(dareView)
        
        dareView.action.tag = 0
        dareView.action.addTarget(self, action: #selector(dareAction), for: .touchUpInside)
        truthView.action.tag = 0
        truthView.action.addTarget(self, action: #selector(truthAction), for: .touchUpInside)
    }
    
    @objc func truthAction(button: UIButton) {
        let questionDare = PlayerManager.shared.questionTruth
        let mess = button.tag == 0 ? questionDare.randomElement() : questionDare.randomElement() 
        contentPlayView.settingView(model: .truth, mess: mess)
        contentPlayView.hideWithAnimation(hidden: false)

    }
    
    @objc func dareAction(button: UIButton) {
        let questionDare = PlayerManager.shared.questionDare
        let mess = button.tag == 0 ? questionDare.randomElement() : questionDare.randomElement()
        contentPlayView.settingView(model: .dare, mess: mess)
        contentPlayView.hideWithAnimation(hidden: false)
    }
    
    @objc func continueAction(_ sender:UITapGestureRecognizer) {
        self.navigationController?.dismiss(animated: true)
    }
}

extension UIView {
    func hideWithAnimation(hidden: Bool) {
        UIView.transition(with: self,
                          duration: 0.5,
                          options: [.transitionFlipFromLeft, .showHideTransitionViews],
                          animations: {
            self.isHidden = hidden
        })
    }
}
