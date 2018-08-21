//
//  EENavgationVC.swift
//  EShare
//
//  Created by 郑强飞 on 2018/8/14.
//  Copyright © 2018年 EShare. All rights reserved.
//

import UIKit


class EENavgationVC: UINavigationController, UIGestureRecognizerDelegate {
    
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
