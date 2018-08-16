//
//  EESoreImageView.swift
//  EShare
//
//  Created by 郑强飞 on 2018/8/14.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

import UIKit
import BYToolModule

class EESoreImageView: UIView{
    fileprivate var storeScrollView: UIScrollView!
    public var storeImageView: UIImageView! //保存截取的图片
    public var saveImageBlock:((_ image:UIImage) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configViews()
        configBottons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configViews() {
        storeScrollView = UIScrollView()
        storeScrollView.frame = CGRect(x: 0, y: 0, width: FScreen_W, height: FScreen_H - 50)
        storeScrollView.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        self.addSubview(storeScrollView)
        
        storeImageView = UIImageView()
        self.storeScrollView.addSubview(storeImageView)
    }
    
    public func updateViewWithImage(_ image:UIImage) {
        storeImageView.image = image
        storeImageView.contentMode = .scaleToFill
        storeImageView.frame = CGRect(x: 15, y: 30, width: FScreen_W - 30, height: image.size.height)
        var contentHeiht = image.size.height
        if contentHeiht < FScreen_H {
            contentHeiht = FScreen_H + 10
        }
        storeImageView.viewAddLayerCorner(cornerRadius: 20, UIColor.ff_HexColor(0xFF8200))
        storeScrollView.contentSize = CGSize(width: FScreen_W , height: image.size.height + 40)
    }
    
    @objc func clearShotScreen() {
        self.removeFromSuperview()
    }
    
    @objc func saveButton() {
        self.removeFromSuperview()
        if saveImageBlock != nil && storeImageView.image != nil{
            saveImageBlock!(storeImageView.image!)
        }
    }
    
    fileprivate func configBottons() {
        let leftButton = UIButton(type: .custom)
        leftButton.backgroundColor = UIColor.white
        leftButton.frame = CGRect(x: 0, y:FScreen_H - 50, width: FScreen_W / 2, height: 50)
        leftButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        leftButton.setTitle("重新截取", for: .normal)
        leftButton.setTitleColor(UIColor.ff_HexColor(0x333333), for: .normal)
        leftButton.addTarget(self, action: #selector(clearShotScreen), for: .touchUpInside)
        self.addSubview(leftButton)
        
        let rightButton = UIButton(type: .custom)
        rightButton.backgroundColor = UIColor.ff_HexColor(0xFF8200)
        rightButton.frame = CGRect(x: FScreen_W / 2, y:FScreen_H - 50, width: FScreen_W / 2, height: 50)
        rightButton.setTitle("完成", for: .normal)
        rightButton.setTitleColor(UIColor.white, for: .normal)
        rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        
        rightButton.addTarget(self, action: #selector(saveButton), for: .touchUpInside)
        self.addSubview(rightButton)
    }
}
