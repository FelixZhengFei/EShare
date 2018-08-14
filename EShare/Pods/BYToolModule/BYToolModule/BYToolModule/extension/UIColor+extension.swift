//
//  UIColor+extension.swift
//  FFToolModule
//
//  Created by 郑强飞 on 2017/4/19.
//  Copyright © 2017年 郑强飞. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    // MARK: - 16进制颜色
    /**16进制颜色*/
    static public func ff_HexColor(_ hexValue: UInt32) -> UIColor {
        let r = (hexValue & 0xff0000) >> 16
        let g = (hexValue & 0x00ff00) >> 8
        let b = hexValue & 0x0000ff
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
    }
    
    // MARK: - RGBA
    /**RGBA*/
    static public func RGBA(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {return UIColor(
        red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: (a))
    }
    
    // MARK: - RGB
    /**RGB*/
    static public func RGB(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
        return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: (1))
    }
    
    // MARK: - 返回随机颜色
    /**随机颜色*/
    static public var randomColor: UIColor {
        get {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}
