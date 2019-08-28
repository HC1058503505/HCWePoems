//
//  PoemBrieflyTableViewCell.swift
//  HCWePoems
//
//  Created by cgtn on 2019/8/28.
//  Copyright © 2019 cgtn. All rights reserved.
//

import UIKit
import SnapKit

class PoemBrieflyTableViewCell: UITableViewCell {

    
    
    lazy var poemTitleL: UILabel = {
        let titleL = UILabel()
        titleL.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        titleL.textColor = UIColor.darkText
        titleL.textAlignment = NSTextAlignment.center
        return titleL
    }()
    
    lazy var poemDyanstyAuthorL: UILabel = {
        let dynastyAuthorL = UILabel()
        dynastyAuthorL.font = UIFont.systemFont(ofSize: 15)
        dynastyAuthorL.textColor = UIColor.lightGray
        dynastyAuthorL.textAlignment = NSTextAlignment.center
        return dynastyAuthorL
    }()
    
    lazy var poemContL: UILabel = {
        let contL = UILabel()
        contL.numberOfLines = 0
        contL.textColor = UIColor.darkText
        contL.textAlignment = NSTextAlignment.center
        return contL
    }()
    
    static func poemBrieflyCell(tableView:UITableView, reuseIdentifier:String) -> PoemBrieflyTableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        if cell == nil {
            cell = PoemBrieflyTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: reuseIdentifier)
        }
        return cell as! PoemBrieflyTableViewCell
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupFunc()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func setupFunc() {
        contentView.addSubview(poemTitleL)
        contentView.addSubview(poemDyanstyAuthorL)
        contentView.addSubview(poemContL)
    }
    
    func confitureCell(poem: PoemRcommendBriefly) -> Void {
        
        poemTitleL.text = poem.nameStr
        
        
        poemDyanstyAuthorL.text = poem.chaodai + " / " + poem.author
        
        do {
            guard let poemContData = poem.cont.data(using: String.Encoding.unicode, allowLossyConversion: true) else {
                return
            }
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = NSTextAlignment.center
            paragraphStyle.lineSpacing = 5
            paragraphStyle.paragraphSpacing = 5
            var attributed = try NSMutableAttributedString.init(data: poemContData, options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil)
            
            let poemContStr = attributed.string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            
            attributed = NSMutableAttributedString.init(string: poemContStr, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18.0), NSAttributedString.Key.paragraphStyle : paragraphStyle])
            
            poemContL.attributedText = attributed
        } catch let error {
            debugPrint(error.localizedDescription)
        }
    }
    
    func cellHeight(poem: PoemRcommendBriefly) -> CGFloat {

        let poemTitleH = (poem.nameStr as NSString).boundingRect(with: CGSize(width: UIScreen.main.bounds.width - 30.0, height: CGFloat.infinity), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)], context: nil).height
        
        let poemDyanstyAuthorH = ((poem.chaodai + " / " + poem.author) as NSString).boundingRect(with: CGSize(width: UIScreen.main.bounds.width - 30.0, height: CGFloat.infinity), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)], context: nil).height
        
        var poemContH: CGFloat = 0
        do {
            guard let poemContData = poem.cont.data(using: String.Encoding.unicode, allowLossyConversion: true) else {
                return 10 + poemTitleH + 10 + poemDyanstyAuthorH + 10
            }
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = NSTextAlignment.center
            paragraphStyle.lineSpacing = 5
            paragraphStyle.paragraphSpacing = 5
            var attributed = try NSMutableAttributedString.init(data: poemContData, options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil)
            
            let poemContStr = attributed.string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            
            attributed = NSMutableAttributedString.init(string: poemContStr, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18.0), NSAttributedString.Key.paragraphStyle : paragraphStyle])
            
            poemContH = attributed.boundingRect(with: CGSize(width: UIScreen.main.bounds.width - 30.0, height: CGFloat.infinity), options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil).height

        } catch let error {
            debugPrint(error.localizedDescription)
        }
        
        return 10 + poemTitleH + 10 + poemDyanstyAuthorH + 10 +  poemContH + 10
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        poemTitleL.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.centerX.equalTo(contentView.snp.centerX)
            make.left.equalTo(contentView.snp.left).offset(15)
        }
        
        poemDyanstyAuthorL.snp.makeConstraints { (make) in
            make.top.equalTo(poemTitleL.snp.bottom).offset(10)
            make.centerX.equalTo(contentView.snp.centerX)
            make.left.equalTo(contentView.snp.left).offset(15)
        }
        
        poemContL.snp.makeConstraints { (make) in
            make.top.equalTo(poemDyanstyAuthorL.snp.bottom).offset(10)
            make.centerX.equalTo(contentView.snp.centerX)
            make.left.equalTo(contentView.snp.left).offset(15)
        }
    }
}
