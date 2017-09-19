//
//  ListTableViewCell.swift
//  Zhihu_Rx_F
//
//  Created by Fisland_Z on 2017/9/19.
//  Copyright © 2017年 Zehuihong. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleRight: NSLayoutConstraint!
    @IBOutlet weak var morepicImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
