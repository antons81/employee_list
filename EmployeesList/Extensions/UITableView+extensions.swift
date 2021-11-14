//
//  UITableView+extensions.swift
//  WiseHouse
//
//  Created by Anton Stremovskiy on 24.06.2020.
//  Copyright © 2020 Shooting App. All rights reserved.
//

import Foundation
import UIKit

protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String { return String(describing: self) }
}

protocol NibReusable: Reusable {
    static var nib: UINib { get }
}

extension NibReusable {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}

extension UITableView {
    func registerCellNib<T: UITableViewCell>(_: T.Type) where T: NibReusable {
        let nib = UINib(nibName: String(describing: T.self), bundle: nil)
        self.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: Reusable>(indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as! T
    }
}


extension UICollectionView {
    
    func registerCellNib<T: UICollectionViewCell>(_: T.Type) where T: NibReusable {
        let nib = UINib(nibName: String(describing: T.self), bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerReusableHeaderNib<T: UICollectionReusableView>(_: T.Type) where T: NibReusable {
        let nib = UINib(nibName: String(describing: T.self), bundle: nil)
        self.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerReusableFooterNib<T: UICollectionReusableView>(_: T.Type) where T: NibReusable {
        let nib = UINib(nibName: String(describing: T.self), bundle: nil)
        self.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: Reusable>(indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as! T
    }
    
    func dequeueReusableHeader<T: Reusable>(indexPath: IndexPath) -> T {
        return self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    func dequeueReusableFooter<T: Reusable>(indexPath: IndexPath) -> T {
        return self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}

extension UITableView {
    func lastIndexpath() -> IndexPath? {
        let section = max(numberOfSections - 1, 0)
        let row = max(numberOfRows(inSection: section) - 1, 0)
        return IndexPath(row: row, section: section)
    }
}
