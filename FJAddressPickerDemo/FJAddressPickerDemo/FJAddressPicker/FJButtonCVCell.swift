//
//  FJButtonCVCell.swift
//  FJAddressPickerDemo
//
//  Created by jun on 2017/6/20.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import SnapKit
class FJButtonCVCell: UICollectionViewCell {
    var model:FJAddressModel? {
        didSet {
            if let text = model?.name {
                titleLabel.text = text
            }
        }
    }
    lazy var titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textAlignment = .center
        titleLabel.text = "请选择"
        titleLabel.backgroundColor = UIColor.white
        titleLabel.textColor = UIColor.hexStringColor(hex: "#333333")
        return titleLabel
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    /// 初始化UI
    func setupUI() {
        addSubview(titleLabel)
        
    }
    
    /// 初始化约束
    func setupConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.leftMargin.equalTo(self.contentView.snp.left)
            make.rightMargin.equalTo(self.contentView.snp.right)
            make.topMargin.equalTo(self.contentView.snp.top)
            make.bottomMargin.equalTo(self.contentView.snp.bottom)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
