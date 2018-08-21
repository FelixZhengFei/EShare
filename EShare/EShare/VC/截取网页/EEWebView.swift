//
//  EEWebView.swift
//  EEGScreenshot
//
//  Created by 郑强飞 on 2018/8/19.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

import UIKit
import WebKit

class EEWebView: EEBaseVC ,WKUIDelegate,WKNavigationDelegate {
    fileprivate var wkWebView: WKWebView?
    fileprivate var storeImageView = EESoreImageView()
    
    public var urlString:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "截取长图"
        configWebView()
        configBottomViews()
        openStringURL()
        self.view.backgroundColor = UIColor.white
    }
    
    //打开链接
    fileprivate func openStringURL() {
        guard let path = URL(string:urlString ?? "") else {
            EEWrongAlert.show("打开的网址错误")
            return
        }
        wkWebView?.load(URLRequest(url: path))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - 私有方法
extension EEWebView {
    
    /**webview*/
    fileprivate func configWebView() {
        let configuration = WKWebViewConfiguration()
        configuration.preferences = WKPreferences()
        configuration.preferences.minimumFontSize = 10
        wkWebView = WKWebView(frame:CGRect(x: 0, y: FNavgationBar_H, width: FScreen_W , height: FScreen_H - FNavgationBar_H), configuration: configuration)
        self.view.addSubview(wkWebView!)
        wkWebView?.uiDelegate = self
        wkWebView?.navigationDelegate = self
        wkWebView?.backgroundColor = UIColor.white
        wkWebView?.allowsBackForwardNavigationGestures = true
    }
    
    /**底部按键*/
    fileprivate func configBottomViews() {
        let bottowView = UIView(frame: CGRect(x: 0, y: FScreen_H - 50, width: FScreen_W, height: 50))
        self.view.addSubview(bottowView)
        let cutButton = UIButton(type: .custom)
        cutButton.setTitle("截图", for: .normal)
        cutButton.setTitleColor(UIColor.white, for: .normal)
        cutButton.setBackgroundImage(#imageLiteral(resourceName: "btn_nor"), for: .normal)
        cutButton.setBackgroundImage(#imageLiteral(resourceName: "btn_pre"), for: .highlighted)
        cutButton.addTarget(self, action: #selector(EEWebView.screenShotWebView), for: .touchUpInside)
        cutButton.frame = CGRect(x: 0, y:0, width: FScreen_W, height: 50)
        cutButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        bottowView.addSubview(cutButton)
    }
    
    @objc func screenShotWebView() {
        weak var weakSelf = self
        EEWrongAlert.showActivityIndicator(text: "", detailText: "图片生成中...", toView: UIApplication.shared.keyWindow!, animated: true)
        wkWebView?.EEGContentScreenShot { (image) in
            EEWrongAlert.hide()
            if image != nil {
                weakSelf?.showStoreView(image!)
            }
        }
    }
    
    fileprivate func showStoreView(_ image:UIImage) {
        weak var weakSelf = self
        
        storeImageView.frame = CGRect(x: 0, y: 0, width: FScreen_W, height: FScreen_H)
        self.view.addSubview(storeImageView)
        storeImageView.updateViewWithImage(image)
        storeImageView.saveImageBlock = { (image) in
            let vc = EETintageVC()
            vc.originalImage = image
            weakSelf?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


// MARK: - WKWebViewDelegate
extension EEWebView {
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
