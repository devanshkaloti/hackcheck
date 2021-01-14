//
//  Cards.swift
//  myHSC
//
//  Created by Devansh Kaloti
//  Copyright © 2019 Devansh Kaloti. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class Cards: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 8
    
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 1
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.09
    
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
        

    }
    
}


@IBDesignable
class NewCards: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 8

    @IBInspectable var borderWidth: CGFloat = 1
    @IBInspectable var borderColor: UIColor? = UIColor(named: "EFEFF4")

    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor?.cgColor

        
        
    }
    
}




@IBDesignable
class Buttons: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 8
    
    @IBInspectable var borderWidth: CGFloat = 1
    @IBInspectable var borderColor: UIColor? = UIColor(named: "EFEFF4")
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
            layer.masksToBounds = false
        
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor?.cgColor
        
        
        
    }
    
}
