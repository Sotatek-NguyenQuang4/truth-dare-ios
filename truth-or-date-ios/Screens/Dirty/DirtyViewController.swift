//
//  DirtyViewController.swift
//  truth-or-date-ios
//
//  Created by Nguyen Quang on 13/08/2022.
//

import UIKit
import SwiftFortuneWheel

class DirtyViewController: BasicViewController {
    let viewModel = DirtyViewModel()
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var wheelControl: SwiftFortuneWheel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centerView.layer.borderWidth = 7
        centerView.layer.cornerRadius = centerView.bounds.width / 2
        centerView.layer.borderColor = UIColor.gray.cgColor
        centerView.backgroundColor = .white
        
        wheelControl.slices = viewModel.slices
        wheelControl.pinImage = "whitePinArrow"
        wheelControl.edgeCollisionDetectionOn = true
        wheelControl.configuration = .variousWheelSimpleConfiguration
        wheelControl.pinImageViewCollisionEffect = CollisionEffect(force: 8, angle: 20)
        localizable()
        
        guard viewModel.categoryId != nil else { return }
        callApiGetQuesion()
    }
    
    func localizable() {
        backButton.setTitle("Spin-Title".localizedString(), for: .normal)
        playButton.setTitle("Home-player".localizedString(), for: .normal)
    }
    
    private func reloadData() {
        viewModel.reloadData()
        wheelControl.slices = viewModel.slices
        wheelControl.pinImage = "whitePinArrow"
        wheelControl.edgeCollisionDetectionOn = true
        wheelControl.configuration = .variousWheelSimpleConfiguration
        wheelControl.pinImageViewCollisionEffect = CollisionEffect(force: 8, angle: 20)
    }
    
    @IBAction func backScreenAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func settingAction(_ sender: Any) {
        let controller = UIStoryboard(name: "Main",
                                      bundle: nil).instantiateViewController(withIdentifier: "SettingViewController") as? SettingViewController
        guard let vc = controller else { return }
        vc.delegate = self
        let navigation = UINavigationController(rootViewController: vc)
        navigation.modalPresentationStyle = .overFullScreen
        navigation.modalTransitionStyle = .crossDissolve
        self.navigationController?.present(navigation, animated: true, completion: nil)
    }
    
    @IBAction func playAction(_ sender: Any) {
        playButton.isEnabled = false
        backButton.isEnabled = false
        settingButton.isEnabled = false
        
        let finishIndex = viewModel.finishIndex
        wheelControl.startRotationAnimation(finishIndex: finishIndex,
                                            continuousRotationTime: 1) { (finished) in
            let namePlayer = self.viewModel.prizes[finishIndex]
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.playButton.isEnabled = true
                self.backButton.isEnabled = true
                self.settingButton.isEnabled = true
                self.navigateToPlayController(namePlayer: namePlayer)
            }
        }
    }
    
    private func navigateToPlayController(namePlayer: String) {
        let controller = PlayViewController(viewModel: .init(namePlayer: namePlayer))
        let navigation = UINavigationController(rootViewController: controller)
        navigation.modalPresentationStyle = .overFullScreen
        navigation.modalTransitionStyle = .crossDissolve
        self.navigationController?.present(navigation, animated: true, completion: nil)
    }
    
    private func callApiGetQuesion() {
        self.viewModel.playerManager.updateDare(list: viewModel.categoryId?.dares ?? [])
        self.viewModel.playerManager.updateTruth(list: viewModel.categoryId?.truths ?? [])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        centerView.layer.cornerRadius = centerView.bounds.width / 2
    }
}

extension DirtyViewController: SettingDelegate {
    func changePlayer() {
        reloadData()
    }
    
    func changeLanguage() {

    }
    
    
}
