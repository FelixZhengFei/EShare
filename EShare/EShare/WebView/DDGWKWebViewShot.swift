//
//  DDGWKWebViewShot.swift
//  DDGScreenshot
//
//  Created by dudongge on 2018/3/19.
//  Copyright © 2018年 dudongge. All rights reserved.
//

import UIKit
import WebKit

class DDGWKWebViewShot: XLBaseVC ,WKUIDelegate,WKNavigationDelegate {
    fileprivate var wkWebView: WKWebView?
    fileprivate var storeImageView = EESoreImageView()
    
    public var urlString:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "截取长图"
        configWebView()
        configBottomViews()
        openStringURL()
    }
    
    //打开链接
    fileprivate func openStringURL() {
        guard let path = URL(string:urlString ?? "") else {
            //            SMWrongAlert.show("打开的网址错误")
            return
        }
        wkWebView?.load(URLRequest(url: path))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - 私有方法
extension DDGWKWebViewShot {
    
    /**webview*/
    fileprivate func configWebView() {
        let configuration = WKWebViewConfiguration()
        configuration.preferences = WKPreferences()
        configuration.preferences.minimumFontSize = 10
        configuration.preferences.javaScriptEnabled = true
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = false
        wkWebView = WKWebView(frame:CGRect(x: 0, y: FNavgationBar_H, width: FScreen_W , height: FScreen_H - FNavgationBar_H), configuration: configuration)
        self.view.addSubview(wkWebView!)
        wkWebView?.uiDelegate = self
        wkWebView?.navigationDelegate = self
        wkWebView?.backgroundColor = UIColor.clear
        wkWebView?.allowsBackForwardNavigationGestures = true
    }
    
    /**底部按键*/
    fileprivate func configBottomViews() {
        let bottowView = UIView(frame: CGRect(x: 0, y: FScreen_H - 50, width: FScreen_W, height: 50))
        self.view.addSubview(bottowView)
        let leftBtn = UIButton()
        leftBtn.backgroundColor = UIColor.yellow
        leftBtn.setTitle("截wkwebImage", for: .normal)
        leftBtn.setTitleColor(UIColor.blue, for: .normal)
        leftBtn.addTarget(self, action: #selector(DDGWKWebViewShot.screenShotWebView), for: .touchUpInside)
        leftBtn.frame = CGRect(x: 0, y:0, width: FScreen_W, height: 50)
        bottowView.addSubview(leftBtn)
    }
    
    @objc func screenShotWebView() {
        weak var weakSelf = self
        wkWebView?.DDGContentScreenShot { (image) in
            if image != nil {
                weakSelf?.showStoreView(image!)
            }
        }
    }
    
    fileprivate func showStoreView(_ image:UIImage) {
        storeImageView.frame = CGRect(x: 0, y: 0, width: FScreen_W, height: FScreen_H)
        self.view.addSubview(storeImageView)
        storeImageView.updateViewWithImage(image)
    }
}


// MARK: - WKWebViewDelegate
extension DDGWKWebViewShot {
    //在发送请求之前，决定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    }
    
    //在响应完成时，调用的方法。如果设置为不允许响应，web内容就不会传过来
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
}
