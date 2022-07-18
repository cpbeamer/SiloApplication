//
//  UIImageExtension.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

extension UIImage {
    func compressTo(bytes: Int) -> UIImage {
        var compression: CGFloat = 1.0
        let maxCompression: CGFloat = 0.1
        let maxSize: Int = bytes
        var imageData = jpegData(compressionQuality: compression)!
        while imageData.count > maxSize && compression > maxCompression {
            compression -= 0.01
            imageData = jpegData(compressionQuality: compression)!
        }
        return UIImage(data: imageData)!
    }
}
