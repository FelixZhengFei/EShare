//
//  wrongView.swift
//  EShare
//
//  Created by 王宇浩 on 2018/8/15.
//  Copyright © 2018年 王宇浩. All rights reserved.
//

import UIKit
import MBProgressHUD
//import SwiftGifOrigin

enum HUDType {
    case none
    case text
    case indicator
    case progressBar
    case customView
}
private var hud: MBProgressHUD?  //全局变量
private var type:HUDType = HUDType.none

///错误提示框
class EEWrongAlert: NSObject {
    
    class func show(_ text:String) {
        if text == "" {
            return
        }
        let wrongView = EEWrongAlert.initialization()
        type=HUDType.text
        let themeColor = UIColor.white  //主题颜色
        let keyWindow = UIApplication.shared.keyWindow
        keyWindow?.addSubview(wrongView)
        wrongView.center = (keyWindow?.center)!
        wrongView.mode = MBProgressHUDMode.text //纯文本模式
        wrongView.contentColor=themeColor  //设置所有控件的颜色
        wrongView.margin=10   //各元素与HUD边缘的间距
        wrongView.bezelView.layer.cornerRadius=5   //设置背景框的圆角值，默认是10
        wrongView.bezelView.style=MBProgressHUDBackgroundStyle.blur  //设置背景色模式
        wrongView.bezelView.backgroundColor=UIColor.black   //背景颜色
        wrongView.animationType=MBProgressHUDAnimation.zoomIn
        wrongView.isUserInteractionEnabled=false   //Hud的可操作性，用于表示父视图是否可以响应用户操作
        wrongView.label.text=text
        wrongView.label.numberOfLines = 0;
        wrongView.detailsLabel.text=nil
        wrongView.show(animated: true)
        EEWrongAlert.hide(animated: true, afterDelay: 1.5)
    }
    
    //MARK: 显示HUD
    /**显示文字*/
    class func show(text:String,detailText:String,toView:UIView,animated:Bool,hideAfterDelay:TimeInterval) {
        let wrongView = EEWrongAlert.initialization()
        if type != HUDType.text {
            type=HUDType.text
            let themeColor = UIColor.white  //主题颜色
            toView.addSubview(wrongView)
            wrongView.center=toView.center
            wrongView.mode = MBProgressHUDMode.text //纯文本模式
            wrongView.contentColor=themeColor  //设置所有控件的颜色
            wrongView.margin=10   //各元素与HUD边缘的间距
            wrongView.bezelView.layer.cornerRadius=5   //设置背景框的圆角值，默认是10
            wrongView.bezelView.style=MBProgressHUDBackgroundStyle.blur  //设置背景色模式
            wrongView.bezelView.backgroundColor=UIColor.black   //背景颜色
            wrongView.animationType=MBProgressHUDAnimation.zoomIn
            wrongView.isUserInteractionEnabled=false   //Hud的可操作性，用于表示父视图是否可以响应用户操作
            wrongView.label.text=text
            wrongView.label.numberOfLines = 0;
            wrongView.detailsLabel.text=detailText
            wrongView.show(animated: animated)
            if hideAfterDelay>0
            {
                EEWrongAlert.hide(animated: animated, afterDelay: hideAfterDelay)
            }
        } else {
            wrongView.label.text=text
            wrongView.detailsLabel.text=detailText
        }
    }
    
    /**显示小菊花*/
    class func showRunning() {
        let wrongView = EEWrongAlert.initialization()
            type=HUDType.indicator
            let themeColor = UIColor.white  //主题颜色
            let toView = UIApplication.shared.keyWindow!
            toView.addSubview(wrongView)
            wrongView.center=toView.center
            wrongView.mode = MBProgressHUDMode.indeterminate //小菊花模式
            wrongView.margin=15 //各元素与HUD边缘的间距
            wrongView.contentColor=themeColor  //设置所有控件的颜色
            wrongView.bezelView.layer.cornerRadius=5  //设置背景框的圆角值，默认是10
            wrongView.bezelView.style=MBProgressHUDBackgroundStyle.blur  //设置背景色模式
            wrongView.bezelView.backgroundColor=UIColor.black   //背景颜色
            wrongView.animationType=MBProgressHUDAnimation.zoomIn
            wrongView.isUserInteractionEnabled=true   //Hud的可操作性，用于表示父视图是否可以响应用户操作
            wrongView.label.text = ""
            wrongView.detailsLabel.text = ""
            wrongView.show(animated: true)
    }
    
