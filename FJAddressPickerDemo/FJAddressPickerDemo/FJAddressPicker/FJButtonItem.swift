//
//  FJButtonItem.swift
//  FJAddressPickerDemo
//
//  Created by jun on 2017/6/20.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import SnapKit
class FJButtonItem: UIView {
    var model:FJAddressModel? {
        didSet {
            if let text = model?.name {
                titleLabel.text = text
            }
        }
    }
    fileprivate lazy var titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = UIColor.red
        titleLabel.textColor = UIColor.hexStringColor(hex: "#333333")
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        backgroundColor = UIColor.blue
        setupConstraints()
    }
    
    /// 初始化UI
    func setupUI() {
        addSubview(titleLabel)
        
    }
    
    /// 初始化约束
    func setupConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(self).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
