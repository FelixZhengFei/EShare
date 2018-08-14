//
//  FFAppDevicePulgin.swift
//
//
//  Created by 郑强飞 on 16/6/29.
//  Copyright © 2016年 itcast. All rights reserved.
//

import Foundation
import UIKit

//获取手机型号 5s 6 6p 6ps等
public enum CommonPhoneDeviceModel: String {
    case iPodTouch5; case iPodTouch6
    case iPhone4; case iPhone4s
    case iPhone5; case iPhone5c; case iPhone5s
    case iPhone6; case iPhone6Plus
    case iPhone6s; case iPhone6sPlus
    case iPhoneSE
    case iPhone7; case iPhone7Plus
    case iPhone8; case iPhone8Plus
    case iPhoneX
    case iPad2; case iPad3; case iPad4
    case iPadAir; case iPadAir2
    case iPadMini; case iPadMini2; case iPadMini3; case iPadMini4
    case iPadPro; case AppleTV; case Simulator; case  processor
}

@objc(FFAppDevicePulgin)
public final class FFAppDevicePulgin: NSObject {
    
    // MARK: - 导航栏高度和屏幕宽高度
    //状态栏高度
    static public let statusBarHeight: CGFloat = {
        if UIScreen.main.bounds.size.height == 812 {
            return 44
        } else {
            return 20
        }
    }()
    
    //iphoneX差
    static public let statusBarOffset: CGFloat = {
        if UIScreen.main.bounds.size.height == 812 {
            return 22
        } else {
            return 0
        }
    }()
    
    //导航栏的高度
    static public let navigationBarHeight: CGFloat = {
        return statusBarHeight + 44
    }()
    
    // MARK: - 导航栏高度和屏幕宽高度
    //状态栏高度
    static public let homeIndicatorHeight: CGFloat = {
        if UIScreen.main.bounds.size.height == 812 {
            return 34
        } else {
            return 0
        }
    }()
    
    //工具栏的高度
    static public let toolBarHeight: CGFloat = {
        return homeIndicatorHeight + 49
    }()
    
    //标准的线条高度
    static public let standardLineHeight: CGFloat = {
        if UIScreen.main.bounds.size.height == 812 {
            return 2/UIScreen.main.scale
        } else {
            return 1.5/UIScreen.main.scale
        }
    }()
    
    static var app_manager_url: String {
        return "https://mmp.weidai.com.cn/mmp/"
    }
    
    // MARK: - 系统版本
    //系统版本
    static public let IOS6 = (UIDevice.current.systemVersion as NSString).doubleValue >= 6.0
    static public let IOS7 = (UIDevice.current.systemVersion as NSString).doubleValue >= 7.0
    static public let IOS8 = (UIDevice.current.systemVersion as NSString).doubleValue >= 8.0
    static public let IOS9 = (UIDevice.current.systemVersion as NSString).doubleValue >= 9.0
    static public let IOS10 = (UIDevice.current.systemVersion as NSString).doubleValue >= 10.0
    static public let IOS11 = (UIDevice.current.systemVersion as NSString).doubleValue >= 11.0
    
