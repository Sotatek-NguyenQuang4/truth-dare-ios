//
//  UIButton.swift

import UIKit

extension UIButton {
    
    func setBackgroundColor(_ color: UIColor?, forState: UIControl.State) {
        guard let color = color else {
            setBackgroundImage(nil, for: forState)
            return
        }
        setBackgroundImage(UIImage.imageWithColor(color), for: forState)
    }
}

extension UIButton {
    func apply(title: String, subTitle: String, color: UIColor) {
        let attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: title,
                                                   attributes: [.font: UIFont.important(size: 18)]))
        attributedString.append(NSAttributedString(string: subTitle,
                                                   attributes: [.font: UIFont.primary(size: 14)]))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        paragraphStyle.alignment = .center
        attributedString.addAttribute(.paragraphStyle,
                                      value: paragraphStyle,
                                      range: NSRange(location: 0,
                                                     length: attributedString.length))
        
        setAttributedTitle(attributedString, for: .normal)
        titleLabel?.lineBreakMode = .byWordWrapping
        titleLabel?.numberOfLines = 0
        titleLabel?.textColor = color
    }
}

extension UILabel {
    func apply(title: String, subTitle: String, color: UIColor) {
        let attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: title,
                                                   attributes: [.font: UIFont.important(size: 18)]))
        attributedString.append(NSAttributedString(string: subTitle,
                                                   attributes: [.font: UIFont.primary(size: 14)]))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        paragraphStyle.alignment = .center
        attributedString.addAttribute(.paragraphStyle,
                                      value: paragraphStyle,
                                      range: NSRange(location: 0,
                                                     length: attributedString.length))
        
        attributedText = attributedString
        lineBreakMode = .byWordWrapping
        numberOfLines = 0
        textColor = color
    }
}
