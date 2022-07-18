//
//  CommonFunctions.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

import Foundation
import NVActivityIndicatorView
import MobileCoreServices
import SKToast
import CoreLocation
import EventKit

class CommonFunctions {
    
    /// Delay Functions
    class func delay(delay:Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when) {
            closure()
        }
    }
    
    /// Show Toast With Message
    static func showToastWithMessage(_ msg: String, completion: (() -> Swift.Void)? = nil) {
        
        DispatchQueue.mainQueueAsync {
            SKToast.backgroundStyle(UIBlurEffect.Style.extraLight)
            SKToast.messageFont(UIFont.systemFont(ofSize: 14, weight: .medium))
            SKToast.messageTextColor(AppColors.primary ?? UIColor.black)
            SKToast.show(withMessage: msg, completionHandler: {
                completion?()
            })
        }
    }
    
    /// Show Action Sheet With Actions Array
    class func showActionSheetWithActionArray(_ title: String?, message: String?,
                                              viewController: UIViewController,
                                              alertActionArray : [UIAlertAction],
                                              preferredStyle: UIAlertController.Style)  {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        alertActionArray.forEach{ alert.addAction($0) }
        alert.popoverPresentationController?.sourceView = viewController.view
        DispatchQueue.mainQueueAsync {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    /// Show Activity Loader
    class func showActivityLoader() {
        DispatchQueue.mainQueueAsync {
            AppDelegate.currentWindow?.startBlockingActivityIndicator()
        }
    }
    
    /// Show Activity Loader
    class func isIndicatorActive() -> Bool {
        return AppDelegate.currentWindow?.isIndicatorActive() ?? false
    }
    
    /// Hide Activity Loader
    class func hideActivityLoader() {
        DispatchQueue.mainQueueAsync {
            AppDelegate.currentWindow?.stopBlockingActivityIndicator()
        }
    }
    
    static func getCurrentTimeZone() -> Int{
        return Int (TimeZone.current.secondsFromGMT())
    }
    
    static func convertToUTC(dateToConvert:String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = Date.DateFormat.yyyyMMddHHmmss.rawValue
        let convertedDate = formatter.date(from: dateToConvert)
        formatter.timeZone = TimeZone(identifier: "UTC")
        return convertedDate!
        //formatter.string(from: convertedDate!)
    }
    
    static func convertIntoTimestamp(dateFormat:String) -> Int64{
        let formatter = DateFormatter()
        formatter.dateFormat =  Date.DateFormat.yyyyMMddHHmmss.rawValue
        let date = formatter.date(from: dateFormat)
        let dateStamp:TimeInterval = date!.timeIntervalSince1970
        let dateSt:Int64 = Int64(dateStamp)
        return dateSt
    }
    
    /// Alerts
    static func alertOk(message: String = "", action: (() -> ())?) {
        let alertController = UIAlertController(title: AppStrings.appTitle.localized, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: AppStrings.ok.localized, style: .default) { _ in
            action?()
        }
        alertController.addAction(ok)
        let root = AppDelegate.currentViewController
        root?.present(alertController, animated: true, completion: nil)
    }
    
    static func openAlert(title: String? = nil, message: String? = nil, noBtnTapped: @escaping (Bool) -> (Void), yesBtnTapped: @escaping (Bool) -> (Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title:  AppStrings.yes.localized, style: .default, handler: { action in
            yesBtnTapped(true)
        }))
        
        
        alert.addAction(UIAlertAction(title: AppStrings.no.localized, style: .default, handler: { action in
            noBtnTapped(true)
        }))
        
        let root = AppDelegate.currentViewController
        root?.present(alert, animated: true, completion: nil)
    }
    
    static func isLocationAccessEnabled() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                debugPrint("No access")
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                debugPrint("Access")
                return true
            @unknown default:
                debugPrint("Location services not enabled")
                return false
            }
        } else {
            debugPrint("Location services not enabled")
            return false
        }
    }
    
    static func calendarPermission()->Bool{
        let eventStore = EKEventStore()
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            debugPrint("Authorized")
            return true
            
        case .denied:
            debugPrint("Access denied")
            return false
            
        case .notDetermined:
            var check = false
            eventStore.requestAccess(to: .event, completion:
                {(granted: Bool, error: Error?) -> Void in
                    if granted {
                        debugPrint("Access granted")
                        check = true
                    } else {
                        debugPrint("Access denied")
                        check = false
                    }
            })
            debugPrint("Not Determined")
            return check
        default:
            debugPrint("Case Default")
            return false
        }
    }
    
    static func alertPromptToAllowCalendar(_ message: String) {
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
        let root = AppDelegate.currentViewController
        root?.present(alert, animated: true, completion: nil)
    }
    
    static func openSettingApp(_ message: String) {
        let alertController = UIAlertController (title: AppStrings.appTitle.localized, message:message , preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: NSLocalizedString(AppStrings.settings.localized, comment: ""), style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: NSLocalizedString(AppStrings.cancel.localized, comment: ""), style: .default, handler: nil)
        alertController.addAction(cancelAction)
        let root = AppDelegate.currentViewController
        root?.present(alertController, animated: true, completion: nil)
    }
    
    static func imageIsEmptyOrNot(imageName : UIImage)-> Bool {
        let size = CGSize(width: 0, height: 0)
        if (imageName.size.width == size.width) {
            return false
        } else{
            return true
        }
    }
    
    static func jsonToString(_ dict: JSONDictionary) -> String {
        do{
            let data =  try JSONSerialization.data(withJSONObject: dict, options: [])
            let JSONString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
            return JSONString
        } catch{
            return error.localizedDescription
        }
    }
    
    static func stringToJson(_ string: String?) -> JSONDictionary? {
        if let data = string?.data(using: .utf8) {
            return dataToJson(data)
        }
        return nil
    }
    
    static func jsonToData(_ json: JSONDictionary?) -> Data? {
        if let json = json {
            do {
                return try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch let myJSONError {
                debugPrint(myJSONError)
            }
        }
        return nil;
    }
    
    static func dataToJson(_ data: Data?) -> JSONDictionary? {
        if let data = data {
            do {
                return try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? JSONDictionary
            } catch let myJSONError {
                debugPrint(myJSONError)
            }
        }
        return nil;
    }
    
    static func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
    static func generateQRCode(from json: JSONDictionary) -> UIImage? {
        if let data = CommonFunctions.jsonToData(json) {
            if let filter = CIFilter(name: "CIQRCodeGenerator") {
                filter.setValue(data, forKey: "inputMessage")
                let scale: CGFloat = 5
                let transform = CGAffineTransform(scaleX: scale, y: scale)
                if let output = filter.outputImage?.transformed(by: transform),
                   let data = UIImage(ciImage: output).pngData() {
                    return UIImage(data: data)
                }
            }
        }
        return nil
    }
    
    static func getIPAddress() -> String {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }

                guard let interface = ptr?.pointee else { return "" }
                let addrFamily = interface.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {

                    // wifi = ["en0"]
                    // wired = ["en2", "en3", "en4"]
                    // cellular = ["pdp_ip0","pdp_ip1","pdp_ip2","pdp_ip3"]
                    let name: String = String(cString: (interface.ifa_name))
                    if  name == "en0" || name == "en2" || name == "en3" || name == "en4" || name == "pdp_ip0" || name == "pdp_ip1" || name == "pdp_ip2" || name == "pdp_ip3" {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface.ifa_addr, socklen_t((interface.ifa_addr.pointee.sa_len)), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        return address ?? ""
    }
}
