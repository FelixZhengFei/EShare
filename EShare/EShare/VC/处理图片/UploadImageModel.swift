//
//  UploadImageModel.swift
//  EShare
//
//  Created by 郑强飞 on 18/8/15.
//  Copyright © 2018年 郑强飞. All rights reserved.
//



import UIKit
import FFToolModule

@objc(UploadImageModel)
public class UploadImageModel: NSObject {
    var image: UIImage?
    var frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)  // 在屏幕上的位置

    //获取要上传图片对象
    public class func getupLoadImageModel(image : UIImage,tagetSize:CGSize) -> UploadImageModel {
        let model = UploadImageModel()
        model.image = image
        return model
    }
    
}
