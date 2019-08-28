//
//  ViewController.swift
//  HCWePoems
//
//  Created by cgtn on 2019/8/27.
//  Copyright © 2019 cgtn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let tableV = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
    var guShiWens = [PoemRcommendBriefly]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableV.frame = view.bounds
        tableV.dataSource = self
        tableV.delegate = self
        view.addSubview(tableV)
        
        let peomsProvider = WePoemsProvider()
        peomsProvider.recommendedList(page: 0, success: {[weak self] (recommends) in
            self?.guShiWens.append(contentsOf: recommends.gushiwens)
            self?.tableV.reloadData()
        }) { (error) in
            debugPrint(error.localizedDescription)
        }
        
    }


}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guShiWens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PoemBrieflyTableViewCell.poemBrieflyCell(tableView: tableView, reuseIdentifier: "PoemBriefly")
        cell.confitureCell(poem: guShiWens[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = PoemBrieflyTableViewCell.poemBrieflyCell(tableView: tableView, reuseIdentifier: "PoemBriefly")
        
        return cell.cellHeight(poem: guShiWens[indexPath.row])
    }
    
}
