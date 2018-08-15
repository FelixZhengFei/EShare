//
//  EEMainVC.swift
//  EShare
//
//  Created by 郑强飞 on 2018/8/14.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

import UIKit
import FFToolModule

class EEMainVC: EEBaseVC,UITextFieldDelegate {

    @IBOutlet weak var serchButton: UIButton!
    @IBOutlet weak var textFiled: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "U-Screen"
        setupForDismissKeyboard()
        self.hideBackButton()
        configUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func configUI() {
        textFiled.viewAddLayerCorner(cornerRadius: 10, UIColor.ff_HexColor(0x999999))
        serchButton.viewAddLayerCorner(cornerRadius: 10, UIColor.clear)
    }
    
    @IBAction func searchButtonClicked() {
    
        var urlString = textFiled.text!
        if urlString.count <= 0 {
            EEWrongAlert.show("请输入您要截图的网页地址")
            return
        }
        if urlString.hasPrefix("http://") ||  urlString.hasPrefix("https://") {
            
        } else {
            urlString = "http://" + urlString
        }
        
        if !isVarulURl(urlString){
            EEWrongAlert.show("请输入正确网页地址")
            return
        }
        let wKWebViewShot = EEWebView()
        wKWebViewShot.urlString = urlString
        self.navigationController?.pushViewController(wKWebViewShot, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchButtonClicked()
        return true
    }

    //判断网页是否正确
    fileprivate func isVarulURl(_ sring:String)->Bool {
        let regex = "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: sring)
        return isValid
    }
    
    @IBAction func aboutUserButtonClcked(_ sender: Any) {
        let vc = EEAboutUsVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


