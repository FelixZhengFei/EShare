//
//  EEMainVC.swift
//  EShare
//
//  Created by 郑强飞 on 2018/8/14.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

import UIKit
import FFToolModule

private let HIstroy_CELL_ID = "EEHomeHistroyCell"

class EEMainVC: EEBaseVC,UITextFieldDelegate {

    @IBOutlet weak var top_Y_Constarint: NSLayoutConstraint!
    @IBOutlet weak var serchButton: UIButton!
    @IBOutlet weak var textFiled: UITextField!
    fileprivate var dataSorceAry = [Any]()
    @IBOutlet weak var historyBaseView: UIView!
    @IBOutlet weak var hechengButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "U-Screen"
        top_Y_Constarint.constant = FNavgationBar_H
        setupForDismissKeyboard()
        self.hideBackButton()
        configUI()
        configHistyView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func configUI() {
        textFiled.viewAddLayerCorner(cornerRadius: 10, UIColor.ff_HexColor(0x999999))
        serchButton.viewAddLayerCorner(cornerRadius: 40, UIColor.clear)
        hechengButton.viewAddLayerCorner(cornerRadius: 40, UIColor.clear)
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

    /**合成图片*/
    @IBAction func heChengButtonCLicked(_ sender: Any) {
        let vc = EEHeChengVC()
        self.navigationController?.pushViewController(vc, animated: true)
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

extension EEMainVC {
    
    fileprivate func configHistyView() {
        configData()
        
        let btnWidth:CGFloat = FScreen_W / 6
        let btnHeight:CGFloat = 20
        var btn_Y:CGFloat = 40
        var btn_X:CGFloat = 0

        for i in 0..<dataSorceAry.count {
            let changeBtn = UIButton(type: .custom)
            changeBtn.tag = i
            changeBtn.frame = CGRect(x: btn_X, y: btn_Y, width: btnWidth  , height: btnHeight )
            changeBtn.addTarget(self, action: #selector(histrouButtonClicked(_:)), for: .touchUpInside)
            historyBaseView.addSubview(changeBtn)
            changeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            changeBtn.setTitleColor(UIColor.ff_HexColor(0x999999), for:.normal)
            let dic = dataSorceAry[i] as! [String:String]
            let nameString = dic["name"]!
            changeBtn.setTitle(nameString, for: .normal)
            btn_X = btnWidth * CGFloat((i % 6) + 1)
            if btn_X >= FScreen_W {
                btn_X = 0
                btn_Y += btnHeight + 5
            }
        }
    }
    
    /**常用网站*/
    fileprivate func configData() {
        dataSorceAry.append(["name":"百度", "url":"https://www.baidu.com/"])
        dataSorceAry.append(["name":"新浪", "url":"https://www.sina.com.cn/"])
        dataSorceAry.append(["name":"腾讯", "url":"http://www.qq.com/"])
        dataSorceAry.append(["name":"搜狐", "url":"http://www.sohu.com/"])
        dataSorceAry.append(["name":"网易", "url":"https://www.163.com/"])
        dataSorceAry.append(["name":"淘宝", "url":"https://www.taobao.com/"])
        dataSorceAry.append(["name":"京东", "url":"https://www.jd.com/"])
        dataSorceAry.append(["name":"国美", "url":"https://www.gome.com.cn/"])
        dataSorceAry.append(["name":"火车购票", "url":"http://www.12306.cn/"])
        dataSorceAry.append(["name":"雅虎", "url":"https://www.yahoo.com"])
        dataSorceAry.append(["name":"好123", "url":"https://www.hao123.com/"])
        dataSorceAry.append(["name":"58同城", "url":"http://hz.58.com/"])

    }
    
    /**常用网站*/
    @objc func histrouButtonClicked(_ button:UIButton) {
        let dic = dataSorceAry[button.tag] as! [String:String]
        let urlString = dic["url"]!
        let wKWebViewShot = EEWebView()
        wKWebViewShot.urlString = urlString
        self.navigationController?.pushViewController(wKWebViewShot, animated: true)
    }
}


