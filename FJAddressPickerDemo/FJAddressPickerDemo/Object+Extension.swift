//
//  Object+Extension.swift
//  HNLYSJB
//
//  Created by jun on 2017/5/23.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
extension NSObject{

}

// MARK: ------ 输入合法性验证
extension NSObject{
    func pathForName(name:String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = paths.last
        let dbPath = "\(documentDirectory!)/\(name)"
        return dbPath
    }
}
