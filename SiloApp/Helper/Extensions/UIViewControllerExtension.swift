//
//  UIViewControllerExtension.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation
import UIKit
import AssetsLibrary
import AVFoundation
import Photos
import MobileCoreServices

extension UIViewController {
    
    typealias ImagePickerDelegateController = (UIViewController & UIImagePickerControllerDelegate & UINavigationControllerDelegate)
    
    func openCamera(delegate controller: ImagePickerDelegateController,
                    photoGallery: Bool = true,
                    camera: Bool = true,
                    mediaType : [String] = [kUTTypeImage as String],
                    openingCamera: Bool = true) {
        
        if openingCamera {
            self.checkAndOpenCamera(delegate: controller, mediaType: mediaType)
        } else {
            self.checkAndOpenLibrary(delegate: controller, mediaType: mediaType)
        }
    }
    
    func captureImage(delegate controller: ImagePickerDelegateController,
                      photoGallery: Bool = true,
                      camera: Bool = true,
                      mediaType : [String] = [kUTTypeImage as String]) {
        
        let chooseOptionText =  AppStrings.chooseOptions.localized
        let alertController = UIAlertController(title: chooseOptionText, message: nil, preferredStyle: UIDevice.current.userInterfaceIdiom == .pad ? .alert:.actionSheet)
        
        if photoGallery {
            
            let chooseFromGalleryText =  AppStrings.chooseFromGallery.localized
            let alertActionGallery = UIAlertAction(title: chooseFromGalleryText, style: .default) { _ in
                self.checkAndOpenLibrary(delegate: controller, mediaType: mediaType)
            }
            alertController.addAction(alertActionGallery)
        }
        
        if camera {
            
            let takePhotoText =  AppStrings.takePhoto.localized
            let alertActionCamera = UIAlertAction(title: takePhotoText, style: .default) { action in
                self.checkAndOpenCamera(delegate: controller, mediaType: mediaType)
            }
            alertController.addAction(alertActionCamera)
        }
        
        let cancelText =  AppStrings.cancel.localized
        let alertActionCancel = UIAlertAction(title: cancelText, style: .cancel) { _ in
        }
        alertController.addAction(alertActionCancel)
        
        controller.present(alertController, animated: true, completion: nil)
    }
    
    func checkAndOpenCamera(delegate controller: ImagePickerDelegateController,mediaType : [String] = [kUTTypeImage as String]) {
        
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authStatus {
        
        case .authorized:
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = controller
            imagePicker.mediaTypes = mediaType
            imagePicker.videoMaximumDuration = 15
            let sourceType = UIImagePickerController.SourceType.camera
            if UIImagePickerController.isSourceTypeAvailable(sourceType) {
                
                imagePicker.sourceType = sourceType
                imagePicker.allowsEditing = false
                
                if imagePicker.sourceType == .camera {
                    imagePicker.showsCameraControls = true
                }
                controller.present(imagePicker, animated: true, completion: nil)
                
            } else {
                
                let cameraNotAvailableText = AppStrings.cameraNotAvailable.localized
                self.showAlert(title: "Error", msg: cameraNotAvailableText)
            }
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { granted in
                
                if granted {
                    
                    DispatchQueue.mainQueueAsync {
                        let imagePicker = UIImagePickerController()
                        imagePicker.delegate = controller
                        imagePicker.mediaTypes = mediaType
                        imagePicker.videoMaximumDuration = 15
                        
                        let sourceType = UIImagePickerController.SourceType.camera
                        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
                            
                            imagePicker.sourceType = sourceType
                            if imagePicker.sourceType == .camera {
                                imagePicker.allowsEditing = false
                                imagePicker.showsCameraControls = true
                            }
                            controller.present(imagePicker, animated: true, completion: nil)
                            
                        } else {
                            let cameraNotAvailableText = AppStrings.cameraNotAvailable.localized
                            self.showAlert(title: "Error", msg: cameraNotAvailableText)
                        }
                    }
                }
            })
            
        case .restricted:
            alertPromptToAllowCameraAccessViaSetting(AppStrings.restrictedFromUsingCamera.localized)
            
