//
//  EEBaseVC.swift
//  EShare
//
//  Created by 郑强飞 on 2018/8/14.
//  Copyright © 2018年 EShare. All rights reserved.
//

import UIKit

class EEBaseVC: UIViewController {
    
    /**导航栏*/
    lazy var navigationHeaderView: EENavBar = { ()->EENavBar in
        let navview = EENavBar(frame: CGRect(x: 0, y: 0, width: SCREEN_W, height: 64))
        return navview
    }();
    
    /**导航栏标题*/
    override open var title: String? {
        get{
            return self.navigationHeaderView.title
        }
        set {
            self.navigationHeaderView.title = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden=true
        self.setUpUI()
        self.view.backgroundColor = UIColor.white
    }
    
    
    /**是否隐藏导航*/
    public func hideNavgationBar(isHide:Bool) {
        navigationHeaderView.isHidden = true
    }
    
    /**隐藏返回键*/
    public func hideBackButton() {
        self.navigationHeaderView.leftButton.isHidden = true
    }
    /**返回按键*/
    @objc
    public func leftButtonClicked() {
        
        _ =  self.navigationController?.popViewController(animated: true)
    }
    
}
// MARK: - 配置基本信息
extension EEBaseVC {
    /**配置基本信息*/
    fileprivate func setUpUI() {
        self.view.addSubview(navigationHeaderView)
        self.automaticallyAdjustsScrollViewInsets = false
        self.extendedLayoutIncludesOpaqueBars = true
        self.edgesForExtendedLayout = .top
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent;
        navigationHeaderView.leftButton.addTarget(self, action: #selector(leftButtonClicked), for: .touchUpInside)
    }
}
