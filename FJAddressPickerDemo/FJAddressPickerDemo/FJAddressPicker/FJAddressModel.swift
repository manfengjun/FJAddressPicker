//
//  FJAddressItem.swift
//  FJAddressPickerDemo
//
//  Created by jun on 2017/6/20.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class FJAddressModel: NSObject {
    var parent_id: Int = 0
    var id: Int = 0
    var level: Int = 0
    var name: String!
    
    /// 是否选中
    var isSelected:Bool = false
}
