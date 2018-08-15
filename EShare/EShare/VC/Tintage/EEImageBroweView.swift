//
//  EEImageBroweView.swift
//  EShare
//
//  Created by 郑强飞 on 2018/8/14.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

import UIKit

import UIKit
import SDWebImage

class EEImageBroweView: UIView {
    
    private lazy var scrollview = UIScrollView()
    public lazy var imageView = UIImageView()
    
    var recordImage:UIImage?
    ///是否双击图片
    var isClick:Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupIU()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc private func setupIU() {
        self.addSubview(scrollview)
        scrollview.addSubview(imageView)
        scrollview.backgroundColor = UIColor.clear
        
        scrollview.delegate = self
        scrollview.maximumZoomScale = 4.0
        scrollview.minimumZoomScale = 0.5
        scrollview.showsVerticalScrollIndicator = false
        scrollview.showsHorizontalScrollIndicator = false
        
        imageView.isUserInteractionEnabled = true
        let tapTwo = UITapGestureRecognizer(target: self, action: #selector(EEImageBroweView.handleDouble(recongnizer:)))
        tapTwo.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(tapTwo)
        
        let tapOne = UITapGestureRecognizer(target: self, action: #selector(EEImageBroweView.handleOneClick(recongnizer:)))
        tapOne.numberOfTapsRequired = 1
        imageView.addGestureRecognizer(tapOne)
        
        //当没有检测到双击 或者 检测双击失败，单击才有效
        tapOne.require(toFail: tapTwo)
        
    }
    
    @objc func handleOneClick(recongnizer:UITapGestureRecognizer) {
        if isClick == true {
            UIView.animate(withDuration: 0.3, animations: {
                self.scrollview.zoomScale = 0
                self.setImageViewPosition(image: self.recordImage!)
            })
            isClick = false
            return
        }
    }
    

    
    /// 双击图片的处理
    @objc func handleDouble(recongnizer:UITapGestureRecognizer) {
        
        let status = recongnizer.state
        if isClick == false {
            switch status {
            case .began: break
            case .changed: break
            case .cancelled: break
            case .ended:
                //以点击的点为中心,放大图片
                let  point = recongnizer.location(in: recongnizer.view)
                let zoom = scrollview.zoomScale > 0 ? true : false
                let scale = zoom ? scrollview.maximumZoomScale : scrollview.minimumZoomScale
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.scrollview.zoomScale  = scale
                    if zoom {
                        var x = point.x * scale - self.scrollview.bounds.size.width/2
                        let maxX = self.scrollview.contentSize.width - self.scrollview.bounds.size.width
                        let minX = CGFloat.leastNormalMagnitude
                        x = x > maxX ? maxX : x
                        x = x < minX ? minX : x
                        var y = point.y * scale - self.scrollview.bounds.size.height * 0.5
                        let maxY = self.scrollview.contentSize.height - self.scrollview.bounds.size.height
                        let minY = CGFloat.leastNormalMagnitude
                        y = y > maxY ? maxY : y
                        y = y < minY ? minY : y
                        self.scrollview.contentOffset = CGPoint(x: x, y: y)
                    }
                })
                isClick = true
            default:
                break
            }
            
        }else{
            switch status {
            case .began: break
            case .changed: break
            case .cancelled: break
            case .ended:
                UIView.animate(withDuration: 0.3, animations: {
                    self.scrollview.zoomScale = 0
                    self.setImageViewPosition(image: self.recordImage!)
                })
                isClick = false
            default:
                break
            }
        }
    }
    
    
    func loadImage()  {
        guard let image = recordImage else {
            return
        }
        //设置图像视图的大小
        imageView.image = image
        setImageViewPosition(image: image)
    }
    
    func setImageViewPosition(image:UIImage) {
        
        let size = imageSizeWithScreen(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        scrollview.frame = self.bounds
        scrollview.contentSize = size
        imageView.backgroundColor = UIColor.red
        if size.height < scrollview.bounds.size.height {
            imageView.frame.origin.y = (scrollview.bounds.size.height - size.height) * 0.5
        }
    }
    
    func imageSizeWithScreen(image:UIImage) -> CGSize {
        var size = self.frame.size
        size.height = image.size.height * size.width / image.size.width
        return size
    }
    
}

extension EEImageBroweView:UIScrollViewDelegate {
    //指定缩放UIScrolleView时，缩放UIImageView来适配
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    //缩放后让图片显示到屏幕中间
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let originalSize = scrollView.bounds.size;
        let contentSize = scrollView.contentSize;
        let offsetX = originalSize.width > contentSize.width ? (originalSize.width-contentSize.width)/2 : 0
        let offsetY = originalSize.height > contentSize.height ? (originalSize.height-contentSize.height)/2 : 0
        self.imageView.center = CGPoint(x: contentSize.width/2+offsetX, y: contentSize.height/2+offsetY)
    }
    
}

