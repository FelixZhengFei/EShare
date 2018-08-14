//
//  FFBaseEmptyView.swift
//  EmptyPage
//
//  Created by linhey on 2018/1/10.
//  Copyright © 2018年 linhey <linhan.linhey@outlook.com>. All rights reserved.

import UIKit


open class FFBaseEmptyView: UIView {
    
    open class var backgroundView: FFBaseEmptyView {
        let view = FFBaseEmptyView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.white
        return view
    }
    
    open class func mix(view: UIView) -> FFBaseEmptyView {
        let backView = backgroundView
        backView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let lay1 = NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: view.superview, attribute: .centerX, multiplier: 1, constant: 0)
        let lay2 = NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: view.superview, attribute: .centerY, multiplier: 1, constant: 0)
        let lay3 = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: view.superview, attribute: .width, multiplier: 1, constant: 0)
        backView.addConstraints([lay1,lay2,lay3])
        return backView
    }
    
    open class func mix(view: UIView,_ y_Coord:CGFloat) -> FFBaseEmptyView {
        let backView = backgroundView
        backView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let lay1 = NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: view.superview, attribute: .centerX, multiplier: 1, constant: 0)
        let lay2 = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: view.superview, attribute: .top, multiplier: 1, constant: y_Coord)
        
        let width:NSLayoutConstraint = NSLayoutConstraint(item: view, attribute:.width, relatedBy:.equal, toItem:nil, attribute:.notAnAttribute, multiplier:0.0, constant:view.frame.width)
        backView.addConstraints([lay1,lay2,width])
        
        return backView
    }
}







