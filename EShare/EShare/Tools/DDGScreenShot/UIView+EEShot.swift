//
//  UIView+EEGShot.swift
//  lottery
//
//  Created by 郑强飞 on 2018/3/10.
//  Copyright © 2018年 郑强飞 All rights reserved.
//

import UIKit
import WebKit

private var EEGViewScreenShotKey_IsShoting: String = "EEGViewScreenShot_AssoKey_isShoting"

public extension UIView {
    
    public func EEGSetFrame(_ frame: CGRect) {
    }
    
    var isShoting:Bool! {
        get {
            let num = objc_getAssociatedObject(self, &EEGViewScreenShotKey_IsShoting)
            if num == nil {
                return false
            }
            
            if let numObj = num as? NSNumber {
                return numObj.boolValue
            }else {
                return false
            }
        }
        set(newValue) {
            let num = NSNumber(value: newValue as Bool)
            objc_setAssociatedObject(self, &EEGViewScreenShotKey_IsShoting, num, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
        
    public func EEGContainsWKWebView() -> Bool {
        if self.isKind(of: WKWebView.self) {
            return true
        }
        for subView in self.subviews {
            if (subView.EEGContainsWKWebView()) {
                return true
            }
        }
        return false
    }
    
    public func EEGScreenShot(_ completionHandler: (_ screenShotImage: UIImage?) -> Void) {
        
        self.isShoting = true
        let bounds = self.bounds
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        context?.translateBy(x: -self.frame.origin.x, y: -self.frame.origin.y);
        
        if (EEGContainsWKWebView()) {
            self.drawHierarchy(in: bounds, afterScreenUpdates: true)
        }else{
            self.layer.render(in: context!)
        }
        let screenShotImage = UIGraphicsGetImageFromCurrentImageContext()
        context?.restoreGState();
        UIGraphicsEndImageContext()
        
        self.isShoting = false
        completionHandler(screenShotImage)
    }
}

