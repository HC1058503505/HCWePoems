//
//  WePoems.swift
//  HCWePoems
//
//  Created by cgtn on 2019/8/27.
//  Copyright © 2019 cgtn. All rights reserved.
//

import Foundation
import Moya
enum WePoems {
    /// 1、推荐列表
    case recommended(page: Int)
    /// 2、诗词详情
    case deatil(poemId: String)
    /// 3、名句
    case mingju(poemId: String)
    /// 4、诗人信息
    case author(authorId: String)
    
    /// 5、标签（写景、抒情）
    /// 6、诗集（唐诗三百首）
    /// 7、朝代
    /// 8、诗人
    case tagPoems(page: Int, tagType: String, tagStr: String)
    
    /// 9、搜索
    case search(key: String)
}


extension WePoems: TargetType {
    var baseURL: URL {
        return URL(string: "https://app.gushiwen.org")!
    }
    
    var path: String {
        switch self {
        case .recommended:
            return "api/Default.aspx"
        case .deatil:
            return "api/shiwen/shiwenv.aspx"
        case .mingju:
            return "api/mingju/juv2.aspx"
        case .author:
            return "api/author/author2.aspx"
        case .tagPoems:
            return "api/shiwen/Default.aspx"
        case .search:
            return "api/ajaxSearch3.aspx"
        }
    }
    

    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case .recommended(let page):
            return .requestParameters(parameters: ["token" : "gswapi", "pwd" : "", "id" : "", "page" : page], encoding: URLEncoding.default)
        case .deatil(let poemId):
            return .requestParameters(parameters: ["token" : "gswapi", "id" : poemId], encoding: URLEncoding.default)
        case .mingju(let poemId):
            return .requestParameters(parameters: ["token" : "gswapi", "id" : poemId], encoding: URLEncoding.default)
        case .author(let authorId):
            return .requestParameters(parameters: ["token" : "gswapi", "id" : authorId], encoding: URLEncoding.default)
        case .tagPoems(let page, let tagType, let tagStr):
            return .requestParameters(parameters: ["token" : "gswapi", "page" : page, tagType : tagStr], encoding: URLEncoding.default)
        case .search(let key):
            return .requestParameters(parameters: ["token" : "gswapi" , "valuekey" : key], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
