//
//  EEHeChengVC.swift
//  EShare
//
//  Created by 郑强飞 on 2018/8/16.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

import UIKit

class EEHeChengVC: EEBaseVC {
    
    fileprivate var baseScollview = UIScrollView()
    fileprivate var dataSource = [UIImage]()
    fileprivate var colltionView : UICollectionView?
    fileprivate var noDataView = UIView()
    fileprivate var rightButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "合成长图"
        initView()
        configNoDataView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - 私有方法
extension EEHeChengVC  {
    
    fileprivate func initView(){
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        colltionView = UICollectionView(frame: CGRect(x: 0, y: FNavgationBar_H, width: FScreen_W, height: FScreen_H - FNavgationBar_H), collectionViewLayout: layout)
        //注册一个cell
        colltionView?.register(UINib(nibName: "EESelectedImageCell", bundle: nil), forCellWithReuseIdentifier: "EESelectedImageCell")
        colltionView?.delegate = self;
        colltionView?.dataSource = self;
        colltionView?.backgroundColor = UIColor.white
        //设置每一个cell的宽高
        self.view.addSubview(colltionView!)
        
        let longGesture = UILongPressGestureRecognizer.init(target: self, action: #selector(handlelongGestuer(_:)))
        self.colltionView?.addGestureRecognizer(longGesture)
    }
    
    fileprivate func configNoDataView() {
        noDataView.frame = CGRect(x: 0, y: FNavgationBar_H, width: FScreen_W, height: FScreen_H - FNavgationBar_H)
        self.view.addSubview(noDataView)
        let addButton = UIButton(type: .custom)
        addButton.setImage(#imageLiteral(resourceName: "camera"), for: .normal)
        addButton.setImage(#imageLiteral(resourceName: "camera"), for: .normal)
        addButton.frame = CGRect(x: (FScreen_W - 100)/2, y: 30, width: 100, height: 100)
        addButton.setTitleColor(UIColor.ff_HexColor(0xFF8200), for: .normal)
        addButton.addTarget(self, action: #selector(configShareAlertView), for: .touchUpInside)
        
        let label = UILabel(frame: CGRect(x: 0, y:105, width: FScreen_W, height: 20))
        label.text = "请选择图片"
        label.textColor = UIColor.ff_HexColor(0xFF8200)
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textAlignment = .center
        
        let tosetLabel = UILabel(frame: CGRect(x: 0, y:noDataView.height - 40, width: FScreen_W, height: 20))
        tosetLabel.text = "为了控制图片大小和质量，最多能9张图片"
        tosetLabel.textColor = UIColor.ff_HexColor(0x999999)
        tosetLabel.font = UIFont.systemFont(ofSize: 12)
        tosetLabel.textAlignment = .center
        
        noDataView.addSubview(label)
        noDataView.addSubview(addButton)
        noDataView.addSubview(tosetLabel)

        rightButton = UIButton(type: .custom)
        rightButton.setImage(#imageLiteral(resourceName: "camera"), for: .normal)
        rightButton.setImage(#imageLiteral(resourceName: "camera"), for: .normal)
        rightButton.frame = CGRect(x: FScreen_W - 50, y:FStatusBar_H, width: 44, height: 44)
        rightButton.addTarget(self, action: #selector(configShareAlertView), for: .touchUpInside)
        self.navigationHeaderView.addSubview(rightButton)
        updateViewStatus()
    }

    @objc fileprivate func configShareAlertView() {
        openPhotoMethod()
    }

    /**修改状态*/
    fileprivate func updateViewStatus() {
        if dataSource.count <= 0 {
            noDataView.isHidden = false
            rightButton.isHidden = true
            colltionView?.isHidden = true
        } else {
            noDataView.isHidden = true
            rightButton.isHidden = false
            colltionView?.isHidden = false
        }
    }
    
    /**打开照片库*/
    fileprivate func openPhotoMethod() {
        weak var weakSelf = self
        if dataSource.count > 9 {
            EEWrongAlert.show("最多能选择9张图片")
            return
        }
        FFCameralPlugin.shared.openPhoto { (array) in
            weakSelf?.dataSource += array
            weakSelf?.updateViewStatus()
            weakSelf?.colltionView?.reloadData()
        }
    }
    
    ///删除
    @objc fileprivate func closeButtonClicked(_ button:UIButton) {
        if button.tag < dataSource.count {
            dataSource.remove(at: button.tag)
            updateViewStatus()
            colltionView?.reloadData()
        }
    }
    
    ///长按手势
    @objc func handlelongGestuer(_ longGesture:UILongPressGestureRecognizer) {
        switch longGesture.state {
        case .began:
            let indexPath = self.colltionView?.indexPathForItem(at: longGesture.location(in: self.colltionView))
            if indexPath != nil {
                self.colltionView?.beginInteractiveMovementForItem(at: indexPath!)
            }
            break
            
        case .changed:
            self.colltionView?.updateInteractiveMovementTargetPosition(longGesture.location(in: self.colltionView))
            break
            
        case .ended:
            self.colltionView?.endInteractiveMovement()
        default:
            self.colltionView?.cancelInteractiveMovement()
        }
    }
}

extension EEHeChengVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var imageHeight:CGFloat = 0
        if dataSource.count > 0 {
            let image = dataSource[indexPath.row]
            imageHeight = image.size.height * FScreen_W / image.size.width
        }
        return CGSize(width: FScreen_W, height: imageHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EESelectedImageCell", for: indexPath) as! EESelectedImageCell
        let image = dataSource[indexPath.row]
        cell.imageView?.image = image
        cell.closeButton.tag = indexPath.row
        cell.closeButton.addTarget(self, action: #selector(closeButtonClicked(_:)), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let data = self.dataSource[sourceIndexPath.item]
        self.dataSource.remove(at: sourceIndexPath.item)
        self.dataSource.insert(data, at: destinationIndexPath.item)
    }
}
