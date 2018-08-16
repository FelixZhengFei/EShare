//
//  FFCameralPlugin.swift
//  SinaAging
//
//  Created by 郑强飞 on 2018/5/15.
//  Copyright © 2018年 sinaAging. All rights reserved.
//

import UIKit
import TZImagePickerController

class FFCameralPlugin: NSObject,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    static let shared = FFCameralPlugin.init()
    public var cameraFinishBlock:((_ images:[UIImage]) -> Void)?
    fileprivate let imagePickerController: UIImagePickerController = UIImagePickerController()
    fileprivate var userHasSelectedPhotos = [UploadImageModel]()//存放图片
    
    private override init() {
        super.init()
        configViews()
    }

    
    /**打开摄像头*/
    public func openCameral(finishBlock:@escaping(_ images:[UIImage])->()) {
        userHasSelectedPhotos.removeAll()
        openPhotoAction()
        self.cameraFinishBlock = finishBlock
    }
    
    /**打开摄像头*/
    public func openPhoto(finishBlock:@escaping(_ images:[UIImage])->()) {
        userHasSelectedPhotos.removeAll()
        openLibaryView()
        self.cameraFinishBlock = finishBlock
    }
}


// MARK: - 图片选择
extension FFCameralPlugin {
    
    /**配置*/
    fileprivate func configViews() {
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = false
    }
    
    /**获取所以图片ULR*/
    fileprivate func getImagesUrlStringFromArray() {
        var imageUrls = [UIImage]()
        for i in 0..<userHasSelectedPhotos.count {
            let model = userHasSelectedPhotos[i]
            imageUrls.append(model.image!)
        }
        if cameraFinishBlock != nil {
            cameraFinishBlock!(imageUrls)
        }
    }
    
    /**打开相册*/
    fileprivate func openLibaryView() {
        let maxImageCount = 5
        let imagePickerVC = TZImagePickerController(maxImagesCount: maxImageCount, columnNumber: 4, delegate: self, pushPhotoPickerVc: true)
        imagePickerVC?.minImagesCount = 0;
        //让完成按钮一直可以点击，无须最少选择一张图片
        imagePickerVC?.alwaysEnableDoneBtn = false
        imagePickerVC?.isSelectOriginalPhoto = true //设置是否选择原图
        imagePickerVC?.allowTakePicture = false // 在内部显示拍照按钮
        imagePickerVC?.allowPickingVideo = false
        imagePickerVC?.allowPickingImage = true
        imagePickerVC?.allowPickingOriginalPhoto = false
        imagePickerVC?.sortAscendingByModificationDate = true
        UIApplication.shared.keyWindow?.rootViewController?.present(imagePickerVC!, animated: true, completion: nil)
    }
    
    /**打开相机*/
   fileprivate func openPhotoAction(){
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        if authStatus == .restricted || authStatus == .denied {
            let alertController = UIAlertController(title: "无法访问相机", message: "请在'设置->隐私->相机'设置为打开状态", preferredStyle:.alert)
            let cancelAction = UIAlertAction(title: "稍后再说", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
            return
        }
        
        // 判断是否支持相册
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePickerController.sourceType = UIImagePickerControllerSourceType.camera
            UIApplication.shared.keyWindow?.rootViewController?.present(imagePickerController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "提示", message: "设备不支持此功能", preferredStyle:.alert)
            let cancelAction = UIAlertAction(title: "知道了", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            cancelAction.setValue(THEME_COLOR, forKey: "titleTextColor")
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
            return
        }
    }
    
    //实现ImagePicker delegate 事件
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        picker.dismiss(animated: true, completion: nil)
        
        let type = info[UIImagePickerControllerMediaType] as! String
        if type == "public.image" {
            let tzImagePickerVC = TZImagePickerController(maxImagesCount: 9, delegate: self)
            tzImagePickerVC?.sortAscendingByModificationDate = true
            tzImagePickerVC?.showProgressHUD()
            let image:UIImage
            if(picker.allowsEditing){
                //裁剪后图片
                image = info[UIImagePickerControllerEditedImage] as! UIImage
            }else{
                //原始图片
                image = info[UIImagePickerControllerOriginalImage] as! UIImage
            }
            TZImageManager().savePhoto(with: image, completion: { (error) in
                if (error != nil) {
                    
                } else {
                    
                    TZImageManager().getCameraRollAlbum(false, allowPickingImage:true, needFetchAssets: false, completion: { (model) in
                        TZImageManager().getAssetsFromFetchResult(model?.result, allowPickingVideo: false, allowPickingImage: true, completion: { (models) in
                            tzImagePickerVC?.hideProgressHUD()
                            self.userHasSelectedPhotos.append(UploadImageModel.getupLoadImageModel(image: image,tagetSize:CGSize(width: 800, height: 800)))
                            self.uploadDetailImages()
                            
                        })
                    })
                }
            })
        }
    }
    
}

// MARK: - TZImagePickerControllerDelegate
extension FFCameralPlugin: TZImagePickerControllerDelegate {
    
    func tz_imagePickerControllerDidCancel(_ picker: TZImagePickerController!) {
    }
    
    func imagePickerController(_ picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [Any]!, isSelectOriginalPhoto: Bool) {
        
        for image in photos {
            userHasSelectedPhotos.append(UploadImageModel.getupLoadImageModel(image: image,tagetSize:CGSize(width: 800, height: 800)))
        }
        uploadDetailImages()
    }
}

// MARK: - 上传图片
extension FFCameralPlugin {
    //上传详细图片
    fileprivate func uploadDetailImages() {
        getImagesUrlStringFromArray()
    }
    
    
}
