//
//  String+Extensions.swift
//  FFToolModule
//
//  Created by apple on 16/7/10.
//  Copyright © 2017年 郑强飞. All rights reserved.
//

import Foundation
import UIKit
import AdSupport

extension String {
    // MARK: - 类型转换
    /**类型转换*/
    public func toBool() -> Bool {
        switch self {
        case "True", "true", "yes", "1":
            return true
        default:
            return false
        }
    }
    
    // MARK: - 手机号码验证
    /**手机号码验证*/
    public func isPhoneNumber() -> Bool {
        if self.isEmpty {
            return false
        }
        var phoneString = self.replacingOccurrences(of:" ", with: "")
        phoneString = phoneString.replacingOccurrences(of: " ", with: "")
        phoneString = phoneString.replacingOccurrences(of: " ", with: "")
        phoneString = phoneString.replacingOccurrences(of: "-", with: "")
        phoneString = phoneString.replacingOccurrences(of: "—", with: "")
        let mobile = "^(10[0-9]|11[0-9]|12[0-9]|13[0-9]|14[0-9]|15[0-9]|16[0-9]|18[0-9]|19[0-9]|17[0-9]|147)\\d{8}$"
        let regexMobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        if regexMobile.evaluate(with: phoneString) == true {
            return true
        } else {
            return false
        }
    }
    
    // MARK: -判断身份证
    /**判断身份证*/
    public func isValidateIDCard() ->Bool {
        let match = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        let predicate = NSPredicate(format: "SELF MATCHES %@",match)
        if predicate.evaluate(with: self) == true {
            return true
        } else {
            return false
        }
    }
    
    // MARK: - 邮编号码的验证
    /**邮编号码的验证*/
    public func isZipCodeNumber() -> Bool {
        if self.count == 0 {
            return false
        }
        let zipCodeNumber = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let regexCodeNumber = NSPredicate(format: "SELF MATCHES %@",zipCodeNumber)
        if regexCodeNumber.evaluate(with: self) == true {
            return true
        } else {
            return false
        }
    }
    
    // MARK: -邮箱验证
    /**邮箱验证*/
    public func isValidateEmail() ->Bool {
        let match = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let predicate = NSPredicate(format: "SELF MATCHES %@",match)
        if predicate.evaluate(with: self) == true {
            return true
        } else {
            return false
        }
    }
    
    // MARK: -获取姓氏
    /**获取姓氏*/
    public static func getUserSurname(nameString:String) ->String {
        let shuanXingArray = ["欧阳","太史","端木","上官","司马","东方","独孤","南宫","万俟","闻人","夏侯","诸葛","尉迟","公羊","赫连","澹台","皇甫","宗政","濮阳","公冶","太叔","申屠","公孙","慕容","仲孙","钟离","长孙","宇文","司徒","鲜于","司空","闾丘","子车","亓官","司寇","巫马","公西","颛孙","壤驷","公良","漆雕","乐正","宰父","谷梁","拓跋","夹谷","轩辕","令狐","段干","百里","呼延","东郭","南门","羊舌","微生","公户","公玉","公仪","梁丘","公仲","公上","公门","公山","公坚","左丘","公伯","西门","公祖","第五","公乘","贯丘","公皙","南荣","东里","东宫","仲长","子书","子桑","即墨","达奚","褚师","吴铭"]
        if nameString.count == 0 {
            return nameString
        } else if nameString.count == 1 {
            return (nameString as NSString).substring(to: 1)
        } else {
            let twoChatr = (nameString as NSString).substring(to: 2)
            if shuanXingArray.contains(twoChatr) {
                return twoChatr
            } else {
                return (nameString as NSString).substring(to: 1)
            }
        }
    }
    
    
    // MARK: -微信认证
    /**微信认证*/
    public func isValidateWechat() ->Bool {
        let match = "/^[a-zA-Z0-9_]+$/"
        let predicate = NSPredicate(format: "SELF MATCHES %@",match)
        if predicate.evaluate(with: self) == true {
            return true
        } else {
            return false
        }
    }
    
    // MARK: -是否含有中文
    /**是否含有中文*/
    public func hasChinese() ->Bool {
        for character in self {
            let sigleStr = String.init(character)
            let count:Int64 = Int64(sigleStr.lengthOfBytes(using: String.Encoding.utf8))
            if count >= 3 {
                return true
            }
        }
        return false
    }
    
    // MARK: - URL验证
    /**URL验证*/
    public func isValidateHttpUrl() ->Bool {
        let match = "^(((file|gopher|news|nntp|telnet|http|ftp|https|ftps|sftp)://)|(www/.))+(([a-zA-Z0-9/._-]+/.[a-zA-Z]{2,6})|([0-9]{1,3}/.[0-9]{1,3}/.[0-9]{1,3}/.[0-9]{1,3}))(/[a-zA-Z0-9/&%_/./-~-]*)?$"
        let predicate = NSPredicate(format: "SELF MATCHES %@",match)
        if predicate.evaluate(with: self) == true {
            return true
        } else {
            return false
        }
    }
    