    /**显示小菊花*/
    class func showActivityIndicator(text:String,detailText:String,toView:UIView,animated:Bool) {
        let wrongView = EEWrongAlert.initialization()
        if type != HUDType.indicator {
            type=HUDType.indicator
            let themeColor = UIColor.white  //主题颜色
            toView.addSubview(wrongView)
            wrongView.center=toView.center
            wrongView.mode = MBProgressHUDMode.indeterminate //小菊花模式
            //wrongView.isSquare=true //强制背景框宽高相等
            wrongView.margin=15 //各元素与HUD边缘的间距
            wrongView.contentColor=themeColor  //设置所有控件的颜色
            //wrongView.activityIndicatorColor=themeColor
            wrongView.bezelView.layer.cornerRadius=5  //设置背景框的圆角值，默认是10
            wrongView.bezelView.style=MBProgressHUDBackgroundStyle.blur  //设置背景色模式
            wrongView.bezelView.backgroundColor=UIColor.black   //背景颜色
            wrongView.animationType=MBProgressHUDAnimation.zoomIn
            wrongView.isUserInteractionEnabled=true   //Hud的可操作性，用于表示父视图是否可以响应用户操作
            wrongView.label.text=text
            wrongView.detailsLabel.text=detailText
            wrongView.show(animated: animated)
        } else {
            wrongView.label.text=text
            wrongView.detailsLabel.text=detailText
        }
    }
    
    /**显示水平进度条*/
    class func showProgressBar(text:String,detailText:String,progress:Float,toView:UIView,animated:Bool) {
        let wrongView = EEWrongAlert.initialization()
        if type != HUDType.progressBar {
            type=HUDType.progressBar
            let themeColor = UIColor.white  //主题颜色
            toView.addSubview(wrongView)
            wrongView.center=toView.center
            wrongView.isSquare=false //是否强制背景框宽高相等
            wrongView.mode = MBProgressHUDMode.determinateHorizontalBar //水平进度条模式
            wrongView.contentColor=themeColor  //设置所有控件的颜色
            wrongView.margin=15 //各元素与HUD边缘的间距
            wrongView.bezelView.layer.cornerRadius=5  //设置背景框的圆角值，默认是10
            wrongView.bezelView.style=MBProgressHUDBackgroundStyle.blur  //设置背景色模式
            wrongView.bezelView.backgroundColor=UIColor.black  //背景颜色
            wrongView.animationType=MBProgressHUDAnimation.zoomIn
            wrongView.isUserInteractionEnabled=false   //Hud的可操作性，用于表示父视图是否可以响应用户操作
            wrongView.label.text=text
            wrongView.detailsLabel.text=detailText
            wrongView.progress=progress
            wrongView.show(animated: animated)
        } else {
            wrongView.label.text=text
            wrongView.progress=progress
            if progress>=1 {
                EEWrongAlert.hide()
            }
        }
    }
    
    /**显示成功提示*/
    class func showSuccess(text:String,detailText:String,toView:UIView,animated:Bool,afterDelay:TimeInterval) {
        EEWrongAlert.showCustomView(text: text, detailText: detailText, image:#imageLiteral(resourceName: "action_success"), toView: toView, animated: animated, afterDelay: afterDelay)
    }
    
    /**显示错误提示*/
    class func showFailure(text:String,detailText:String,toView:UIView,animated:Bool,afterDelay:TimeInterval) {
        EEWrongAlert.showCustomView(text: text, detailText: detailText, image:#imageLiteral(resourceName: "action_fail"), toView: toView, animated: animated, afterDelay: afterDelay)
    }
    
    
    /**显示自定义视图*/
    fileprivate class func showCustomView(text:String,detailText:String,image:UIImage,toView:UIView,animated:Bool,afterDelay:TimeInterval) {
        let wrongView = EEWrongAlert.initialization()
        if type != HUDType.customView {
            type=HUDType.customView
            let themeColor = UIColor.white  //主题颜色
            toView.addSubview(wrongView)
            wrongView.center=toView.center
            wrongView.mode = MBProgressHUDMode.customView //自定义视图模式
            wrongView.isSquare=false //强制背景框宽高相等
            wrongView.margin=15 //各元素与HUD边缘的间距
            wrongView.contentColor=themeColor  //设置所有控件的颜色
            wrongView.bezelView.layer.cornerRadius=5  //设置背景框的圆角值，默认是10
            wrongView.bezelView.style=MBProgressHUDBackgroundStyle.blur  //设置背景色模式
            wrongView.bezelView.backgroundColor=UIColor.black   //背景颜色
            wrongView.animationType=MBProgressHUDAnimation.zoomIn
            wrongView.isUserInteractionEnabled=false   //Hud的可操作性，用于表示父视图是否可以响应用户操作
            wrongView.label.text=text
            wrongView.detailsLabel.text=detailText
            wrongView.customView=UIImageView.init(image: image)
            wrongView.show(animated: animated)
            if afterDelay>0 {
                EEWrongAlert.hide(animated: animated, afterDelay: afterDelay)
            }
        }
    }
    
    //MARK: 隐藏HUD
    class func hide() {
        EEWrongAlert.hide(animated: false, afterDelay: 0)
    }
    
    class func hide(animated: Bool,afterDelay:TimeInterval) {
        hud?.hide(animated: false, afterDelay: afterDelay)
        type=HUDType.none
    }
    
    //MARK: 初始化
    fileprivate class func initialization() -> MBProgressHUD {
        if hud==nil {
            hud=MBProgressHUD.init()
            hud?.removeFromSuperViewOnHide=true
            type=HUDType.none
        }
        return hud!
    }
}

