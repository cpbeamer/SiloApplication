//
//  ManageNavigations.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation
import UIKit

enum AppStoryboard: String {
    case main = "Main"
    case passcode = "Passcode"
    case home = "Home"
    case common = "Common"
    case profile = "Profile"
    case wallet = "Wallet"
    case sellAndBuy = "SellAndBuy"
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewControllerClass: T.Type, function: String = #function, line: Int = #line, file: String = #file) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        return scene
    }
    
    func initialViewController() -> UIViewController? {
        
        return instance.instantiateInitialViewController()
    }
}

extension UIViewController {
    
    // Not using static as it wont be possible to override to provide custom storyboardID then
    class var storyboardID: String {
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}

extension UIViewController {
    
    func presentWithNavigation(_ vc: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        DispatchQueue.mainQueueAsync {
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: flag, completion: completion)
        }
    }
    
    func presentOverCurrentContext(_ vc: UIViewController, overNavigation check: Bool = true, animated flag: Bool, completion: (() -> Void)? = nil) {
        DispatchQueue.mainQueueAsync {
            vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            vc.view.isOpaque = false
            vc.modalPresentationStyle = .overCurrentContext
            if check {
                self.navigationController?.present(vc, animated: flag, completion: completion)
            } else {
                self.present(vc, animated: flag, completion: completion)
            }
        }
    }
}
