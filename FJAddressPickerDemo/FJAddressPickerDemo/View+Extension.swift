//
//  View+Extension.swift
//  FJAddressPickerDemo
//
//  Created by jun on 2017/6/20.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

extension UIView {
    func x() -> CGFloat {
        return self.frame.origin.x
    }
    func y() -> CGFloat {
        return self.frame.origin.y
    }
    func width() -> CGFloat {
        return self.frame.size.width
    }
    func height() -> CGFloat {
        return self.frame.size.height
    }
    func right() -> CGFloat {
        return self.frame.origin.x + self.frame.size.width
    }
    func bottom() -> CGFloat {
        return self.frame.origin.y + self.frame.size.height
    }
}