        case .denied:
            alertPromptToAllowCameraAccessViaSetting(AppStrings.changePrivacySettingAndAllowAccessToCamera.localized)
        @unknown default:
            break
        }
    }
    
    func checkAndOpenLibrary(delegate controller: ImagePickerDelegateController, mediaType : [String] = [kUTTypeImage as String], allowsEditing: Bool = true) {
        
        let authStatus = PHPhotoLibrary.authorizationStatus()
        switch authStatus {
        case .limited:
            break
        case .notDetermined:
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = controller
            imagePicker.mediaTypes = mediaType
            let sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.sourceType = sourceType
            imagePicker.allowsEditing = allowsEditing
            imagePicker.videoMaximumDuration = 15
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemBlue], for: .normal)
            controller.present(imagePicker, animated: true, completion: nil)
            
        case .restricted:
            alertPromptToAllowCameraAccessViaSetting(AppStrings.restrictedFromUsingLibrary.localized)
            
        case .denied:
            alertPromptToAllowCameraAccessViaSetting(AppStrings.changePrivacySettingAndAllowAccessToLibrary.localized)
            
        case .authorized:
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = controller
            let sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.sourceType = sourceType
            imagePicker.allowsEditing = allowsEditing
            imagePicker.mediaTypes = mediaType
            imagePicker.videoMaximumDuration = 15
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemBlue], for: .normal)
            controller.present(imagePicker, animated: true, completion: nil)
        @unknown default:
            break
        }
    }
    
    private func alertPromptToAllowCameraAccessViaSetting(_ message: String) {
        
        let alertText = AppStrings.alert.localized
        let cancelText = AppStrings.cancel.localized
        let settingsText = AppStrings.settings.localized
        
        let alert = UIAlertController(title: alertText, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: settingsText, style: .default, handler: { (action) in
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
                UIApplication.shared.openURL(URL(string: UIApplication.openSettingsURLString)!)
            }
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: cancelText, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    ///Adds Child View Controller to Parent View Controller
    func add(childViewController:UIViewController){
        
        self.addChild(childViewController)
        childViewController.view.frame = self.view.bounds
        self.view.addSubview(childViewController.view)
        childViewController.didMove(toParent: self)
    }
    
    ///Removes Child View Controller From Parent View Controller
    var removeFromParent:Void{
        
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    ///Updates navigation bar according to given values
    func updateNavigationBar(withTitle title:String? = nil, leftButton:UIBarButtonItem? = nil, rightButton:UIBarButtonItem? = nil, tintColor:UIColor? = nil, barTintColor:UIColor? = nil, titleTextAttributes: [NSAttributedString.Key : Any]? = nil){
        
        self.navigationController?.isNavigationBarHidden = false
        if let tColor = barTintColor{
            self.navigationController?.navigationBar.barTintColor = tColor
        }
        if let tColor = tintColor{
            self.navigationController?.navigationBar.tintColor = tColor
        }
        if let button = leftButton{
            self.navigationItem.leftBarButtonItem = button;
        }
        if let button = rightButton{
            self.navigationItem.rightBarButtonItem = button;
        }
        if let ttle = title{
            self.title = ttle
        }
        if let ttleTextAttributes = titleTextAttributes{
            self.navigationController?.navigationBar.titleTextAttributes =   ttleTextAttributes
        }
    }
    
    //function to pop the target from navigation Stack
    @objc func pop(animated: Bool = true) {
        self.navigationController?.popViewController(animated: animated)
    }
    
    @objc func popToRoot(animated: Bool = true) {
        self.navigationController?.popToRootViewController(animated: animated)
    }
    
    func popToSpecificViewController(atIndex index: Int, animated: Bool = true) {
        if let navVc = self.navigationController, navVc.viewControllers.count > index {
            self.navigationController?.popToViewController(navVc.viewControllers[index], animated: animated)
        }
    }
    
    func popMultipleViewController(count: Int, animated: Bool = true) {
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            let actualCount = count + 1
            guard viewControllers.count < actualCount else {
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - actualCount], animated: animated)
                return
            }
        }
    }
    
    func showAlert( title : String = "", msg : String,_ completion : (()->())? = nil) {
        
        let alertViewController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: AppStrings.ok.localized, style: UIAlertAction.Style.default) { (action : UIAlertAction) -> Void in
            
            alertViewController.dismiss(animated: true, completion: nil)
            completion?()
        }
        
        alertViewController.addAction(okAction)
        
        self.present(alertViewController, animated: true, completion: nil)
        
    }
    
    func showAlertwithTwoButton( title : String = "", msg : String,_ completion : (()->())? = nil) {
        
        let alertViewController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: AppStrings.ok.localized, style: UIAlertAction.Style.default) { (action : UIAlertAction) -> Void in
            alertViewController.dismiss(animated: true, completion: nil)
            completion?()
        }
        
        let cancelAction = UIAlertAction(title: AppStrings.cancel.localized, style: UIAlertAction.Style.default) { (action : UIAlertAction) -> Void in
            
            alertViewController.dismiss(animated: true, completion: nil)
        }
        
        alertViewController.addAction(cancelAction)
        alertViewController.addAction(okAction)
        
        self.present(alertViewController, animated: true, completion: nil)
        
    }
    
    func showAlertwithTwoButtonWithCancelCompletion( title : String = "", msg : String,_ completion : (()->())? = nil,_ cancelCompletion : (()->())? = nil) {
        
        let alertViewController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: AppStrings.confirm.localized, style: UIAlertAction.Style.default) { (action : UIAlertAction) -> Void in
            alertViewController.dismiss(animated: true, completion: nil)
            completion?()
        }
        
        let cancelAction = UIAlertAction(title: AppStrings.cancel.localized, style: UIAlertAction.Style.default) { (action : UIAlertAction) -> Void in
            
            alertViewController.dismiss(animated: true, completion: nil)
            cancelCompletion?()
        }
        
        alertViewController.addAction(cancelAction)
        alertViewController.addAction(okAction)
        
        self.present(alertViewController, animated: true, completion: nil)
        
    }
    
    func showAlertWithTitleAndAction(title: String = "", msg : String, okTitle: String? = nil, _ okCompletion : (()->())? = nil) {
        let alertViewController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: okTitle ?? AppStrings.confirm.localized, style: UIAlertAction.Style.default) { (action : UIAlertAction) -> Void in
            okCompletion?()
        }
        alertViewController.addAction(okAction)
        let cancelAction = UIAlertAction(title: AppStrings.cancel.localized, style: UIAlertAction.Style.default, handler: nil)
        alertViewController.addAction(cancelAction)
        self.present(alertViewController, animated: true, completion: nil)
    }
}

