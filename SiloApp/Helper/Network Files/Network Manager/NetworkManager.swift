//
//  NetworkManager.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation
import Alamofire
import MobileCoreServices

typealias JSONDictionary = [String : Any]
typealias JSONDictionaryArray = [JSONDictionary]

class NetworkManager: NSObject {

    //Set Basic Headers
    static func getHeaders() -> HTTPHeaders {
        let currentTimeOffSet = CommonFunctions.getCurrentTimeZone()
        var header : HTTPHeaders = [:]
        if let authToken = Defaults.authToken {
            header[ApiKey.authorization] = "Bearer \(authToken)"
        }
        header[ApiKey.deviceID] = UIDevice.current.identifierForVendor?.uuidString
        header[ApiKey.deviceToken] = Defaults.deviceToken
        header[ApiKey.timeZone] = "\(currentTimeOffSet * 1000)"
        header[ApiKey.platform] = "2"
        return header
    }
    
    func request<T>(params: JSONDictionary, extraURLComponents: [String] = [], method: HTTPMethod, endPoint: EndPoint,
                 encoding: ParameterEncoding = URLEncoding.default,
                 headers : HTTPHeaders = [:], loader : Bool = true,
                 success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        if loader { CommonFunctions.showActivityLoader() }
        
        //Managing request URL, Parameters & Headers
        let urlString: String = endPoint.path(extraURLComponents)
        var localEncoding: ParameterEncoding = encoding
        if method != .get && method != .delete {
            localEncoding = JSONEncoding.default
        }
        var allHeaders: HTTPHeaders = NetworkManager.getHeaders()
        for (key, value) in headers.dictionary {
            allHeaders[key] = value
        }
        
        //Log request data
        self.logRequest(method: method, encoding: localEncoding, urlString: urlString, headers: allHeaders, params: params)
        
        //Executing request
        AF.request(urlString, method: method, parameters: params, encoding: localEncoding, headers: allHeaders)
            .validate()
            .response { response in
                if loader { CommonFunctions.hideActivityLoader() }
                debugPrint(response.request as Any)
                switch response.result {
                case .success(let resultData):
                    self.manageSuccessBlock(resultData: resultData, debugDescription: response.debugDescription, success: success)
                case .failure(let error):
                    self.manageFailureBlock(error: error, resultData: response.data, debugDescription: response.debugDescription, failure: failure)
                }
            }
    }
    
    func uploadFilesRequest<T>(params: JSONDictionary, endPoint: EndPoint,
                               files: [UploadFileFormat]?, headers : HTTPHeaders = [:],
                               loader : Bool = true, progress : @escaping (Double) -> Void,
                               success : @escaping (T?) -> Void,
                               failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        if loader { CommonFunctions.showActivityLoader() }
        var allHeaders: HTTPHeaders = NetworkManager.getHeaders()
        for (key, value) in headers.dictionary {
            allHeaders[key] = value
        }
        var urlRequest = URLRequest(url: URL(string: endPoint.path())!)
        urlRequest.headers = allHeaders
        urlRequest.method = .post
        
        logRequest(method: .post, urlString: endPoint.path(), headers: allHeaders, params: params, files: files)
        
        AF.upload(multipartFormData: { multipartFormData in
            self.addMultipartData(multipart: multipartFormData, params: params, files: files)
        }, with: urlRequest)
        .uploadProgress(queue: .main, closure: { progressData in
            debugPrint("Current upload progress: \(progressData.fractionCompleted)")
            progress(progressData.fractionCompleted)
        })
        .response { response in
            if loader { CommonFunctions.hideActivityLoader() }
            debugPrint(response.request as Any)
            switch response.result {
            case .success(let resultData):
                self.manageSuccessBlock(resultData: resultData, debugDescription: response.debugDescription, success: success)
            case .failure(let error):
                self.manageFailureBlock(error: error, resultData: response.data, debugDescription: response.debugDescription, failure: failure)
            }
        }
    }
    
    func logRequest(method: HTTPMethod, encoding: ParameterEncoding? = nil,
                    urlString: String?, headers : HTTPHeaders, params: JSONDictionary, files: [UploadFileFormat]? = nil) {
        debugPrint("===================== METHOD =========================")
        debugPrint(method)
        debugPrint("===================== ENCODING =======================")
        debugPrint(encoding as Any)
        debugPrint("===================== URL STRING =====================")
        debugPrint(urlString as Any)
        debugPrint("===================== HEADERS ========================")
        debugPrint(headers)
        debugPrint("===================== PARAMETERS =====================")
        debugPrint(params)
        for item in files ?? [] {
            debugPrint("===================== File Info =====================")
            debugPrint(item.fileName)
            debugPrint(item.fileData.count)
        }
    }
    
