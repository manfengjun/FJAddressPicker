//
//  FJAddressTVCell.swift
//  FJAddressPickerDemo
//
//  Created by jun on 2017/6/20.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class FJAddressTVCell: UITableViewCell {
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
        titleLabel.textAlignment = .left
        titleLabel.backgroundColor = UIColor.white
        titleLabel.textColor = UIColor.hexStringColor(hex: "#333333")
        return titleLabel
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    /// 初始化UI
    func setupUI() {
        contentView.addSubview(titleLabel)
        
    }
    
    /// 初始化约束
    func setupConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.leftMargin.equalTo(contentView.snp.leftMargin).offset(20)
            make.rightMargin.equalTo(contentView.snp.rightMargin)
            make.topMargin.equalTo(contentView.snp.topMargin)
            make.bottomMargin.equalTo(contentView.snp.bottomMargin)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
