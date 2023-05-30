//
//  CategoryViewController.swift
//  truth-or-date-ios
//
//  Created by Nguyen Quang on 12/08/2022.
//

import UIKit

class CategoryViewController: BasicViewController {
    private var categories: [Topic] = []
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localizable()
    }
    
    func localizable() {
        backButton.setTitle("Category-Title".localizedString(), for: .normal)
    }
    
    private func setupView() {
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.backgroundColor = .white
        myTableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil),
                             forCellReuseIdentifier: "CategoryTableViewCell")
        
        getAllCategory()
    }
    
    @IBAction func backScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func settingAction(_ sender: Any) {
        let controller = UIStoryboard(name: "Main",
                                      bundle: nil).instantiateViewController(withIdentifier: "SettingViewController") as? SettingViewController
        guard let vc = controller else { return }
        vc.delegate = self
        vc.idTopicBuy = categories.first(where: { !$0.isLock })?.name
        let navigation = UINavigationController(rootViewController: vc)
        navigation.modalPresentationStyle = .overFullScreen
        navigation.modalTransitionStyle = .crossDissolve
            
        self.navigationController?.present(navigation, animated: true, completion: nil)
    }
    
    func getAllCategory() {
        self.showCustomeIndicator()
        self.categories = AppConstant.categories
        self.categories.forEach {
            let listTopicActive = AppConstant.listTopicActive.arrayFromString() ?? []
            print("nnq: \(listTopicActive)")
            $0.isLock = listTopicActive.contains($0.name)
        }
        myTableView.reloadData()
        self.hideCustomeIndicator()
    }
}

extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell",
                                                 for: indexPath) as! CategoryTableViewCell
        cell.configCell(model: categories[indexPath.row])
        return cell
    }
}

extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard categories[indexPath.row].isLock else {
            let controller = BuyPremiumViewController()
            controller.id = categories[indexPath.row].name
            controller.delegate = self
            controller.modalPresentationStyle = .overFullScreen
            controller.modalTransitionStyle = .crossDissolve
            self.navigationController?.present(controller, animated: true)
            return
        }
        let controller = UIStoryboard(name: "Main",
                                      bundle: nil).instantiateViewController(withIdentifier: "DirtyViewController") as? DirtyViewController
        guard let vc = controller else { return }
        vc.viewModel.categoryId = categories[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension CategoryViewController: SettingDelegate {
    func changePlayer() {
        self.navigationController?.dismiss(animated: true)
    }
    
    func changeLanguage() {
        self.navigationController?.dismiss(animated: true)
    }
}


extension CategoryViewController: PaymentDelegate {
    func openAllContent() {
        let listIds = self.categories.map { $0.name }
        AppConstant.listTopicActive = ""
        AppConstant.listTopicActive = listIds.stringFromArray() ?? ""
        getAllCategory()
    }
    
    func reloadApp() {
        getAllCategory()
    }
}

extension String {
    func arrayFromString() -> [String]? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String]
    }
}

extension Array {
    func stringFromArray() -> String? {
        return (try? JSONSerialization.data(withJSONObject: self, options: []))?.base64EncodedString()
    }
}
