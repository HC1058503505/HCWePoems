//
//  PoemRecommendsViewController.swift
//  HCWePoems
//
//  Created by cgtn on 2019/8/29.
//  Copyright © 2019 cgtn. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Flutter

class PoemRecommendsViewController: UIViewController {

    let tableV = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
    var guShiWens = [PoemRcommendBriefly]()
    let poemRecommendViewModel = PoemRecommendViewModel()
    let disposeBag = DisposeBag()
    var isLoading = false
    var page = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableV.frame = view.bounds
        tableV.dataSource = self
        tableV.delegate = self
        tableV.prefetchDataSource = self
        tableV.register(PoemBrieflyTableViewCell.self, forCellReuseIdentifier: "PoemBriefly")
        view.addSubview(tableV)
        
        if #available(iOS 11.0, *) {
            // 刷新类别上下跳动，是有刷新列表时估算了cell高度导致的
            tableV.estimatedRowHeight = 0
            tableV.estimatedSectionFooterHeight = 0
            tableV.estimatedSectionHeaderHeight = 0
        }
        
        
        
        poemRecommendViewModel
            .poemRecommendList()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] (recommends) in
                self?.isLoading = false
                
                self?.guShiWens.append(contentsOf: recommends)
                self?.page += 1
                self?.tableV.reloadData()
            }, onError: { (error) in
                
            }).disposed(by: disposeBag)
        
        
        tableV.rx.didScroll.subscribe(onNext: {[weak self] _ in
            guard let tableView = self?.tableV else {
                return
            }
            
            if !tableView.isDragging {
                return
            }
            
            if !(self?.isLoading ?? false) && tableView.contentOffset.y + tableView.frame.height > tableView.contentSize.height {
                let nextPage = self?.page ?? 0
                self?.isLoading = true
                // 刷新
                self?.poemRecommendViewModel.page.onNext(nextPage)
            }
        }).disposed(by: disposeBag)
        
        poemRecommendViewModel.page.onNext(page)
    }
    
    
}

extension PoemRecommendsViewController : UITableViewDataSourcePrefetching, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            _ = guShiWens[indexPath.row].textAttributed
            _ = guShiWens[indexPath.row].rowContentHeight
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guShiWens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PoemBrieflyTableViewCell.poemBrieflyCell(tableView: tableView, reuseIdentifier: "PoemBriefly")
        cell.confitureCell(poem: guShiWens[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
        return guShiWens[indexPath.row].rowContentHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let poemDeltailVC = PoemDetailViewController(poem: guShiWens[indexPath.row])
//        poemDeltailVC.hidesBottomBarWhenPushed = true
//        navigationController?.pushViewController(poemDeltailVC, animated: true)
        
        let flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
        guard let poemDetailVC = FlutterShowViewController(engine: flutterEngine, nibName: nil, bundle: nil) else {
            return
        }
        poemDetailVC.setInitialRoute("poemDetail")
        poemDetailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(poemDetailVC, animated: true)
        
        let guShiWen = guShiWens[indexPath.row]
        let detailChannel = FlutterMethodChannel(name: "houocng.flutter.io/poemd_detail", binaryMessenger: poemDetailVC)
        
        detailChannel.invokeMethod("getPoemRecommend", arguments: [
            "poemId" : guShiWen.idnew,
            "poemTitle" : guShiWen.nameStr,
            "poemCont" : guShiWen.cont,
            "author" : guShiWen.author,
            "dynasty" : guShiWen.chaodai,
        ])
    }
}