extension UIViewController {

    @objc func logoutUser() {
        DispatchQueue.mainQueueAsync {
            self.showAlertWithTitleAndAction(title: AppStrings.logout.localized,
                                             msg: AppStrings.areYouSureLogout.localized,
                                             okTitle: AppStrings.logout.localized) {
                let service = WebServices()
                service.logout() { (model: ErrorData?) in
                    self.removeDataAndNavigate()
                } failure: { (_, errorData) in
                    self.removeDataAndNavigate()
                }
            }
        }
    }
    
    func removeDataAndNavigate() {
        Defaults.removeUnPreservedData()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        let vc = LoginViewController.instantiate(fromAppStoryboard: .main)
        self.presentWithNavigation(vc, animated: true, completion: nil)
    }
    
    /// Share
    func textShare(textURL: String) {
        let shareController = UIActivityViewController(activityItems: [textURL as AnyObject], applicationActivities: nil)
        shareController.popoverPresentationController?.sourceView = self.view
        self.present(shareController, animated: true, completion: nil)
    }
    
    func shareImageWithText(image: UIImage, text: String) {
        let shareController = UIActivityViewController(activityItems: [image as AnyObject, text as AnyObject], applicationActivities: nil)
        shareController.popoverPresentationController?.sourceView = self.view
        self.present(shareController, animated: true, completion: nil)
    }
    
    func setCurrencyTitleView(currency: Cryptocurrencies?, title: String? = nil) {
        let btn = UIButton(frame: .zero)
        btn.setImage(currency?.assetId?.iconFromCurrencyCode, for: .normal)
        btn.setTitle( title ?? currency?.currencyName, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        self.navigationItem.titleView = btn
    }
    
    func setCurrencyTitleView(currency: CryptoCurrency?, title: String? = nil) {
        let btn = UIButton(frame: .zero)
        btn.setImage(currency?.assetId?.iconFromCurrencyCode, for: .normal)
        btn.setTitle(title ?? currency?.assetId?.currencyNameFromCode, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        self.navigationItem.titleView = btn
    }
    
    func setCurrencyTitleView(currency: CurrencyModel?, title: String? = nil) {
        let btn = UIButton(frame: .zero)
        btn.setImage(currency?.assetId.iconFromCurrencyCode, for: .normal)
        btn.setTitle(title ?? currency?.assetId.currencyNameFromCode, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        self.navigationItem.titleView = btn
    }
}
