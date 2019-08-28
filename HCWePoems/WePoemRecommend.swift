//
//  WePoemRecommend.swift
//  HCWePoems
//
//  Created by cgtn on 2019/8/28.
//  Copyright © 2019 cgtn. All rights reserved.
//

import Foundation
import UIKit

class WePoemsRecommends: Codable {
    var sumPage = 0
    var currentPage = 0
    var gushiwens = [PoemRcommendBriefly]()
    
}

class PoemRcommendBriefly: Codable {
    var id = 0
    var idnew = ""
    var nameStr = ""
    var author = ""
    var chaodai = ""
    var cont = ""
    var tag = ""
    var langsongAuthor = ""
    var langsongAuthorPY = ""
}
