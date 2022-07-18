//
//  UICollectionView+UICollectionViewCellExtension.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation
import UIKit

typealias CollectionDelegate = UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout

//MARK:-
extension UICollectionView {
    
    ///Returns cell for the given item
    func cell(forItem item: AnyObject) -> UICollectionViewCell? {
        if let indexPath = self.indexPath(forItem: item){
            return self.cellForItem(at: indexPath)
        }
        return nil
    }
    
    ///Returns the indexpath for the given item
    func indexPath(forItem item: AnyObject) -> IndexPath? {
        let buttonPosition: CGPoint = item.convert(CGPoint.zero, to: self)
        return self.indexPathForItem(at: buttonPosition)
    }
    
    ///Registers the given cell
    func registerClass(cellType:UICollectionViewCell.Type){
        register(cellType, forCellWithReuseIdentifier: cellType.defaultReuseIdentifier)
    }
    
    ///dequeues a reusable cell for the given indexpath
    func dequeueReusableCellForIndexPath<T: UICollectionViewCell>(indexPath: NSIndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath as IndexPath) as? T else {
            fatalError( "Failed to dequeue a cell with identifier \(T.defaultReuseIdentifier).  Ensure you have registered the cell" )
        }
        
        return cell
    }
    
    ///Register Collection View Cell Nib
    func registerCell(with identifier: UICollectionViewCell.Type)  {
        self.register(UINib(nibName: "\(identifier.self)", bundle: nil), forCellWithReuseIdentifier: "\(identifier.self)")
    }
    
    ///Dequeue Collection View Cell
    func dequeueCell <T: UICollectionViewCell> (with identifier: T.Type, indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: "\(identifier.self)", for: indexPath) as! T
    }
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        //         messageLabel.font = AppFonts.PoppinsMedium.withSize(14)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
    }
    
    func restore() {
        self.backgroundView?.isHidden = true
    }
}

extension UICollectionViewCell{
    public static var defaultReuseIdentifier:String{
        return "\(self)"
    }
}

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            
            layoutAttribute.frame.origin.x = leftMargin
            
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }
        
        return attributes
    }
}

extension UICollectionViewCell{
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    static var identifier: String {
        return String(describing: self)
    }
}

