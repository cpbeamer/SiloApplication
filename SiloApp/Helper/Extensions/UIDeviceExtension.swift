//
//  UIDeviceExtension.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import AVFoundation
import UIKit

// MARK:- UIDEVICE
//==================
extension UIDevice {
    
    static let size = UIScreen.main.bounds.size
    
    static let height = UIScreen.main.bounds.height
    
    static let width = UIScreen.main.bounds.width
    
    @available(iOS 11.0, *)
    static var bottomSafeArea = UIApplication.shared.windows.first(where: { $0.isKeyWindow})?.safeAreaInsets.bottom
    
    @available(iOS 11.0, *)
    static let topSafeArea = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.safeAreaInsets.top
    
    static func vibrate() {
        let feedback = UIImpactFeedbackGenerator.init(style: UIImpactFeedbackGenerator.FeedbackStyle.heavy)
        feedback.prepare()
        feedback.impactOccurred()
    }
}
