//
//  PlayerView.swift
//  truth-or-date-ios
//
//  Created by Nguyen Quang on 12/08/2022.
//

import UIKit
import SnapKit

protocol PlayerViewDelegate: AnyObject {
    func removePlayer(index: Int)
    func editPlayer(index: Int, name: String)
}

class PlayerView: UIView {
    private let model: Player
    private let index: Int
    private let containerView = UIView()
    private let nameTextField = UITextField()
    private let trashButton = StyleButton(image: UIImage(named: "ico_trash"),
                                          contentInsets: .init(top: 8, left: 8, bottom: 8, right: 8))
    weak var delegate: PlayerViewDelegate?
    
    init(model: Player, index: Int) {
        self.model = model
        self.index = index
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubviews(containerView)
        containerView.addSubviews([nameTextField, trashButton])
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        nameTextField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(36)
            make.right.equalToSuperview().offset(-36)
        }
        trashButton.snp.makeConstraints { make in
            make.size.equalTo(36)
            make.centerY.right.equalToSuperview()
        }
        
        containerView.layer.cornerRadius = 6
        containerView.backgroundColor = .black
        
        nameTextField.textColor = .white
        nameTextField.textAlignment = .center
        nameTextField.placeholder = model.name
        nameTextField.font = UIFont.init(name: "Chalkduster", size: 16)
        
        let attributedText = NSAttributedString(string: model.name,
                                                attributes: [.foregroundColor: UIColor.white,
                                                             .font: UIFont.init(name: "Chalkduster", size: 16) ?? .systemFont(ofSize: 16)])
        nameTextField.attributedPlaceholder = attributedText
        
        trashButton.addTarget(self,
                              action: #selector(removePlayer),
                              for: .touchUpInside)
        
        nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)),
                                for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let value = textField.text else { return }
        delegate?.editPlayer(index: self.index, name: value)
    }
    
    @objc func removePlayer() {
        delegate?.removePlayer(index: self.index)
    }
}
