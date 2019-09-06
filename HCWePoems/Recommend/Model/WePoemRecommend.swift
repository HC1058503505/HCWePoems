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

class PoemRcommendBriefly: Codable, Equatable {
    var id = 0
    var idnew = ""
    var nameStr = ""
    var author = ""
    var chaodai = ""
    var cont = ""
    var tag = ""
    var langsongAuthor = ""
    var langsongAuthorPY = ""
    
    static func == (_ left: PoemRcommendBriefly, _ right: PoemRcommendBriefly) -> Bool {
        return (left.id == right.id && left.idnew == right.idnew)
    }
    
    lazy var rowContentHeight: CGFloat = {
        let poemTitleH = (nameStr as NSString).boundingRect(with: CGSize(width: UIScreen.main.bounds.width - 20.0, height: CGFloat.infinity), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)], context: nil).height
        
        let poemDyanstyAuthorH = ((chaodai + " / " + author) as NSString).boundingRect(with: CGSize(width: UIScreen.main.bounds.width - 20.0, height: CGFloat.infinity), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)], context: nil).height
        
        let poemContH = textAttributed?.boundingRect(with: CGSize(width: UIScreen.main.bounds.width - 20.0, height: CGFloat.infinity), options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil).height ?? 0
        let height = 10 + poemTitleH + 10 + poemDyanstyAuthorH + 10 +  poemContH + 10
        return height
    }()
    
    lazy var textAttributed: NSMutableAttributedString? = {
        let begin = CFAbsoluteTimeGetCurrent()
        do {
            
            guard let poemContData = cont.data(using: String.Encoding.unicode, allowLossyConversion: true) else {
                return nil
            }
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = NSTextAlignment.center
            paragraphStyle.lineSpacing = 5
            paragraphStyle.paragraphSpacing = 10
            var attributed = try NSMutableAttributedString.init(data: poemContData, options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil)
            
            let poemContStr = attributed.string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).pregReplace(pattern: "（.*?）", with: "")
                .pregReplace(pattern: "\\(.*?\\)", with: "")

            attributed = NSMutableAttributedString.init(string: poemContStr, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15.0), NSAttributedString.Key.paragraphStyle : paragraphStyle])
            let duration = CFAbsoluteTimeGetCurrent() - begin
            if duration > 1.0 {
                debugPrint(cont)
            }
            return attributed
        } catch _ {
            return nil
        }
    }()
    
    lazy var contStr: String = {
        return cont.pregReplace(pattern: "<br />", with: "\n")
                   .pregReplace(pattern: "<p>", with: "")
                   .pregReplace(pattern: "</p>", with: "")
                   .pregReplace(pattern: "（.*?）", with: "")
                   .pregReplace(pattern: "\\(.*?\\)", with: "")
    }()
}



