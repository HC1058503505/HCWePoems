//
//  PoemRecommendViewModel.swift
//  HCWePoems
//
//  Created by cgtn on 2019/8/29.
//  Copyright © 2019 cgtn. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class PoemRecommendViewModel {
    
    var page = PublishSubject<Int>()
    
    fileprivate let provider = MoyaProvider<WePoems>()
    
    func poemRecommendList() -> Observable<[PoemRcommendBriefly]> {
        return page.distinctUntilChanged().flatMap { (currentPage) -> Observable<[PoemRcommendBriefly]> in
            return Observable<[PoemRcommendBriefly]>.create({[weak self] (observable) -> Disposable in
                
                self?.provider.request(WePoems.recommended(page: currentPage), completion: { (result) in
                    switch result {
                    case .success(let successValue):
                        let jsonDecoder = JSONDecoder()
                        guard let recommends = try? jsonDecoder.decode(WePoemsRecommends.self, from: successValue.data) else {
                            return
                        }
                        observable.onNext(recommends.gushiwens)
                    case .failure(let error):
                        observable.onError(error)
                    }
                })
                
                return Disposables.create()
            })
        }
    }
}
