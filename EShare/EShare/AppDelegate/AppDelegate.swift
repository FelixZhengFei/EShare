//
//  AppDelegate.swift
//  EShare
//
//  Created by 郑强飞 on 2018/8/14.
//  Copyright © 2018年 郑强飞. All rights reserved.
// com.changtu.ufilter //FIxME

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,WXApiDelegate,WeiboSDKDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        initWindow()
        configWeiChat()
        configSina()
        return true
    }

    func initWindow() {
        window = UIWindow()
        window?.frame = UIScreen.main.bounds
        window?.backgroundColor = UIColor.white
        window?.rootViewController = EENavgationVC(rootViewController: EEMainVC())
        window?.makeKeyAndVisible()
    }
    
    /**新浪*/
    fileprivate func configSina() {
        WeiboSDK.registerApp(Sina_KEY)
    }
    
    /**微信*/
    fileprivate func configWeiChat() {
        WXApi.registerApp(WeChat_KEY)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let urlKey: String? = options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String
        
        if urlKey != nil && urlKey == "com.sina.weibo" {
            return WeiboSDK.handleOpen(url, delegate: self)
        }
        return WXApi.handleOpen(url, delegate: self)
    }

//    // 新浪微博的H5网页登录回调需要实现这个方法
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if url.scheme == "URL Schemes" {
            return true
        }
        return true
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

    
    func didReceiveWeiboRequest(_ request: WBBaseRequest!) {
        
    }
    
    func didReceiveWeiboResponse(_ response: WBBaseResponse!) {
        
        if response is WBSendMessageToWeiboResponse {
            let rm = response as! WBSendMessageToWeiboResponse
            
            if rm.statusCode == WeiboSDKResponseStatusCode.success {
                // 成功
                print("分享成功")
                let userInfo = rm.requestUserInfo // request 中设置的自定义信息
                
                print("分享成功\n\(userInfo ?? ["假的": ""])")
            } else {
                // 失败
                print("分享失败")
            }
        }
    }

}

