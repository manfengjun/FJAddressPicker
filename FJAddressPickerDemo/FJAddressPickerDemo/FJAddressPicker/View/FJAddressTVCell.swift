//
//  FJAddressTVCell.swift
//  FJAddressPickerDemo
//
//  Created by jun on 2017/6/23.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class FJAddressTVCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleIV: UIImageView!
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
