//
//  ToModel+Extension.swift
//  Zhihu_Rx_F
//
//  Created by Fisland_Z on 2017/9/18.
//  Copyright © 2017年 Zehuihong. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import HandyJSON

extension ObservableType where E == Response{
    func mapModel<T:HandyJSON>(_ type:T.Type) -> Observable<T> {
        return flatMap{ response in
            return Observable.just(response.mapModel(T.self))
        }
    }
}

extension Response{
    func mapModel<T:HandyJSON>(_ type:T.Type) -> T {
        let jsonString = String.init(data: data, encoding: .utf8)
        return JSONDeserializer<T>.deserializeFrom(json: jsonString)!
    }
}


