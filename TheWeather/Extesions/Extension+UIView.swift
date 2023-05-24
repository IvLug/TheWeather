//
//  Extension+UIView.swift
//  TheWeather
//
//  Created by Иван Луганцов on 23.05.2023.
//

import UIKit

extension UIView{
    
    func rotate(repeatCount: Float = Float.greatestFiniteMagnitude, duration: CFTimeInterval = 1) {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.toValue = CGFloat(.pi * 2.0)
        rotation.duration = duration
        rotation.isCumulative = true
        rotation.repeatCount = repeatCount
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func addShadow(color shadowColor: UIColor = UIColor(white: 0.0, alpha: 0.3),
                   opacity _opacity: Float = 0.3,
                   radius _radius: CGFloat = 5.0,
                   shadowOffset _shadowOffset: CGSize = CGSize(width: 0.0, height: 0.0)) {
        self.layer.masksToBounds = false

        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = _opacity
        self.layer.shadowOffset = _shadowOffset
        self.layer.shadowRadius = _radius
    }
}

