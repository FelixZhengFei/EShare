//
//  GlobalConfig.swift
//  EShare
//
//  Created by 郑强飞 on 2018/8/14.
//  Copyright © 2018年 EShare. All rights reserved.
//
import UIKit
import BYToolModule


/**主题颜色FF9D0F*/
let THEME_COLOR = UIColor.ff_HexColor(0xFF8200)
/**线-颜色*/
let LINE_COLOR = UIColor.ff_HexColor(0xe5e5e5)
/**文本颜色*/
let TEXT_COLOR = UIColor.ff_HexColor(0x333333)


//MARK: ************************常用值配置************************
/**微信Key*/
let WeChat_KEY:String = "wxfa494503c75381a8"
/**微信Key*/
let Sina_KEY:String = "1254661597"


/**屏幕宽度 */
/**屏幕Bounds */
let SCREEN_B:CGRect    = UIScreen.main.bounds
/**屏幕高度 */
let SCREEN_H:CGFloat    = UIScreen.main.bounds.size.height
/**屏幕宽度 */
let SCREEN_W:CGFloat   = UIScreen.main.bounds.size.width
let FScreen_W:CGFloat = UIScreen.main.bounds.width
/**屏幕高度 */
let FScreen_H:CGFloat = UIScreen.main.bounds.height
/**导航栏高度 */
let FNavgationBar_H: CGFloat = FFAppDevicePulgin.navigationBarHeight
/**底部Home高度 */
let FHome_Indicator_H: CGFloat = FFAppDevicePulgin.homeIndicatorHeight
/**Tabar高度 */
let FTabBar_H: CGFloat = FFAppDevicePulgin.toolBarHeight
/**状态栏高度 */
let FStatusBar_H: CGFloat = FFAppDevicePulgin.statusBarHeight
/**状态栏高度差 */
let FStatusBar_OFFSET: CGFloat = FFAppDevicePulgin.statusBarOffset
/**默认借款额度(元)*/
let Default_Loan_Amount: Int64 = 20000




/**系统版本*/
let System_Version:String = UIDevice.current.systemVersion
/**App 版本*/
let App_Version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
/**App 构建版本*/
let App_Build_Version = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
/**App 名称*/
let App_Display_Name:String = Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String
/**Bundle Identifier 包标识符*/
let App_Bundle_Identifier:String = Bundle.main.bundleIdentifier!
/**设备系统名称（如：iOS、iPad）*/
let Device_System_Name:String = UIDevice.current.systemName


//MARK: ************************Log************************

public func FFPrint<N>(_ message:N,fileName:String = #file,methodName:String = #function,lineNumber:Int = #line) {
    #if DEBUG
        print("\(message)");
    #else
    #endif
}


