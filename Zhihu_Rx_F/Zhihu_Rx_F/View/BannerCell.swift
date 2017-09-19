//
//  BannerCell.swift
//  Zhihu_Rx_F
//
//  Created by Fisland_Z on 2017/9/19.
//  Copyright © 2017年 Zehuihong. All rights reserved.
//

import UIKit

class BannerCell: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var imgTitle: UILabel!
    
    override func awakeFromNib() {
        //        titlebackView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.05)
        imgTitle.font = UIFont.boldSystemFont(ofSize: 21)
    }

}
