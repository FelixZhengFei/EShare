//
//  EEShareAlertView.swift
//  EShare
//
//  Created by 郑强飞 on 2018/8/15.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

import UIKit
import BYToolModule

class EEShareAlertView: UIView,FFLoadXibProtocol {

    @IBOutlet weak var weixinBaseView: UIView!
    
    @IBOutlet weak var pengyQuanBaseVIew: UIView!
    
    @IBOutlet weak var cancleButton: UIButton!
    public var saveImageBlock:(() -> Void)?
    public var shareFriendsBlock:(() -> Void)?
    public var sharePengyouQuanBlock:(() -> Void)?

    override func awakeFromNib() {
        cancleButton.viewAddLayerCorner(cornerRadius: 10, UIColor.clear)
        if !WXApi.isWXAppInstalled() {
            weixinBaseView.isHidden = true
            pengyQuanBaseVIew.isHidden = true
        }
    }
    
    @IBAction func cancleButtonClicked(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    @IBAction func savetPhotoClicked(_ sender: Any) {
        if saveImageBlock != nil {
            saveImageBlock!()
        }
    }
    
    @IBAction func shareWeixinButtonClicked(_ sender: Any) {
        if shareFriendsBlock != nil {
            shareFriendsBlock!()
        }
    }
    
    @IBAction func pengyouQuanButtonClicked(_ sender: Any) {
        if sharePengyouQuanBlock != nil {
            sharePengyouQuanBlock!()
        }
    }
    
}
