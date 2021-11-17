//
//  UIViewController+Extension.swift
//  WiseHouse
//
//  Created by Konstantin Khmara on 23.03.2020.
//  Copyright © 2020 Shooting App. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    class var vcName: String {
        return String(describing: self)
    }
    
    class func instatiateFromNib<T: UIViewController>(_ storyboardName: StoryboardName) -> T? {
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as? T {
            return vc
        }
        return nil
    }
}

extension UINavigationController {
    
    class func instatiateFrom<T: UINavigationController>(_ storyboardName: StoryboardName) -> T? {
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as? T {
            return vc
        }
        return nil
    }
    
    func popViewControllerWithHandler(completion: SimpleCompletion) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: false)
        CATransaction.commit()
    }
    
    func setNavigationTitle(_ name: String) {
        navigationItem.title = name
        navigationItem.largeTitleDisplayMode = .never
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black,
                                             NSAttributedString.Key.font: UIFont.systemFontSize]
    }
    
    func presentTransparentNavigationBar() {
        setNavigationBarHidden(false, animated: true)
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
    }
    
    func hideTransparentNavigationBar() {
        setNavigationBarHidden(false, animated:false)
        navigationBar.setBackgroundImage(UINavigationBar.appearance().backgroundImage(for: UIBarMetrics.default), for:  .default)
        navigationBar.isTranslucent = false
        navigationBar.shadowImage = nil
    }
    
    func moveToSpecificViewController(with viewController: UIViewController, _ shouldLeaveFirst: Bool? = true) {
        var navigationArray = self.viewControllers
        guard let firstVC = navigationArray.first else { return }
        navigationArray.removeAll()
        if shouldLeaveFirst == true {
            navigationArray.append(firstVC)
        }
        self.viewControllers = navigationArray
        mainThread {
            self.pushViewController(viewController, animated: true)
        }
    }
}

extension UINavigationController {
    
   open override var preferredStatusBarStyle: UIStatusBarStyle {
      return topViewController?.preferredStatusBarStyle ?? .lightContent
   }
}

extension UIViewController {
    
    func add(_ child: UIViewController, containerView: UIView) {
        addChild(child)
        containerView.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}

public extension UIViewController {
    
    enum SizingOption {
        case equalToSuperviewWithInsets(UIEdgeInsets)
        case centeredWithFixedSize(CGSize)
        case customSizing((UIViewController) -> Void)
    }
    
//    func attachChildViewController(childController: UIViewController,
//                                   containerView: UIView,
//                                   sizing: SizingOption) {
//        addChild(childController)
//        containerView.addSubview(childController.view)
//
//        switch sizing {
//        case .equalToSuperviewWithInsets(let inset):
//            childController.view.snp.makeConstraints { maker in
//                maker.edges.equalToSuperview().inset(inset)
//            }
//        case .centeredWithFixedSize(let size):
//            childController.view.snp.makeConstraints { maker in
//                maker.size.equalTo(size)
//                maker.center.equalToSuperview()
//            }
//        case .customSizing(let sizingClosure):
//            sizingClosure(childController)
//        }
//
//        childController.didMove(toParent: self)
//    }
    
    func detachChildViewController(childController: UIViewController) {
        if children.contains(childController) {
            childController.willMove(toParent: nil)
            childController.view.removeFromSuperview()
            childController.removeFromParent()
        }
    }
}

extension UIViewController {
    
    func showInfoAlert(title: String, msg: String,
                       actionText: String? = "OK",
                       actionColor: UIColor? = .darkRoyalBlue,
                       doAction: (()->())?, cancelAction: (() -> Void)? = nil) {
        
        mainThread {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let backView = alert.view.subviews.last?.subviews.last
        backView?.layer.cornerRadius = 14.0
        
        let okButton = UIAlertAction(title: actionText, style: .default) { (action) in
            doAction?()
        }
        
        let msgAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .medium),
                             NSAttributedString.Key.foregroundColor: UIColor.black]
        
        let atrrString = NSAttributedString(string: msg, attributes: msgAttributes)
        alert.setValue(atrrString, forKey: "attributedMessage")
        
        okButton.setValue(actionColor, forKey: "titleTextColor")
        alert.addAction(okButton)
        
        if let cancelProvided = cancelAction {
            let cancelButton = UIAlertAction(title: "Скасувати", style: .cancel) { (action) in
                cancelProvided()
                alert.dismiss(animated: true, completion: nil)
            }
            
            cancelButton.setValue(UIColor.vividBlue, forKey: "titleTextColor")
            alert.addAction(cancelButton)
        }
        
       
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func showExitInfoAlert(title: String, msg: String, doAction: (() -> Void)?, cancelAction: (() -> Void)?) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let backView = alert.view.subviews.last?.subviews.last
        backView?.layer.cornerRadius = 14.0
        
        let okButton = UIAlertAction(title: "Вийти", style: .default) { (action) in
            doAction?()
        }
        
        let msgAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .medium),
        NSAttributedString.Key.foregroundColor: UIColor.black]
        
        let atrrString = NSAttributedString(string: msg, attributes: msgAttributes)
        alert.setValue(atrrString, forKey: "attributedMessage")
        
        okButton.setValue(UIColor.salmon, forKey: "titleTextColor")
      
        
        if let cancelProvided = cancelAction {
            let cancelButton = UIAlertAction(title: "Скасувати", style: .cancel) { (action) in
                cancelProvided()
                alert.dismiss(animated: true, completion: nil)
            }
            cancelButton.setValue(UIColor.vividBlue, forKey: "titleTextColor")
            alert.addAction(cancelButton)
        }
        
        alert.addAction(okButton)
        
        mainThread {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: false)
    }
    
    func dismissDetail() {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false)
    }
}

extension UIViewController {

    var isModal: Bool {

        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController

        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
}
