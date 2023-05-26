//
//  UIViewController.swift

import UIKit

private let kHUDTag = 1234
private let kCustomeHUDTag = 1235
public extension UIViewController {
    func presentSimpleAlert(title: String?, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: nil))
        present(alert, animated: true,
                completion: nil)
    }
    
    func presentSimpleAlert(title: String?, message: String, callback: @escaping () -> Void) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: { _ in callback()}))
        present(alert, animated: true,
                completion: nil)
    }
    
    func presentConfirmationAlert(title: String? = nil, message: String,
                                  okOption: String, cancelOption: String,
                                  okCallback: @escaping () -> Void, cancelCallback: @escaping () -> Void) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okOption,
                                      style: .default,
                                      handler: { _ in okCallback()}))
        alert.addAction(UIAlertAction(title: cancelOption,
                                      style: .cancel,
                                      handler: { _ in cancelCallback()}))
        present(alert, animated: true,
                completion: nil)
    }
    
    func showAlert(title: String,
                   message: String,
                   textOk: String,
                   okCallBack: @escaping() -> Void) {
        let alertViewController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)
        let okAction = UIAlertAction(title: textOk,
                                     style: .default,
                                     handler: { _ in okCallBack()})
        alertViewController.addAction(okAction)
        self.present(alertViewController, animated: true, completion: nil)
    }
    
//    var progressIndicator: MBProgressHUD? {
//        let huds = view.subviews.reversed().compactMap { $0 as? MBProgressHUD }
//        return huds.first { $0.tag == kHUDTag }
//    }
//
//    func showProgressIndicator() {
//        DispatchQueue.main.async {
//            guard self.progressIndicator == nil else {
//                self.progressIndicator?.show(animated: true)
//                return
//            }
//            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
//            hud.tag = kHUDTag
//        }
//    }
    
    internal var customeIndicator: LoadingView? {
        guard let navigationController = UIApplication.shared.windows.first?.rootViewController as? UINavigationController else {
            return nil
        }
        let huds = navigationController.view.subviews.reversed().compactMap { $0 as? LoadingView }
        return huds.first { $0.tag == kCustomeHUDTag }
    }

    func showCustomeIndicator() {
        DispatchQueue.main.async { [weak self] in
            guard let sself = self,
                  sself.customeIndicator == nil,
                  let currentWindown = UIApplication.shared.windows.first?.rootViewController as? UINavigationController else { return }
            let hud = LoadingView()
            hud.showAdded(to: currentWindown.view)
            hud.tag = kCustomeHUDTag
        }
    }
    
    func hideCustomeIndicator() {
        DispatchQueue.main.async {
            self.customeIndicator?.hide()
        }
    }
//
//    func hideProgressIndicator() {
//        DispatchQueue.main.async {
//            self.progressIndicator?.hide(animated: true)
//        }
//    }
    
//    func showToast(message: String, font: UIFont) {
//        let width = message.sizeOfText(font).width + 50
//        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width / 2 - (width / 2),
//                                               y: self.view.frame.size.height - 100,
//                                               width: width,
//                                               height: 35))
//        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.8)
//        toastLabel.textColor = UIColor.white
//        toastLabel.font = font
//        toastLabel.textAlignment = .center;
//        toastLabel.text = message
//        toastLabel.alpha = 1.0
//        toastLabel.layer.cornerRadius = 10;
//        toastLabel.clipsToBounds  =  true
//        self.view.addSubview(toastLabel)
//        UIView.animate(withDuration: 2.5, delay: 0.1, options: .curveEaseOut, animations: {
//             toastLabel.alpha = 0.0
//        }, completion: {(isCompleted) in
//            toastLabel.removeFromSuperview()
//        })
//    }
}

extension UIApplication {
    
    func getTopViewController(base: UIViewController? = UIApplication.shared.mainKeyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
            
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)
            
        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
    
    var mainKeyWindow: UIWindow? {
        if #available(iOS 13, *) {
            return connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first { $0.isKeyWindow }
        } else {
            return keyWindow
        }
    }
    
    var heightOfTabbar: CGFloat {
        if #available(iOS 11.0, *) {
            return 86
        } else {
            return 66
        }
    }
}
