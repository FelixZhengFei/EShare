//
//  UIView+extension.swift
//  FFToolModule
//
//  Created by 郑强飞 on 2017/4/19.
//  Copyright © 2017年 郑强飞. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    // MARK: -Bezier加圆角
    /**Bezier加圆角*/
    open func viewAddBezierCorner(cornerRadius:CGFloat) {
        let cornerSize: CGSize = CGSize(width: cornerRadius, height: cornerRadius)
        let roundingCorners: UIRectCorner = [.bottomLeft,.bottomRight,.topLeft,.topRight]
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: roundingCorners, cornerRadii: cornerSize)
        let cornerLayer = CAShapeLayer()
        cornerLayer.frame = bounds
        cornerLayer.path = path.cgPath
        
        layer.mask = cornerLayer
    }
    
    // MARK: -获取控件相对widow的Y
    /**获取控件相对widow的Y*/
   open static func getControlY_Coord_ToWindow(superView:UIView,childerViewFrame:CGRect) ->CGFloat {
        let frame = superView.convert(childerViewFrame, to: nil)
        return frame.origin.y
    }
    
    // MARK: - 传统加圆角
    /**传统加圆角*/
    open func viewAddLayerCorner(cornerRadius: CGFloat,_ borderColor:UIColor) {
        layer.cornerRadius = cornerRadius;//设置那个圆角的有多圆
        layer.borderWidth = 0.5;//设置边框的宽度，当然可以不要
        layer.borderColor = borderColor.cgColor//设置边框的颜色
        layer.masksToBounds = true;//设为NO去试试
    }
    
    // MARK: - 蓝色渐变
    /**蓝色渐变*/
    public func getBlueGradientColor() ->UIColor{
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor.RGB(124, 242, 255).cgColor,
                                UIColor.RGB(112, 217, 244).cgColor,
                                UIColor.RGB(64, 198, 255).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        let gradientImage = UIImage.imageFromLayer(layer: gradientLayer)
        let coloer = UIColor.init(patternImage: gradientImage)
        return coloer
    }
    
    // MARK: - 黄色渐变
    /**黄色渐变*/
    public func getYellorGradientColor()->UIColor {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds

        gradientLayer.colors = [UIColor.RGB(249, 210, 99).cgColor,
                                UIColor.RGB(249, 194, 84).cgColor,
                                UIColor.RGB(255, 157, 15).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        let gradientImage = UIImage.imageFromLayer(layer: gradientLayer)
        let coloer = UIColor.init(patternImage: gradientImage)
        return coloer
    }
    
    // MARK: - 红色渐变
    /**红色渐变*/
    public func getRedGradientColor()->UIColor {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor.RGB(255, 179, 101).cgColor,
                                UIColor.RGB(255, 113, 66).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        let gradientImage = UIImage.imageFromLayer(layer: gradientLayer)
        let coloer = UIColor.init(patternImage: gradientImage)
        return coloer
    }

}