    // MARK: - 密码验证
    /**密码验证*/
    public func isValidatePassword() ->Bool {
        let match = "^[a-zA-Z0-9]\\S|\\S{5,15}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@",match)
        if predicate.evaluate(with: self) == true {
            return true
        } else {
            return false
        }
    }
    
    // MARK: - 判断空
    /**判断空*/
    public func isNULLOrEmpty() ->Bool {
        if self.isEmpty || self == "" || self == "<null>" || self == "(null)" {
            return true
        }
        return false
    }
    
    // MARK: - 计算文本的汉字数
    /**计算文本的汉字数*/
    public static func calculateChineseCountInString(_ string:String) ->Int64 {
        if (string.isNULLOrEmpty()) {
            return 0
        }
        let len = string.count
        let pattern = "[^\\x00-\\xff]"
        guard let regx = try? NSRegularExpression(pattern: pattern, options: [])
            else {
                return 0
        }
        let numMatch = regx.numberOfMatches(in: string, options: .reportProgress, range: NSRange(location: 0, length: len))
        return Int64((len + numMatch + 1) / 2)
    }
    
    //MARK:获得string内容高度
    /**获得string内容高度*/
    public static func caleStringNeedSize(labelStr:String,fontSize:CGFloat = 14,width:CGFloat = UIScreen.main.bounds.width,lineSpace : CGFloat = 0)->CGSize{
        let font = UIFont.systemFont(ofSize: fontSize)
        let size = CGSize(width: width, height: CGFloat(MAXFLOAT))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpace
        paragraphStyle.lineBreakMode = .byWordWrapping;
        let attributes = [NSAttributedStringKey.font:font, NSAttributedStringKey.paragraphStyle:paragraphStyle.copy()]
        let text = labelStr as NSString
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: attributes, context:nil)
        return rect.size
    }
    
    // MARK: - URL字符串的编码与解码
    public func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    
    // MARK: - 将编码后的url转换回原始的url
    public func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
    
    // MARK: - 根据开始位置和长度替换
    public func replacingCharacters(start:Int, length:Int = -1, with: String)->String {
        var len = length
        if len == -1 {
            len = self.count - start
        }
        let st = self.index(startIndex, offsetBy:start)
        let en = self.index(st, offsetBy:len)
        let range = st ..< en
        return replacingCharacters(in: range, with: with)
    }
    
    // MARK: - 随机字符串
    static public func randomString(len:Int)->String{
        let min:UInt32=33,max:UInt32=127
        var string=""
        for _ in 0..<len{
            string.append(Character(UnicodeScalar(Int.random(min: min, max: max))!))
        }
        return string
    }
    
    /// 从当前字符串中，提取链接和文本
    /// Swift 提供了`元组`，同时返回多个值
    /// 如果是 OC，可以返回字典／自定义对象／指针的指针
    public func cz_href() -> (link: String, text: String)? {
        
        // 0. 匹配方案
        let pattern = "<a href=\"(.*?)\".*?>(.*?)</a>"
        
        // 1. 创建正则表达式，并且匹配第一项
        guard let regx = try? NSRegularExpression(pattern: pattern, options: []),
            let result = regx.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.count))
            else {
                return nil
        }
        
        // 2. 获取结果
        let link = (self as NSString).substring(with: result.range(at: 1))
        let text = (self as NSString).substring(with: result.range(at: 2))
        
        return (link, text)
    }
    
    /**获取 IP 地址*/
    public static func getLocalIPAddressForCurrentWiFi() -> String {
        var address: String?
        // get list of all interfaces on the local machine
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        guard getifaddrs(&ifaddr) == 0 else {
            return ""
        }
        guard let firstAddr = ifaddr else {
            return ""
        }
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            
            let interface = ifptr.pointee
            
            // Check for IPV4 or IPV6 interface
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                // Check interface name
                let name = String(cString: interface.ifa_name)
                if name == "en0" {
                    // Convert interface address to a human readable string
                    var addr = interface.ifa_addr.pointee
                    var hostName = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(&addr,
                                socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostName, socklen_t(hostName.count), nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostName)
                }
            }
        }
        freeifaddrs(ifaddr)
        return address ?? ""
    }
    
    /** IDFA 广告id*/
    public static func getDeviceIDFA() -> String {
        let idfaString = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        return idfaString
    }
    
    /** IDFV 唯一标示码*/
    public static func getDeviceIDFV() -> String {
        let idfv = UIDevice.current.identifierForVendor?.uuidString
        return idfv ?? ""
    }
    
    /*检查是否越狱  0:没 1:有*/
    public static func getDeviceHasRoot()->Int {
        let isExit = FileManager.default.fileExists(atPath: "User/Applications/")
        if isExit {
            return 1
        }
        return 0
    }
}
