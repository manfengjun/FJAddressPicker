//
//  Common.swift
//  HNLYSJB
//
//  Created by jun on 2017/5/20.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
/// 屏幕宽度
let SCREEN_WIDTH = UIScreen.main.bounds.width
/// 屏幕高度
let SCREEN_HEIGHT = UIScreen.main.bounds.height
/// 屏幕bounds
let SCREEN_BOUNDS = UIScreen.main.bounds


/// 字体大小
let FONT_SIZE = 12
/// 字体
let FONT_NAME = "Microsoft YaHei"




/// NavigationBar颜色
let BAR_TINTCOLOR = UIColor.hexStringColor(hex: "#E71F19")
//UIColor.hexStringColor(hex: "#F4F4F4")
let HOME_BAR_TINTCOLOR = UIColor.hexStringColor(hex: "#E71F19")



/// 图片链接
///
/// - Parameter goods_id: goods_id description
/// - Returns: return value description
func imageUrl(goods_id:Int) -> URL {
    let url = URL(string: "\(baseHref)/index.php?m=api&c=goods&a=goodsThumImages&goods_id=\(goods_id))&width=400&height=400")
    return url!
}



/// 通知名称
let SelectProductProperty = NSNotification.Name(rawValue: "SelectProductProperty")




