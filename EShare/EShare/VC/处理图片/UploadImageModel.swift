//
//  UploadImageModel.swift
//  GuanXinBussinessApp
//
//  Created by 郑强飞 on 16/10/21.
//  Copyright © 2016年 郑强飞. All rights reserved.
//



import UIKit
import FFToolModule
/*
 上传图片对象
 */
@objc(UploadImageModel)
public class UploadImageModel: NSObject {
    var image: UIImage?
    var uploadStatus: Int = 0 // 0 未上传 1已上传 2失败 3上传中
    var imageUrl: String? //上传后 图片路径
    var frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)  // 在屏幕上的位置

//    override public var description: String {
//        return yy_modelDescription()
//    }
//    
    //获取要上传图片对象
    public class func getupLoadImageModel(image : UIImage,tagetSize:CGSize) -> UploadImageModel {
        let model = UploadImageModel()
        model.image = image
        model.uploadStatus = 0
        model.imageUrl = nil
        return model
    }
    
    // 为了让动画效果最佳,最好有 image(原图/缩略图) 和 frame(图片初始位置)
    public class func addImage(_ image: UIImage?,imageUrl: String?,frame: CGRect?) -> UploadImageModel {
        let photo = UploadImageModel()
        photo.image = image
        photo.imageUrl = imageUrl ?? ""
        photo.frame = frame ?? CGRect(x: 0, y: 0, width: 0, height: 0)
        return photo
    }
    
    
}
