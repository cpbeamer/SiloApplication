//
//  UITableView+UITableViewCellExtension.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation
import UIKit

typealias TableDelegate = UITableViewDelegate & UITableViewDataSource

//MARK:-
extension UITableView {
    
    ///Dequeue Table View Cell
    func dequeueCell <T: UITableViewCell> (with identifier: T.Type) -> T {
        return self.dequeueReusableCell(withIdentifier: "\(identifier.self)") as! T
    }
    
    ///Returns cell for the given item
    func cell(forItem item: Any) -> UITableViewCell? {
        if let indexPath = self.indexPath(forItem: item){
            return self.cellForRow(at: indexPath)
        }
        return nil
    }
    
    ///Returns the indexpath for the given item
    func indexPath(forItem item: Any) -> IndexPath? {
        let itemPosition: CGPoint = (item as AnyObject).convert(CGPoint.zero, to: self)
        return self.indexPathForRow(at: itemPosition)
    }
    
    ///Registers the given cell
    func registerClass(cellType:UITableViewCell.Type){
        register(cellType, forCellReuseIdentifier: cellType.defaultReuseIdentifier)
    }
    
    ///dequeues a reusable cell for the given indexpath
    func dequeueReusableCellForIndexPath<T: UITableViewCell>(indexPath: NSIndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier , for: indexPath as IndexPath) as? T else {
            fatalError( "Failed to dequeue a cell with identifier \(T.defaultReuseIdentifier). Ensure you have registered the cell." )
        }
        
        return cell
    }
    
    func indexPathForCells(inSection: Int, exceptRows: [Int] = []) -> [IndexPath] {
        let rows = self.numberOfRows(inSection: inSection)
        var indices: [IndexPath] = []
        for row in 0..<rows {
            if exceptRows.contains(row) { continue }
            indices.append([inSection, row])
        }
        
        return indices
    }
    
    ///Register Table View Cell Nib
    func registerCell(with identifier: UITableViewCell.Type)  {
        self.register(UINib(nibName: "\(identifier.self)",bundle:nil),
                      forCellReuseIdentifier: "\(identifier.self)")
    }
    
    ///Register Header Footer View Nib
    func registerHeaderFooter(with identifier: UITableViewHeaderFooterView.Type)  {
        self.register(UINib(nibName: "\(identifier.self)",bundle:nil), forHeaderFooterViewReuseIdentifier: "\(identifier.self)")
    }
    
    ///Dequeue Table View Cell
    func dequeueCell <T: UITableViewCell> (with identifier: T.Type, indexPath: IndexPath? = nil) -> T {
        if let index = indexPath {
            return self.dequeueReusableCell(withIdentifier: "\(identifier.self)", for: index) as! T
        } else {
            return self.dequeueReusableCell(withIdentifier: "\(identifier.self)") as! T
        }
    }
    
    ///Dequeue Header Footer View
    func dequeueHeaderFooter <T: UITableViewHeaderFooterView> (with identifier: T.Type) -> T {
        return self.dequeueReusableHeaderFooterView(withIdentifier: "\(identifier.self)") as! T
    }
}

extension UITableViewCell {
    public static var defaultReuseIdentifier: String {
        return "\(self)"
    }
}

extension UITableView {
    
    func setEmptyMessage(_ message: String) {
        let alart = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        alart.textAlignment = .center
        alart.numberOfLines = 0
        alart.text = message
        alart.textColor = AppColors.title
        alart.sizeToFit()
        self.backgroundView = alart
    }
    
    func setEmptyMessageOnTop(_ message: String) {
        let alart = PaddingLabel(withInsets: 20, 20, self.frame.height - 20, 20)
        alart.textAlignment = .center
        alart.numberOfLines = 0
        alart.text = message
        alart.textColor = AppColors.title
        alart.sizeToFit()
        self.backgroundView = alart
    }
    
    func setAnimatedBackView(_ imageName: UIImage, message: String){
        
        let tableViewBounds = self.bounds
        
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: tableViewBounds.size.width, height:  tableViewBounds.size.height))
        
        let imageView = UIImageView(image: imageName)
        let messageLabel = UILabel()
        
        backView.addSubview(imageView)
        backView.addSubview(messageLabel)
        messageLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        //        messageLabel.textColor = AppColors.gray
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 2
        
        imageView.frame = CGRect(x: (backView.bounds.width/2 - 42), y: (backView.bounds.height/2 - 80), width: 65, height: 65)
        messageLabel.center = imageView.center
        messageLabel.frame = CGRect(x: 0, y: (backView.bounds.height/2 - 30), width: tableViewBounds.size.width - 20, height: 100)
        messageLabel.text = message
        
        self.backgroundView = backView
        imageView.shake()
        
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
