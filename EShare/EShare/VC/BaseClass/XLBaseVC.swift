//
//  XLBaseVC.swift
//  SDYQ
//
//  Created by 陈学明 on 2017/11/28.
//  Copyright © 2017年 shandianyouqian. All rights reserved.
//

import UIKit

class XLBaseVC: UIViewController {
    
    /**导航栏*/
    lazy var navigationHeaderView: XLNavBar = { ()->XLNavBar in
        let navview = XLNavBar(frame: CGRect(x: 0, y: 0, width: SCREEN_W, height: 64))
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
extension XLBaseVC {
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
