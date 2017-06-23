//
//  AddressAttribute.swift
//  FJAddressPickerDemo
//
//  Created by jun on 2017/6/23.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class AddressAttribute: NSObject {
    
    /// 未选中颜色
    var noSelectTextColor = UIColor(colorLiteralRed: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1.0)

    /// 选中字体颜色
    var selectTextColor = UIColor(colorLiteralRed: 231/255.0, green: 31/255.0, blue: 25/255.0, alpha: 1.0)
    
    /// 分隔线颜色
    var separationColor = UIColor(colorLiteralRed: 222/255.0, green: 222/255.0, blue: 222/255.0, alpha: 0.6)

    var height:CGFloat = 341
}
