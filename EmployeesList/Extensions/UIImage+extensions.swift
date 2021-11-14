//
//  UIImage+extensions.swift
//  Employees
//
//  Created by Anton Stremovskiy on 31.08.2021.
//

import UIKit

extension UIImage {
    
    func imageByCombiningImage(withImage secondImage: UIImage) -> UIImage? {
        
        let newImageSize = CGSize(width: self.size.width, height: self.size.height)
        
        UIGraphicsBeginImageContextWithOptions(newImageSize, false, 0)
        
        let firstImageDrawX = round((newImageSize.width  - self.size.width  ) / 2)
        let firstImageDrawY = round((newImageSize.height - self.size.height ) / 2)

        self.draw(at: CGPoint(x: firstImageDrawX,  y: firstImageDrawY))
        secondImage.draw(in: CGRect(x: 0, y: self.size.height - 145, width: self.size.width, height: 350), blendMode: .normal, alpha: 1)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        return image
    }
    
    func merge(withImage: UIImage) -> UIImage? {
        
        let size = CGSize(width: self.size.width, height: self.size.height / 4)
        UIGraphicsBeginImageContext(size)
        
        let area = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        self.draw(in: area)
        withImage.draw(in: area, blendMode: .normal, alpha: 1)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

extension UIImageView {
    
    func enableZoom() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
        isUserInteractionEnabled = true
        addGestureRecognizer(pinchGesture)
    }
    
    @objc
    private func startZooming(_ sender: UIPinchGestureRecognizer) {
        let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
        guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
        sender.view?.transform = scale
        sender.scale = 1
    }
}
