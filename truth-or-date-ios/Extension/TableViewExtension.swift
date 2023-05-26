//
//  TableViewExtension.swift
//  TRMobileChat
//
//  Created by Nguyen Anh on 29/03/2021.
//  Copyright © 2021 Nguyen Anh. All rights reserved.
//

import UIKit

protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol { }

extension UICollectionView {
    func register<T: UICollectionViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: className)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T? {
        return self.dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as? T
    }
}

extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }

    func register<T: UITableViewCell>(cellTypes: [T.Type], bundle: Bundle? = nil) {
        cellTypes.forEach {
            register(cellType: $0, bundle: bundle)
        }
    }

    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T? {
        return self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as? T
    }

    func register<T: UITableViewHeaderFooterView>(headerFooterType: T.Type, bundle: Bundle? = nil) {
        let className = headerFooterType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forHeaderFooterViewReuseIdentifier: className)
    }

    func register<T: UITableViewHeaderFooterView>(headerFooterTypes: [T.Type], bundle: Bundle? = nil) {
        headerFooterTypes.forEach {
            register(headerFooterType: $0, bundle: bundle)
        }
    }

    func dequeueReusableHeaderFooter<T: UITableViewHeaderFooterView>(with type: T.Type) -> T? {
        return self.dequeueReusableHeaderFooterView(withIdentifier: type.className) as? T
    }
}

extension UITableView {
    private func indicatorView() -> UIActivityIndicatorView {
        var activityIndicatorView = UIActivityIndicatorView()
        if self.tableFooterView == nil {
            let indicatorFrame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 40)
            activityIndicatorView = UIActivityIndicatorView(frame: indicatorFrame)
            activityIndicatorView.isHidden = false
            activityIndicatorView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
            activityIndicatorView.isHidden = true
            activityIndicatorView.color = .white
            self.tableFooterView = activityIndicatorView
            return activityIndicatorView
        } else {
            return activityIndicatorView
        }
    }

    func addLoading(_ indexPath: IndexPath, isShow: Bool = true, closure: @escaping (() -> Void)) {
        if let lastVisibleIndexPath = self.indexPathsForVisibleRows?.last, isShow {
            if indexPath == lastVisibleIndexPath && indexPath.row == self.numberOfRows(inSection: 0) - 1 {
                indicatorView().startAnimating()
                indicatorView().isHidden = false
                closure()
            }
        }
    }

    func stopLoading(_ canLoadMore: Bool = true) {
        self.tableFooterView?.alpha = canLoadMore == false ? 0 : 1
        indicatorView().stopAnimating()
        indicatorView().isHidden = true
    }
}

extension UITableView {
    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
}
