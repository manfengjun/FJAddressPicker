//
//  RequestUrl.swift
//  HNLYSJB
//
//  Created by jun on 2017/5/22.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
let basePath = "http://test.kymart.cn/index.php?"
let baseHref = "http://test.kymart.cn/"
class SJBRequestUrl: NSObject {
    
    // MARK: ------ 地址管理
    /// 获取地址分级信息
    ///
    /// - Parameters:
    ///   - level: level description
    ///   - parent_id: parent_id description
    /// - Returns: return value description
    class func returnAddressMenuUrl(level:Int, parent_id:Int) -> String {
        return "\(basePath)m=api&c=other&a=region&level=\(level)&parent_id=\(parent_id)"
    }
}


