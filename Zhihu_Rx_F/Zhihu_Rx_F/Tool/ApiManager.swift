//
//  ApiManager.swift
//  Zhihu_Rx_F
//
//  Created by Fisland_Z on 2017/9/18.
//  Copyright © 2017年 Zehuihong. All rights reserved.
//

import UIKit
import Moya

enum ApiManager{
    case getLauchImg
    case getNewsList
    case getMoreNews(String)
    case getThemeList
    case getThemeDesc(Int)
    case getNewsDesc(Int)
}
extension ApiManager : TargetType{
    /// The target's base `URL`.
    var baseURL: URL {
        return URL.init(string: "http://news-at.zhihu.com/api/")!
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .getLauchImg:
            return "7/prefetch-launch-images/750*1142"
        case .getNewsList:
            return "4/news/latest"
        case .getMoreNews(let date):
            return "4/news/before/" + date
        case .getThemeList:
            return "4/themes"
        case .getThemeDesc(let id):
            return "4/theme/\(id)"
        case .getNewsDesc(let id):
            return "4/news/\(id)"
        }
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        return .get
    }
    
    /// The parameters to be encoded in the request.
    var parameters: [String: Any]? {
        return nil
    }
    
    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    /// Provides stub data for use in testing.
    var sampleData: Data {
        
        return "".data(using: String.Encoding.utf8)!
    }
    
    /// The type of HTTP task to be performed.
    var task: Task {
        return .request
    }
    
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    var validate: Bool {
        return false
    }
}
