//
//  PoemDetailViewController.swift
//  HCWePoems
//
//  Created by cgtn on 2019/9/6.
//  Copyright © 2019 cgtn. All rights reserved.
//

import UIKit

class PoemDetailViewController: UIViewController {
    
    var poemModel = PoemRcommendBriefly()

    init(poem: PoemRcommendBriefly, nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        poemModel = poem
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        title = poemModel.nameStr
    
//        let backBtn = UIButton(type: UIButton.ButtonType.custom)
//        backBtn.setImage(UIImage(named: "back_icon"), for: UIControl.State.normal)
//        backBtn.addTarget(self, action: #selector(PoemDetailViewController.backAction), for: UIControl.Event.touchUpInside)
//        let backItem = UIBarButtonItem(customView: backBtn)
//        navigationItem.leftBarButtonItem = backItem
    }
    

//    @objc func backAction() {
//        navigationController?.popViewController(animated: true)
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
