//
//  SettingViewController.swift
//  truth-or-date-ios
//
//  Created by Nguyen Quang on 13/08/2022.
//

import UIKit
import SnapKit

protocol SettingDelegate: AnyObject {
    func changePlayer()
    func changeLanguage()
}
class SettingViewController: BasicViewController {
    weak var delegate: SettingDelegate?
    var idTopicBuy: String?
    @IBOutlet weak var englishButton: UIButton!
    @IBOutlet weak var vnButton: UIButton!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var purchasingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setupView() {
        view.backgroundColor = .black.withAlphaComponent(0.4)
        
        vnButton.layer.cornerRadius = 8
        englishButton.layer.cornerRadius = 8
        vnButton.layer.borderColor = UIColor.black.cgColor
        englishButton.layer.borderColor = UIColor.black.cgColor
        purchasingButton.isHidden = idTopicBuy == nil
        buyButton.isHidden = true

        
        if AppConstant.currentLang == Lang.vi.rawValue {
            vnButton.layer.borderWidth = 2
            englishButton.layer.borderWidth = 0
        } else {
            englishButton.layer.borderWidth = 2
            vnButton.layer.borderWidth = 0
        }
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.navigationController?.dismiss(animated: true)
    }
    
    @IBAction func chooseEnglishLang(_ sender: Any) {
        guard AppConstant.currentLang != Lang.en.rawValue else { return }
        AppConstant.currentLang = Lang.en.rawValue
        delegate?.changeLanguage()
    }
    
    @IBAction func chooseVietNamLang(_ sender: Any) {
        guard AppConstant.currentLang != Lang.vi.rawValue else { return }
        AppConstant.currentLang = Lang.vi.rawValue
        delegate?.changeLanguage()
    }
    
    @IBAction func policyAction(_ sender: Any) {
        guard let url = URL(string: AppConstant.policy) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func termsAction(_ sender: Any) {
        guard let url = URL(string: AppConstant.term) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func buyPremiumAction(_ sender: Any) {
        
    }
    
    @IBAction func purchasingAction(_ sender: Any) {
        let controller = BuyPremiumViewController()
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        self.navigationController?.present(controller, animated: true)

    }
    
    @IBAction func addPlayerAction(_ sender: Any) {
        let controller = UIStoryboard(name: "Main",
                                      bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
        guard let vc = controller else { return }
        vc.viewModel.navigationState = .present
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SettingViewController: PlayersDelegate {
    func changePlayer() {
        guard let delegate = self.delegate else { return }
        delegate.changePlayer()
    }
}
