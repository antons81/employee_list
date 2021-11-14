//
//  UINavigationBar+extensions.swift
//  Kyivpride
//
//  Created by Anton Stremovskiy on 15.04.2021.
//

import UIKit

extension UINavigationBar {
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: size.height)
    }
}
