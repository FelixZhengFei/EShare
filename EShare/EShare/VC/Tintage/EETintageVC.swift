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
        title = "分享"
        configShowImageView()
        configBottomButtons()
        
    }
    
    fileprivate  func configShowImageView() {
        
        let imageHeight = (FScreen_H - FNavgationBar_H - 10 - 120)
        
        borowView = EEImageBroweView(frame: CGRect(x:0, y: FNavgationBar_H, width: FScreen_W, height: imageHeight))
        
        borowView.recordImage = originalImage
        borowView.loadImage()
        self.view.addSubview(borowView)
    }
    
    fileprivate func configBottomButtons() {
        let button_Y = borowView.frame.size.height + borowView.frame.origin.y + 10
        
        let btnWidth = (self.view.frame.size.width - 40 ) / 4
        let titleArr = ["怀旧","黑白","色调","岁月","单色","褪色","冲印","原图"]
        for i  in 0 ..< titleArr.count {
            let changeBtn = UIButton()
            changeBtn.tag = 100 + i
            changeBtn.frame = CGRect(x: 20 + btnWidth * CGFloat(i % 4), y: button_Y + 40 * CGFloat(i / 4), width: btnWidth  , height: 40 )
            changeBtn.setTitle(titleArr[i], for: .normal)
            if i == 8 {
                changeBtn.backgroundColor = UIColor.yellow
            }
            changeBtn.setTitleColor(UIColor.black, for: .normal)
            changeBtn.addTarget(self, action: #selector(addImageFilter(changeBtn:)), for: .touchUpInside)
            self.view.addSubview(changeBtn)
        }
    }
    
    @objc func addImageFilter(changeBtn: UIButton) {
        resetBtn()
        switch changeBtn.tag - 100 {
        case 0:
            let newImage = DDGManage.share.imageFilterHandel(image: originalImage, filterName: "CIPhotoEffectInstant")
            self.borowView.imageView.image = newImage
            changeBtn.backgroundColor = UIColor.yellow
        case 1:
            //let newImage = DDGManage.share.imageFilterHandel(image: originalImage, filterName: "CIPhotoEffectNoir")
            weak var ws = self
            DDGManage.share.async_imageFilterHandel(image: originalImage, filterName: "CIPhotoEffectNoir") { (newImage) in
                ws!.borowView.imageView.image = newImage
            }
            changeBtn.backgroundColor = UIColor.yellow
        case 2:
            let newImage = DDGManage.share.imageFilterHandel(image: originalImage, filterName: "CIPhotoEffectTonal")
            self.borowView.imageView.image = newImage
            changeBtn.backgroundColor = UIColor.yellow
        case 3:
            let newImage = DDGManage.share.imageFilterHandel(image: originalImage, filterName: "CIPhotoEffectTransfer")
            self.borowView.imageView.image = newImage
            changeBtn.backgroundColor = UIColor.yellow
        case 4:
            let newImage = DDGManage.share.imageFilterHandel(image: originalImage, filterName: "CIPhotoEffectMono")
            self.borowView.imageView.image = newImage
            changeBtn.backgroundColor = UIColor.yellow
        case 5:
            let newImage = DDGManage.share.imageFilterHandel(image: originalImage, filterName: "CIPhotoEffectFade")
            self.borowView.imageView.image = newImage
            changeBtn.backgroundColor = UIColor.yellow
        case 6:
            let newImage = DDGManage.share.imageFilterHandel(image: originalImage, filterName: "CIPhotoEffectProcess")
            self.borowView.imageView.image = newImage
            changeBtn.backgroundColor = UIColor.yellow
        case 7:
            self.borowView.imageView.image = originalImage
            changeBtn.backgroundColor = UIColor.yellow
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
