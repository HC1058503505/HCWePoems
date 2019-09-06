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

    fileprivate var poemBriefly = PoemRcommendBriefly()
    
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
        selectionStyle = .none
        contentView.addSubview(poemTitleL)
        contentView.addSubview(poemDyanstyAuthorL)
        contentView.addSubview(poemContL)
    }
    
    func confitureCell(poem: PoemRcommendBriefly) -> Void {
        if poemBriefly == poem {
            debugPrint("confitureCell same data")
            return
        }
        
        poemTitleL.text = poem.nameStr
        
        poemDyanstyAuthorL.text = poem.chaodai + " / " + poem.author
        
        poemContL.attributedText = poem.textAttributed
        
        poemBriefly = poem
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        poemTitleL.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.centerX.equalTo(contentView.snp.centerX)
            make.left.equalTo(contentView.snp.left).offset(10)
        }
        
        poemDyanstyAuthorL.snp.makeConstraints { (make) in
            make.top.equalTo(poemTitleL.snp.bottom).offset(10)
            make.centerX.equalTo(contentView.snp.centerX)
            make.left.equalTo(contentView.snp.left).offset(10)
        }
        
        poemContL.snp.makeConstraints { (make) in
            make.top.equalTo(poemDyanstyAuthorL.snp.bottom).offset(10)
            make.centerX.equalTo(contentView.snp.centerX)
            make.left.equalTo(contentView.snp.left).offset(10)
        }
    }
}
