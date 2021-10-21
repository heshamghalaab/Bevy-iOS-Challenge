//
//  UIView+GradientColor.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 21/10/2021.
//

import UIKit

extension UIView{
    func insertDefaultGradientLayer(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.backgroundColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
