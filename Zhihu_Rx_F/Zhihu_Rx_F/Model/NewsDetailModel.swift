//
//  NewsDetailModel.swift
//  Zhihu_Rx_F
//
//  Created by Fisland_Z on 2017/9/18.
//  Copyright © 2017年 Zehuihong. All rights reserved.
//

import Foundation
import HandyJSON

struct NewDetailModel : HandyJSON {
    var body: String?
    var ga_prefix: String?
    var id: Int?
    var image: String?
    var image_source: String?
    var share_url: String?
    var title: String?
    var type: Int?
    var images: [String]?
    var css: [String]?
    var js: [String]?
}
