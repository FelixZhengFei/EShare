//
//  EENavBar.swift
//  SDYQ
//
//  Created by 陈学明 on 2017/11/28.
//  Copyright © 2017年 shandianyouqian. All rights reserved.
//

import UIKit
import SDAutoLayout

class EENavBar: UIView {
    public var titleLabel:UILabel!
    public var leftButton:UIButton!
    public var line:UIView!
    public var title: String? {
        get {
            return self.titleLabel.text
        }
        set {
            self.titleLabel.text = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI() {
        self.frame = CGRect(x: 0, y: 0, width: CGFloat(SCREEN_W), height: FNavgationBar_H);
        self.backgroundColor = UIColor.white
        setupTitleLabel()
        setupLeftButton()
        self.line = UIView(frame: CGRect(x: 0, y: FNavgationBar_H - 0.5, width: SCREEN_W, height: 0.5));
        self.line.backgroundColor = LINE_COLOR
        self.addSubview(line)
    }
    
    /**title Label*/
    fileprivate func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.black
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        self.addSubview(titleLabel)
        
        _ = titleLabel.sd_layout()
            .widthIs(SCREEN_W - 100)?
            .heightIs(44)?
            .leftSpaceToView(self,50)?
            .bottomSpaceToView(self,0)
    }
    
    /**返回按键*/
    fileprivate func setupLeftButton() {
        leftButton = UIButton(type: .custom)
        leftButton.setImage(UIImage(named: "back"), for: UIControlState(rawValue: 0))
        leftButton.setImage(UIImage(named: "back"), for: .highlighted)
        leftButton.sizeToFit()
        leftButton.backgroundColor = UIColor.clear
        self.addSubview(leftButton)
        
        _ = leftButton.sd_layout()
            .widthIs(44)?
            .heightIs(44)?
            .leftSpaceToView(self,0)?
            .bottomSpaceToView(self,0)
        
    }
}
