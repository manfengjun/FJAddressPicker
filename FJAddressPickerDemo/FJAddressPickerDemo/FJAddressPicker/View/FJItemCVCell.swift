//
//  FJItemCVCell.swift
//  FJAddressPickerDemo
//
//  Created by jun on 2017/6/23.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class FJItemCVCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    var model:FJAddressModel? {
        didSet {
            if let text = model?.name {
                titleLabel.text = text
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
