//
//  FJButtonCVCell.swift
//  FJAddressPickerDemo
//
//  Created by jun on 2017/6/20.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
class FJButtonCVCell: UICollectionViewCell {
    var model:FJAddressModel? {
        didSet {
            if let text = model?.name {
                titleLabel.text = text
                titleLabel.frame = CGRect(x: 15, y: 0, width: self.frame.width, height: self.frame.height)
            }
        }
    }
    lazy var titleLabel : UILabel = {
        let titleLabel = UILabel(frame:CGRect(x: 15, y: 0, width: self.frame.width, height: self.frame.height))
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
        titleLabel.text = "请选择"
        titleLabel.backgroundColor = UIColor.white
        titleLabel.textColor = UIColor.hexStringColor(hex: "#333333")
        return titleLabel
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    /// 初始化UI
    func setupUI() {
        addSubview(titleLabel)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
