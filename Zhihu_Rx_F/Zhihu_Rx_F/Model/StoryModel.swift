//
//  StoryModel.swift
//  Zhihu_Rx_F
//
//  Created by Fisland_Z on 2017/9/18.
//  Copyright © 2017年 Zehuihong. All rights reserved.
//

import Foundation
import HandyJSON

struct listModel : HandyJSON {
    var date: String?
    var stories: [StoryModel]?
    var top_stories: [StoryModel]?
}

struct StoryModel : HandyJSON {
    var ga_prefix: String?
    var id: Int?
    var images: [String]? //list_stories
    var title: String?
    var type: Int?
    var image: String? //top_stories
    var multipic = false
}
