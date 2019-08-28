//
//  WePoemsProvider.swift
//  HCWePoems
//
//  Created by cgtn on 2019/8/27.
//  Copyright © 2019 cgtn. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class WePoemsProvider {
    let provider = MoyaProvider<WePoems>()

    
    func recommendedList(page: Int, success:@escaping (WePoemsRecommends) -> Void, failure:@escaping (Error) -> Void)  {
        
        provider.request(WePoems.recommended(page: page)) { (result) in
            switch result {
            case .success(let response):
                let jsonDecoder = JSONDecoder()
                guard let recommends = try? jsonDecoder.decode(WePoemsRecommends.self, from: response.data) else {
                    return
                }
                success(recommends)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
}
