//
//  UIButtonExtension.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import UIKit

extension UIButton {
    
    func createNavigationDropdown(_ title: String) {
        self.setTitle(title, for: .normal)
        self.setImage(AppImages.downArrow?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.tintColor = AppColors.title
        self.setTitleColor(AppColors.title, for: .normal)
        self.backgroundColor = AppColors.textfieldBackground
        self.layer.cornerRadius = 10
        var msgWidth: CGFloat = 0
        let imgWidth: CGFloat = 25
        let font = UIFont.systemFont(ofSize: 14)
        self.titleLabel?.font = font
        msgWidth = title.widthOfString(usingFont: font)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: msgWidth + imgWidth/2, bottom: 0, right: -imgWidth/2)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(imgWidth), bottom: 0, right: 0)
        self.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 25)
    }
    
    func createNavigationBtn(_ image: UIImage?, backgroundColor: UIColor? = AppColors.textfieldBackground) {
        self.setImage(image?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.tintColor = AppColors.title
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 10
        self.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func createNavigationBtn(_ title: String, color: UIColor? = AppColors.link) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(color, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    }
}
