//
//  Double+extension.swift
//  FFToolModule
//
//  Created by 郑强飞 on 2017/4/19.
//  Copyright © 2017年 郑强飞. All rights reserved.
//

import Foundation
import UIKit
extension Double {
    
    // MARK: - 用法 let myDouble = 1.234567  println(myDouble.format(".2") .2代表留2位小数点
    /**用法 let myDouble = 1.234567  println(myDouble.format(".2") .2代表留2位小数点*/
    public func format(_ f: String) -> String {
        return NSString(format: "%\(f)f" as NSString, self) as String
    }
    
    //MARK:金额格式化 12.00
    /**金额格式化 12.00*/
    public func toRMBBalanceFormat() -> String {
        let nf = NumberFormatter()
        nf.numberStyle = .currency
        nf.currencySymbol = ""
        return nf.string(from: NSNumber(value: self))!
    }
    
    //MARK:金额格式化
    /**金额格式化*/
    public func toBalanceFormat() -> String {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        return nf.string(from: NSNumber(value: self))!
    }
    
    //MARK:金额格式化
    /**金额格式化*/
    public func toIntFormat() -> String {
        return String(format: "%.0f",self)

    }
    
    
    //MARK:大数字格式化
    /**大数字格式化*/
    public func toBigString(decimal: Int = 2) -> String {
        if self < 100000 {
            return String(format: "%.\(decimal)f", self)
        } else if self <= 10000*10000 {
            return String(format: "%.\(decimal)f", self/10000) + "万"
        } else {
            return String(format: "%.\(decimal)f", self/(10000*10000)) + "亿"
        }
    }
    /**屏幕适配*/
    public func autoFit()->Double {
        let min = UIScreen.main.bounds.height < UIScreen.main.bounds.width ? UIScreen.main.bounds.height :UIScreen.main.bounds.width
        return Double(min) / 375 * self
    }
    
    /**屏幕适配*/
    public func autoFitFloat()->CGFloat {
        let min = UIScreen.main.bounds.height < UIScreen.main.bounds.width ? UIScreen.main.bounds.height :UIScreen.main.bounds.width
        return CGFloat(Double(min) / 375.0 * self)
    }
}

extension CGRect {
    /**屏幕适配*/
    public func autoFit()->CGRect {
        var width = self.size.width * UIScreen.main.bounds.width / 375
        if self.size.width == UIScreen.main.bounds.width {
            width = self.size.width
        }
        var height = self.size.height * UIScreen.main.bounds.width / 375
        if self.size.height == UIScreen.main.bounds.height {
            height = self.size.height
        }
        return CGRect(x: 0, y: 0, width: width, height: height)
    }
}
