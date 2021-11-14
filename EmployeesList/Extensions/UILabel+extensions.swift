//
//  UILabel+extensions.swift
//  WiseHouse
//
//  Created by Anton Stremovskiy on 31.07.2020.
//  Copyright © 2020 Shooting App. All rights reserved.
//

import UIKit

extension UILabel {
    func getSize(constrainedWidth: CGFloat) -> CGSize {
        return systemLayoutSizeFitting(CGSize(width: constrainedWidth,
                                              height: UIView.layoutFittingCompressedSize.height),
                                       withHorizontalFittingPriority: .required,
                                       verticalFittingPriority: .fittingSizeLevel)
    }
}

extension UILabel {
    var numberOfVisibleLines: Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        let textHeight = sizeThatFits(maxSize).height
        let lineHeight = font.lineHeight
        return Int(ceil(textHeight / lineHeight))
    }
}

extension UILabel {
    var maxNumberOfLines: Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        let text = (self.text ?? "") as NSString
        let textHeight = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font ?? UIFont.systemFont(ofSize: 16)], context: nil).height
        let lineHeight = font.lineHeight
        return Int(ceil(textHeight / lineHeight))
    }
}