    // MARK: - 获取手机设备型号  4s 5 5s 6 6p
    //获取手机设备型号
    static public let phoneDeviceModel:CommonPhoneDeviceModel = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return CommonPhoneDeviceModel.iPodTouch5
        case "iPod7,1":                                 return CommonPhoneDeviceModel.iPodTouch6
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return CommonPhoneDeviceModel.iPhone4
        case "iPhone4,1":                               return CommonPhoneDeviceModel.iPhone4s
        case "iPhone5,1", "iPhone5,2":                  return CommonPhoneDeviceModel.iPhone5
        case "iPhone5,3", "iPhone5,4":                  return CommonPhoneDeviceModel.iPhone5c
        case "iPhone6,1", "iPhone6,2":                  return CommonPhoneDeviceModel.iPhone5s
        case "iPhone7,2":                               return CommonPhoneDeviceModel.iPhone6
        case "iPhone7,1":                               return CommonPhoneDeviceModel.iPhone6Plus
        case "iPhone8,1":                               return CommonPhoneDeviceModel.iPhone6s
        case "iPhone8,2":                               return CommonPhoneDeviceModel.iPhone6sPlus
        case "iPhone8,4":                               return CommonPhoneDeviceModel.iPhoneSE
        case "iPhone9,1", "iPhone9,3":                  return CommonPhoneDeviceModel.iPhone7
        case "iPhone9,2", "iPhone9,4":                  return CommonPhoneDeviceModel.iPhone7Plus
        case "iPhone10,1", "iPhone10,4":                return CommonPhoneDeviceModel.iPhone8
        case "iPhone10,2", "iPhone10,5":                return CommonPhoneDeviceModel.iPhone8Plus
        case "iPhone10,3", "iPhone10,6":                return CommonPhoneDeviceModel.iPhoneX
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return CommonPhoneDeviceModel.iPad2
        case "iPad3,1", "iPad3,2", "iPad3,3":           return CommonPhoneDeviceModel.iPad3
        case "iPad3,4", "iPad3,5", "iPad3,6":           return CommonPhoneDeviceModel.iPad4
        case "iPad4,1", "iPad4,2", "iPad4,3":           return CommonPhoneDeviceModel.iPadAir
        case "iPad5,3", "iPad5,4":                      return CommonPhoneDeviceModel.iPadAir2
        case "iPad2,5", "iPad2,6", "iPad2,7":           return CommonPhoneDeviceModel.iPadMini
        case "iPad4,4", "iPad4,5", "iPad4,6":           return CommonPhoneDeviceModel.iPadMini2
        case "iPad4,7", "iPad4,8", "iPad4,9":           return CommonPhoneDeviceModel.iPadMini3
        case "iPad5,1", "iPad5,2":                      return CommonPhoneDeviceModel.iPadMini4
        case "iPad6,7", "iPad6,8":                      return CommonPhoneDeviceModel.iPadPro
        case "AppleTV5,3":                              return CommonPhoneDeviceModel.AppleTV
        case "i386", "x86_64":                          return CommonPhoneDeviceModel.Simulator
        default:                                        return CommonPhoneDeviceModel.processor
        }
    }()
    
    static public let appVersion:String? = {
        let versionStr = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        let arr = versionStr.components(separatedBy: ".")
        var currentVersion: String = ""
        if arr.count == 1 {
            currentVersion = versionStr + ".0.0"
        } else if arr.count == 2 {
            currentVersion = versionStr + ".0"
        } else if arr.count >= 4 {
            for (index, item) in arr.enumerated() {
                if index < 2 {
                    currentVersion = currentVersion + item + "."
                } else if index == 2 {
                    currentVersion = currentVersion + item
                }
            }
        } else {
            currentVersion = versionStr
        }
        return currentVersion
    }()
    
    //App BuildVersion
    static public let appBuildVersion = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
    
    //App 名称
    static public let appDisplayName:String = Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String
    
    //Bundle Identifier
    static public let appBundleIdentifier:String = Bundle.main.bundleIdentifier!
    
    //ios 版本
    static public let deviceSystemVersion:String = UIDevice.current.systemVersion
    
    //设备名称
    static public let deviceSystemName:String = UIDevice.current.systemName
    
    //设备型号
    static public let deviceModel:String = UIDevice.current.model
    
    //设备区域化型号 如 A1533
    static public let deviceLocalizedModel = UIDevice.current.localizedModel
    
    // MARK: - 获取xcassets中appicon图片
    static public let appIcon: UIImage = {
        let iconsDictionary = Bundle.main.infoDictionary?["CFBundleIcons"] as? NSDictionary
        let primaryIconsDictionary = iconsDictionary?["CFBundlePrimaryIcon"] as? NSDictionary
        let iconFiles = primaryIconsDictionary!["CFBundleIconFiles"] as! NSArray
        // First will be smallest for the device class, last will be the largest for device class
        let lastIcon = iconFiles.lastObject as! NSString
        let icon = UIImage(named: lastIcon as String)
        return icon!
    }()
    
    // MARK: - 获取xcassets中launchImage图片
    static public let launchImage:UIImage = {
        let screenHeight = UIScreen.main.bounds.height
        var launchImageName = ""
        if screenHeight == 480 { //4，4S
            launchImageName = "LaunchImage-700"
        } else if screenHeight == 568 { //5, 5C, 5S, iPod
            launchImageName = "LaunchImage-700-568h"
        } else if screenHeight == 667 { //6, 6S
            launchImageName = "LaunchImage-800-667h"
        } else if screenHeight == 812 { //X
            launchImageName = "LaunchImage-1100-2436h"
        } else { // 6Plus, 6SPlus
            launchImageName = "LaunchImage-800-Portrait-736h"
        }
        return UIImage(named: launchImageName)!
    }()
    
}
