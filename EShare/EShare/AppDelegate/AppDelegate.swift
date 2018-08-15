//
//  AppDelegate.swift
//  EShare
//
//  Created by 郑强飞 on 2018/8/14.
//  Copyright © 2018年 郑强飞. All rights reserved.
// com.changtu.ufilter //FIxME

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,WXApiDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        initWindow()
        configWeiChat()
        return true
    }

    func initWindow() {
        window = UIWindow()
        window?.frame = UIScreen.main.bounds
        window?.backgroundColor = UIColor.white
        window?.rootViewController = EENavgationVC(rootViewController: EEMainVC())
        window?.makeKeyAndVisible()
    }
    
    fileprivate func configWeiChat() {
        WXApi.registerApp(WeChat_KEY)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return WXApi.handleOpen(url, delegate: self)
    }

    func onResp(_ resp: BaseResp!) {
        if resp.isKind(of: SendMessageToWXResp.self) {//确保是对我们分享操作的回调
            if resp.errCode == WXSuccess.rawValue{//分享成功
                print("分享成功")
            }else if resp.errCode == WXErrCodeCommon.rawValue {//普通错误类型
                print("分享失败：普通错误类型")
            }else if resp.errCode == WXErrCodeUserCancel.rawValue {//用户点击取消并返回
                print("分享失败：用户点击取消并返回")
            }else if resp.errCode == WXErrCodeSentFail.rawValue {//发送失败
                print("分享失败：发送失败")
            }else if resp.errCode == WXErrCodeAuthDeny.rawValue {//授权失败
                print("分享失败：授权失败")
            }else if resp.errCode == WXErrCodeUnsupport.rawValue {//微信不支持
                print("分享失败：微信不支持")
            }
        }
    }

}

