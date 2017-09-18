//
//  LaunchModel.swift
//  Zhihu_Rx_F
//
//  Created by Fisland_Z on 2017/9/18.
//  Copyright © 2017年 Zehuihong. All rights reserved.
//

import Foundation
import HandyJSON

struct LaunchModel : HandyJSON {
    var creatives : [LaunchModelImg]?
}

struct LaunchModelImg : HandyJSON {
    var url : String?
    var text : String?
    var start_time : Int?
    var impression_track : [String]?
}
