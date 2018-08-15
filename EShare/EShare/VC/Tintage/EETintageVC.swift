//
//  EETintageVC.swift
//  EShare
//
//  Created by 郑强飞 on 2018/8/14.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

import UIKit

class EETintageVC: XLBaseVC {
    public var originalImage:UIImage!
    fileprivate var borowView: EEImageBroweView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "魔彩"
        self.view.backgroundColor = UIColor.ff_HexColor(0xF4F5F6)
        configShowImageView()
        configBottomButtons()
        configRightButton()
    }
    
    fileprivate  func configShowImageView() {
        
        originalImage = originalImage.waterMarkedImage(waterMarkImage: #imageLiteral(resourceName: "shuiyin"), corner: .BottomRight, margin: CGPoint(x: 25, y: 25), alpha: 1)
        originalImage = originalImage.waterMarkedImage(waterMarkText: "来自 U-Share", corner: .BottomRight, margin: CGPoint(x: 10, y: 10), waterMarkTextColor: UIColor.ff_HexColor(0xFF8240), waterMarkTextFont: UIFont.systemFont(ofSize: 12, weight: .regular), backgroundColor: UIColor.clear)

        
        let imageHeight = (FScreen_H - FNavgationBar_H - 10 - 120)
        borowView = EEImageBroweView(frame: CGRect(x:5, y: FNavgationBar_H + 5, width: FScreen_W - 10, height: imageHeight))
        borowView.viewAddLayerCorner(cornerRadius: 5, UIColor.ff_HexColor(0xFd6547))
        borowView.recordImage = originalImage
        borowView.loadImage()
        self.view.addSubview(borowView)
    }
    
    fileprivate func configRightButton() {
        let rightButton = UIButton(type: .custom)
        rightButton.frame = CGRect(x: FScreen_W - 44, y:FStatusBar_H, width: 44, height: 44)
        rightButton.setBackgroundImage(#imageLiteral(resourceName: "nav_nemu"), for: .normal)
        rightButton.setBackgroundImage(#imageLiteral(resourceName: "nav_nemu"), for:.highlighted)
        rightButton.addTarget(self, action: #selector(showToWeiXin), for: .touchUpInside)
        self.navigationHeaderView.addSubview(rightButton)
    }
    
    @objc fileprivate func showToWeiXin() {
        let message = WXMediaMessage()
        message.setThumbImage(#imageLiteral(resourceName: "btn_nor"))
        let imageObject = WXImageObject()
        imageObject.imageData = UIImagePNGRepresentation(self.borowView.imageView.image!)
        message.mediaObject = imageObject
        
        let req = SendMessageToWXReq()
        req.text = "分享图片测试"
        req.bText = false
        req.message = message
        req.scene = Int32(WXSceneSession.rawValue)
        WXApi.send(req)
    }
    
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
            changeBtn.addTarget(self, action: #selector(addImageFilter(changeBtn:)), for: .touchUpInside)
            bottonScollView.addSubview(changeBtn)
            btn_X = 15 + (btnWidth + 5) * CGFloat(i+1)
        }
        bottonScollView.backgroundColor = UIColor.ff_HexColor(0xF4F5F6)
        bottonScollView.contentSize = CGSize(width: btn_X + 10, height: 60)
    }
    
    @objc func addImageFilter(changeBtn: UIButton) {
        resetBtn()
        SMWrongAlert.show(text: "", detailText: "处理中...", toView: UIApplication.shared.keyWindow!, animated: true, hideAfterDelay: 1)
        switch changeBtn.tag - 100 {
        case 0:
            let newImage = DDGManage.share.imageFilterHandel(image: originalImage, filterName: "CIPhotoEffectInstant")
            self.borowView.imageView.image = newImage
        case 1:
            weak var ws = self
            DDGManage.share.async_imageFilterHandel(image: originalImage, filterName: "CIPhotoEffectNoir") { (newImage) in
                ws!.borowView.imageView.image = newImage
            }
        case 2:
            let newImage = DDGManage.share.imageFilterHandel(image: originalImage, filterName: "CIPhotoEffectTonal")
            self.borowView.imageView.image = newImage
        case 3:
            let newImage = DDGManage.share.imageFilterHandel(image: originalImage, filterName: "CIPhotoEffectTransfer")
            self.borowView.imageView.image = newImage
        case 4:
            let newImage = DDGManage.share.imageFilterHandel(image: originalImage, filterName: "CIPhotoEffectMono")
            self.borowView.imageView.image = newImage
        case 5:
            let newImage = DDGManage.share.imageFilterHandel(image: originalImage, filterName: "CIPhotoEffectFade")
            self.borowView.imageView.image = newImage
        case 6:
            let newImage = DDGManage.share.imageFilterHandel(image: originalImage, filterName: "CIPhotoEffectProcess")
            self.borowView.imageView.image = newImage
        case 7:
            self.borowView.imageView.image = originalImage
        default:
            break
        }
    }
    
    func resetBtn() {
        for views in self.view.subviews {
            if views.tag - 100 <= 10 {
                views.backgroundColor = UIColor.white
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
