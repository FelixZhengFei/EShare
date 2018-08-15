//
//  EEAboutUsVC.swift
//  EShare
//
//  Created by 郑强飞 on 2018/8/15.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

import UIKit

class EEAboutUsVC: EEBaseVC {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "关于"
        iconImageView.viewAddLayerCorner(cornerRadius: 10, UIColor.ff_HexColor(0xDDDDDD))
        nameLabel.text = App_Display_Name
        versionLabel.text = "V" + App_Version
        configInfoLabel()
    }
    
    fileprivate func configInfoLabel() {
        let nameString = """
            U-Screen 是一款已截取网站长图为主功能的App,并可以对图片进行深度渲染处理，完成后可以将图片保存到手机照相库或者分享给其他朋友
        """
        let nameStr:NSMutableAttributedString = NSMutableAttributedString(string: nameString)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 12
        paragraphStyle.alignment = .right
        nameStr.addAttribute(kCTParagraphStyleAttributeName as NSAttributedStringKey, value: paragraphStyle, range: NSMakeRange(0, nameString.count))
        infoLabel.attributedText = nameStr
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
