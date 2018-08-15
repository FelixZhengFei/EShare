//
//  EETintageVC.swift
//  EShare
//
//  Created by 郑强飞 on 2018/8/14.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

import UIKit

class EETintageVC: EEBaseVC {
    public var originalImage:UIImage!
    fileprivate var borowView: EEImageBroweView!
    fileprivate lazy var shareView = EEShareAlertView.ff_LoadXib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "魔彩"
        self.view.backgroundColor = UIColor.white
        configShowImageView()
        configBottomButtons()
        configRightButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - 私有方法
extension EETintageVC {
    
    /**配置UI*/
    fileprivate  func configShowImageView() {
        originalImage = originalImage.waterMarkedImage(waterMarkImage: #imageLiteral(resourceName: "shuiyin"), corner: .BottomRight, margin: CGPoint(x: 25, y: 25), alpha: 1)
        originalImage = originalImage.waterMarkedImage(waterMarkText: "来自 U-Share", corner: .BottomRight, margin: CGPoint(x: 10, y: 10), waterMarkTextColor: UIColor.ff_HexColor(0xFF8240), waterMarkTextFont: UIFont.systemFont(ofSize: 12, weight: .regular), backgroundColor: UIColor.clear)
        
        
        let imageHeight = (FScreen_H - FNavgationBar_H - 10 - 120)
        borowView = EEImageBroweView(frame: CGRect(x:5, y: FNavgationBar_H + 5, width: FScreen_W - 10, height: imageHeight))
        borowView.viewAddLayerCorner(cornerRadius: 5, UIColor.ff_HexColor(0xFd6547))
        borowView.originImage = originalImage
        borowView.configImage()
        self.view.addSubview(borowView)
    }
    
    /**配置导航右键*/
    fileprivate func configRightButton() {
        let rightButton = UIButton(type: .custom)
        rightButton.frame = CGRect(x: FScreen_W - 44, y:FStatusBar_H, width: 44, height: 44)
        rightButton.setBackgroundImage(#imageLiteral(resourceName: "nav_nemu"), for: .normal)
        rightButton.setBackgroundImage(#imageLiteral(resourceName: "nav_nemu"), for:.highlighted)
        rightButton.addTarget(self, action: #selector(configShareAlertView), for: .touchUpInside)
        self.navigationHeaderView.addSubview(rightButton)
    }
    
    
    /**底部按键*/
    fileprivate func configBottomButtons() {
        var button_Y = FScreen_H - 120
        
        let lable = UILabel(frame: CGRect(x: 0, y: button_Y, width: FScreen_W, height: 30))
        lable.text = "渲染图片"
        lable.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        lable.textAlignment = .center
        lable.backgroundColor = UIColor.ff_HexColor(0xF4F5F6)
        lable.textColor = UIColor.ff_HexColor(0xFF8200)
        self.view.addSubview(lable)
        button_Y += 40
        
        let bottonScollView = UIScrollView(frame: CGRect(x: 0, y: button_Y, width: FScreen_W, height: 60))
        self.view.addSubview(bottonScollView)
        let btnWidth:CGFloat = 60.0
        var btn_X:CGFloat = 15
        for i  in 0 ..< 8 {
            let changeBtn = UIButton()
            changeBtn.tag = 100 + i
            changeBtn.frame = CGRect(x: btn_X, y: 0, width: btnWidth  , height: btnWidth )
            changeBtn.setImage(UIImage(named: "icon_\(i)"), for: .normal)
            changeBtn.addTarget(self, action: #selector(filertImageMethods(changeBtn:)), for: .touchUpInside)
            bottonScollView.addSubview(changeBtn)
            btn_X = 15 + (btnWidth + 5) * CGFloat(i+1)
        }
        bottonScollView.backgroundColor = UIColor.ff_HexColor(0xF4F5F6)
        bottonScollView.contentSize = CGSize(width: btn_X + 10, height: 60)
    }
    
    //分享页面
    @objc fileprivate func configShareAlertView() {
        shareView.frame = CGRect(x: 0, y: 0, width: FScreen_W, height: FScreen_H)
        self.view.addSubview(shareView)
        weak var weakSelf = self
        shareView.saveImageBlock = {
            weakSelf?.saveImageButtonClicked()
        }
        shareView.shareFriendsBlock = {
            weakSelf?.showToWeiXinFrinds(WXSceneSession)
        }
        shareView.sharePengyouQuanBlock = {
            weakSelf?.showToWeiXinFrinds(WXSceneTimeline)
        }
    }
    
    /**保存到相册*/
    fileprivate func saveImageButtonClicked() {
        UIImageWriteToSavedPhotosAlbum(borowView.imageView.image!, self, #selector(image(image:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        if error != nil {
            FFPrint("错误")
            return
        }
        FFPrint("OK")
        EEWrongAlert.show("保存图片成功")
    }
    
    /*分享到微信*/
    fileprivate func showToWeiXinFrinds(_ scene:WXScene) {
        let message = WXMediaMessage()
        message.setThumbImage(#imageLiteral(resourceName: "btn_nor"))
        let imageObject = WXImageObject()
        imageObject.imageData = UIImagePNGRepresentation(self.borowView.imageView.image!)
        message.mediaObject = imageObject
        
        let req = SendMessageToWXReq()
        req.text = ""
        req.bText = false
        req.message = message
        req.scene = Int32(scene.rawValue)
        WXApi.send(req)
    }
}

// MARK: - 图片处理
extension EETintageVC {
    
    /**渲染*/
    @objc func filertImageMethods(changeBtn: UIButton) {
        EEWrongAlert.show(text: "", detailText: "处理中...", toView: UIApplication.shared.keyWindow!, animated: true, hideAfterDelay: 1)
        switch changeBtn.tag - 100 {
        case 0:
            let newImage = EEGManage.share.imageFilterHandel(image: originalImage, filterName: "CIPhotoEffectInstant")
            self.borowView.imageView.image = newImage
        case 1:
            weak var ws = self
            EEGManage.share.async_imageFilterHandel(image: originalImage, filterName: "CIPhotoEffectNoir") { (newImage) in
                ws!.borowView.imageView.image = newImage
            }
        case 2:
            let newImage = EEGManage.share.imageFilterHandel(image: originalImage, filterName: "CIPhotoEffectTonal")
            self.borowView.imageView.image = newImage
        case 3:
            let newImage = EEGManage.share.imageFilterHandel(image: originalImage, filterName: "CIPhotoEffectTransfer")
            self.borowView.imageView.image = newImage
        case 4:
            let newImage = EEGManage.share.imageFilterHandel(image: originalImage, filterName: "CIPhotoEffectMono")
            self.borowView.imageView.image = newImage
        case 5:
            let newImage = EEGManage.share.imageFilterHandel(image: originalImage, filterName: "CIPhotoEffectFade")
            self.borowView.imageView.image = newImage
        case 6:
            let newImage = EEGManage.share.imageFilterHandel(image: originalImage, filterName: "CIPhotoEffectProcess")
            self.borowView.imageView.image = newImage
        case 7:
            self.borowView.imageView.image = originalImage
        default:
            break
        }
    }
}
