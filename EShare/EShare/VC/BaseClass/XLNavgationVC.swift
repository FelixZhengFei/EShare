//
//  XLNavgationVC.swift
//  SDYQ
//
//  Created by 陈学明 on 2017/11/28.
//  Copyright © 2017年 shandianyouqian. All rights reserved.
//

import UIKit
/** 基类导航控制器
 */
class XLNavgationVC: UINavigationController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isHidden = true
        self.interactivePopGestureRecognizer?.delegate = self;
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if (self.childViewControllers.count==1) {
            viewController.hidesBottomBarWhenPushed = true;
        }
        super.pushViewController(viewController, animated: animated)
    }
    override func popViewController(animated: Bool) -> UIViewController? {
       let vc = super.popViewController(animated: animated)
        if self.childViewControllers.count == 2 {
            self.childViewControllers.last?.hidesBottomBarWhenPushed = true
        }
        return vc
    }
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.childViewControllers.count > 1;
    }
}
