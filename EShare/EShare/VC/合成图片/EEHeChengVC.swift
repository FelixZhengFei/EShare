//
//  EEHeChengVC.swift
//  EShare
//
//  Created by 郑强飞 on 2018/8/16.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

import UIKit

class EEHeChengVC: EEBaseVC {
    
    fileprivate var baseScollview = UIScrollView()
    fileprivate var dataSource = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "合成长图"
        configRightButton()
        configUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    /**配置导航右键*/
    fileprivate func configRightButton() {
        let rightButton = UIButton(type: .custom)
        rightButton.frame = CGRect(x: FScreen_W - 44, y:FStatusBar_H, width: 44, height: 44)
        rightButton.setImage(#imageLiteral(resourceName: "nav_list"), for: .normal)
        rightButton.addTarget(self, action: #selector(configShareAlertView), for: .touchUpInside)
        self.navigationHeaderView.addSubview(rightButton)
    }

    //分享页面
    @objc fileprivate func configShareAlertView() {
        openPhotoMethod()
    }
    
    /**打开照相*/
    fileprivate func openCameraMethod() {
        weak var weakSelf = self
        FFCameralPlugin.shared.openCameral { (array) in

        }
    }
    
    /**打开照片库*/
    fileprivate func openPhotoMethod() {
        weak var weakSelf = self
        FFCameralPlugin.shared.openPhoto { (array) in
            weakSelf?.dataSource = array
            weakSelf?.configImagesWhenSelect()
        }
    }
    
}

extension EEHeChengVC  {
    
    fileprivate func configUI() {
        baseScollview.frame = CGRect(x: 0, y: FNavgationBar_H, width: FScreen_W, height: FScreen_H - FNavgationBar_H)
        baseScollview.backgroundColor = UIColor.red
        self.view.addSubview(baseScollview)
    }
    
    fileprivate func configImagesWhenSelect() {
        for view in baseScollview.subviews {
            view.removeFromSuperview()
        }
        var image_Y:CGFloat = 0
        var imageHeight:CGFloat = 0
        let imageWidth:CGFloat = FScreen_W
        for i in 0..<dataSource.count {
            let image = dataSource[i]
            FFPrint("image===\(image.size)")
            imageHeight = imageWidth / image.size.width * image.size.height
            
            let imageView = UIImageView(image:image)
            imageView.frame = CGRect(x: 0, y: image_Y, width: imageWidth, height: imageHeight)
            baseScollview.addSubview(imageView)
            
            let closeButton = UIButton(type: .custom)
            closeButton.frame = CGRect(x: imageWidth - 40, y: image_Y + 10, width: 30, height: 30)
            closeButton.setImage(#imageLiteral(resourceName: "delete_image"), for: .normal)
            closeButton.setImage(#imageLiteral(resourceName: "delete_image"), for: .highlighted)
            closeButton.addTarget(self, action: #selector(closeButtonClicked(_:)), for: .touchUpInside)
            closeButton.tag = i
            baseScollview.addSubview(closeButton)
            image_Y += imageHeight

        }
        
        baseScollview.contentSize = CGSize(width: FScreen_W, height: image_Y)
    }
    
    @objc fileprivate func closeButtonClicked(_ button:UIButton) {
        if button.tag < dataSource.count {
            dataSource.remove(at: button.tag)
            configImagesWhenSelect()
        }
        
    }
    
}
