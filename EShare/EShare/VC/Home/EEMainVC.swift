//
//  EEMainVC.swift
//  EShare
//
//  Created by 郑强飞 on 2018/8/14.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

import UIKit
import FFToolModule

class EEMainVC: XLBaseVC {

    @IBOutlet weak var serchButton: UIButton!
    @IBOutlet weak var textFiled: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "EShare"
        setupForDismissKeyboard()
        configUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func configUI() {
        textFiled.viewAddLayerCorner(cornerRadius: 10, UIColor.ff_HexColor(0x999999))
        serchButton.viewAddLayerCorner(cornerRadius: 10, UIColor.clear)
    }
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        let wKWebViewShot = DDGWKWebViewShot()
//        wKWebViewShot.urlString = textFiled.text
        wKWebViewShot.urlString = "http://www.baidu.com"
        self.navigationController?.pushViewController(wKWebViewShot, animated: true)
    }
    
}


