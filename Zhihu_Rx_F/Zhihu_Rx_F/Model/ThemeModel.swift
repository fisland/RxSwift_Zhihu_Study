//
//  ThemeModel.swift
//  Zhihu_Rx_F
//
//  Created by Fisland_Z on 2017/9/18.
//  Copyright © 2017年 Zehuihong. All rights reserved.
//

import Foundation
import HandyJSON

struct ThemeResponseModel : HandyJSON {
    var others : [ThemeModel]?
    
}

struct ThemeModel : HandyJSON {
    var colors : String?
    var thumbnail : String?
    var id : Int?
    var description : String?
    var name : String?
}