    func manageSuccessBlock<T>(resultData: Data?, debugDescription: String,
                               success : @escaping (T?) -> Void) where T: Codable {
        let json = CommonFunctions.dataToJson(resultData)
        debugPrint(json as Any)
//        let jsonData = JSON(json as Any)
//        debugPrint(jsonData)
        if let data = resultData {
            do {
                //here dataResponse received from a network request
                let data = try JSONDecoder().decode(T.self, from: data) //Decode JSON Response Data
                debugPrint(data)
                if json?[ApiKey.statusCode] as? Int == ApiCode.blocked {
                    CommonFunctions.alertOk(message: AppStrings.accountBlocked.localized) {
                        self.removeDataAndNavigate()
                    }
                } else if json?[ApiKey.statusCode] as? Int == ApiCode.sessionExpired {
                    CommonFunctions.alertOk(message: AppStrings.sessionExpired.localized) {
                        self.removeDataAndNavigate()
                    }
                } else {
                    success(data)
                }
            } catch let error {
                debugPrint("Error------>", error)
                debugPrint("Debug Description------>", debugDescription)
                success(nil)
            }
        } else {
            debugPrint("nil received is success response")
            debugPrint("Debug Description------>", debugDescription)
            success(nil)
        }
    }
    
    func manageFailureBlock(error: AFError, resultData: Data?, debugDescription: String,
                               failure : @escaping (Error, ErrorData?) -> Void) {
        //Manage underlying errors
        if let underlyingError = error.underlyingError {
            self.manageUnderlyingErrors(error: underlyingError)
        } else {
            if let data = resultData {
                let json = CommonFunctions.dataToJson(data)
                debugPrint(json as Any)
                do {
                    //here dataResponse received from a network request
                    let data = try JSONDecoder().decode(ErrorData.self, from: data) //Decode JSON Response Data
                    debugPrint(data)
                    if data.statusCode == ApiCode.blocked {
                        CommonFunctions.alertOk(message: AppStrings.accountBlocked.localized) {
                            self.removeDataAndNavigate()
                        }
                    } else if data.statusCode == ApiCode.sessionExpired {
                        CommonFunctions.alertOk(message: AppStrings.sessionExpired.localized) {
                            self.removeDataAndNavigate()
                        }
                    } else {
                        failure(error, data)
                    }
                } catch let error {
                    debugPrint("Error------>", error)
                    debugPrint("Debug Description------>", debugDescription)
                    failure(error, nil)
                }
            } else {
                debugPrint("Debug Description------>", debugDescription)
                failure(error, nil)
            }
        }
    }
    
    func manageUnderlyingErrors(error: Error) {
        if let urlError = error as? URLError {
            switch urlError.code {
            case .timedOut:
                CommonFunctions.showToastWithMessage(AppStrings.requestTimeOut.localized)
            case .notConnectedToInternet:
                CommonFunctions.showToastWithMessage(AppStrings.pleaseCheckInternetConnection.localized)
            case .networkConnectionLost:
                CommonFunctions.showToastWithMessage(urlError.localizedDescription)
            default:
                CommonFunctions.showToastWithMessage(AppStrings.somethingWentWrong.localized)
            }
        }
        CommonFunctions.hideActivityLoader()
    }
    
    func addMultipartData(multipart: MultipartFormData, params: JSONDictionary, files: [UploadFileFormat]?) {
        for (key, value) in params {
            var urlString = ""
            if let value = value as? [String: Any] {
                urlString = value.convertDictionaryToString() ?? ""
            } else if let value = value as? [Any] {
                urlString = value.convertArrayToString() ?? ""
            } else {
                urlString = "\(value)"
            }
            if let data = urlString.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) {
                multipart.append(data, withName: key)
            }
        }
        for item in files ?? [] {
            multipart.append(item.fileData, withName: item.fileKey, fileName: item.fileName, mimeType: self.mimeTypeForPath(fileName: item.fileName))
        }
        debugPrint(multipart)
    }
}

extension NetworkManager {
    
    func removeDataAndNavigate() {
        Defaults.removeUnPreservedData()
        if let nav = (AppDelegate.currentViewController as? UINavigationController), nav.viewControllers.first is LoginViewController {
            nav.popToRootViewController(animated: true)
        } else if !(AppDelegate.currentViewController is LoginViewController) {
            let vc = LoginViewController.instantiate(fromAppStoryboard: .main)
            AppDelegate.currentViewController?.presentWithNavigation(vc, animated: true, completion: nil)
        }
    }

    func mimeTypeForPath(fileName: String) -> String {
        let pathExtension = fileName.components(separatedBy: ".").last ?? ""

        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "image/jpeg"
    }
}
