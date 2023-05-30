//
//  HomeViewController.swift
//  truth-or-date-ios
//
//  Created by Nguyen Quang on 11/08/2022.
//

import UIKit

protocol PlayersDelegate: AnyObject {
    func changePlayer()
}
class HomeViewController: BasicViewController {
    let viewModel = HomeViewModel()
    weak var delegate: PlayersDelegate?
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var mainStackView: UIStackView!
    
    @IBOutlet weak var whoIsPlayLabel: UILabel!
    @IBOutlet weak var addPlayerButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var heightConstraintScrollView: NSLayoutConstraint!
    @IBOutlet weak var heightConstraintStackView: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localizable()
        hideKeyboardWhenTappedAround()
        self.navigationController?.isNavigationBarHidden = true
        
        let url = "https://raw.githubusercontent.com/Sotatek-NguyenQuang4/truth-dare-ios/main/truth-or-date-ios/Payments.geojson"
        BaseAPI.share.fetchData(urlString: url,
                                responseType: [Purchase].self) { result in
            switch result {
            case .success(let success):
                print(success)
                AppConstant.listPayment = success.filter { $0.paymentId != "com.thanh.phantruth.or.dare" }
                
                guard let _ = success.first(where: { $0.paymentId == "com.thanh.phantruth.or.dare" }) else {
                    return
                }
                AppConstant.listTopicActive = ["Family", "Love"].stringFromArray() ?? ""
                
            case .failure(let error):
                print(error.message)
                let listPayment = [
                    Purchase(title: "DIRT +",
                             body: "Turn up the heat and bring the night to a whole new leve. Contains 500+ cards.",
                             paymentId: "com.thanh.phantruth.or.dare.dirt",
                             price: "0.99$"),
                    Purchase(title: "ALL CONTENT",
                             body: "Buy both Dirty+ and Dirty Extrene abd save 900000.00 đ. Most value",
                             paymentId: "com.thanh.phantruth.or.dare.all.content",
                             price: "3.99$"),
                ]
                AppConstant.listPayment = listPayment
            }
        }
    }
    
    func localizable() {
        whoIsPlayLabel.text = "Home-Who-Is-Playing".localizedString()
        playButton.setTitle("Home-player".localizedString(), for: .normal)
        addPlayerButton.setTitle("Home-Add-player".localizedString(), for: .normal)
    }
    
    private func setupView() {
        mainStackView.axis = .vertical
        mainStackView.backgroundColor = .clear
        mainStackView.distribution = .fillEqually
        // Init data stack view
        mainStackView.removeFullyAllArrangedSubviews()
        self.heightConstraintStackView.constant = CGFloat(self.viewModel.players.count * 55)
        self.heightConstraintScrollView.constant = CGFloat(self.viewModel.players.count * 55)
        self.viewModel.players.enumerated().forEach { index, player in
            let view = PlayerView(model: player, index: index)
            view.delegate = self
            self.mainStackView.addArrangedSubview(view)
        }
    }
    
    @IBAction func addPlayerAction(_ sender: Any) {
        guard viewModel.players.count < viewModel.maxPlayer else {
            self.showAlert(title: AppConstant.apiErrorTitle,
                           message: String(format: "Home-max-player".localizedString(),
                                           viewModel.maxPlayer.toString()),
                           textOk: "OK") { }
            return
        }
        let namePlayer = "\("Home-player-default".localizedString()) \(viewModel.players.count + 1)"
        viewModel.addPlayer(player: Player(name: namePlayer))
        self.loadDataMainStackView()
    }
    
    @IBAction func playAction(_ sender: Any) {
        guard viewModel.players.count > 1 else {
            self.showAlert(title: AppConstant.apiErrorTitle,
                           message: String(format: "Home-min-player".localizedString(), "1"),
                           textOk: "OK") { }
            return
        }
        viewModel.playerManager.cacheListPlayer(players: viewModel.players)
        guard viewModel.navigationState == .navigate else {
            self.delegate?.changePlayer()
            self.dismiss(animated: true)
            return
        }
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CategoryViewController")
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func loadDataMainStackView(isScroll: Bool = true) {
        mainStackView.removeFullyAllArrangedSubviews()
        
        self.mainStackView.invalidateIntrinsicContentSize()
        self.heightConstraintStackView.constant = CGFloat(self.viewModel.players.count * 55)
        let heightConstraint = self.viewModel.players.count < 5 ? CGFloat(self.viewModel.players.count * 55) : 275
        self.heightConstraintScrollView.constant = heightConstraint
        self.viewModel.players.enumerated().forEach { index, player in
            let view = PlayerView(model: player, index: index)
            view.delegate = self
            self.mainStackView.addArrangedSubview(view)
        }
        self.view.layoutIfNeeded()
        if isScroll { self.mainScrollView.scrollToBottom() }
    }
    
    private func hideKeyboardWhenTappedAround() {
        mainScrollView.keyboardDismissMode = .onDrag
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension HomeViewController: PlayerViewDelegate {
    func removePlayer(index: Int) {
        self.viewModel.removePlayer(index: index)
        self.loadDataMainStackView(isScroll: false)
    }
    
    func editPlayer(index: Int, name: String) {
        viewModel.players[index].name = name
    }
}
