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
//                let width = widthForsize(text: model.name, size: CGSize(width:10000, height:35), font: 14)
//                titleLabel.frame = CGRect(x: 15, y: 0, width: self.frame.width, height: self.frame.height)
                titleLabel.text = text
            }
        }
    }
    lazy var titleLabel : UILabel = {
        let titleLabel = UILabel(frame:CGRect(x: 15, y: 0, width: self.frame.width, height: self.frame.height))
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textAlignment = .left

        titleLabel.backgroundColor = UIColor.white
        titleLabel.textColor = UIColor.hexStringColor(hex: "#333333")
        return titleLabel
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    /// 初始化UI
    func setupUI() {
        contentView.addSubview(titleLabel)
        
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
