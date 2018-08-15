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
    }
    
    fileprivate  func configShowImageView() {
        let imageHeight = (FScreen_H - FNavgationBar_H - 10 - 120)
        borowView = EEImageBroweView(frame: CGRect(x:5, y: FNavgationBar_H + 5, width: FScreen_W - 10, height: imageHeight))
        borowView.viewAddLayerCorner(cornerRadius: 5, UIColor.ff_HexColor(0xFF8200))
        borowView.recordImage = originalImage
        borowView.loadImage()
        self.view.addSubview(borowView)
    }
    
    fileprivate func configBottomButtons() {
        var button_Y = FScreen_H - 120
        
        let lable = UILabel(frame: CGRect(x: 0, y: button_Y, width: FScreen_W, height: 30))
        lable.text = "渲染图片"
        lable.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        lable.textAlignment = .center
        lable.backgroundColor = UIColor.clear
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
