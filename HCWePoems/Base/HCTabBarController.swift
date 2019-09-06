//
//  HCTabBarController.swift
//  HCWePoems
//
//  Created by cgtn on 2019/9/6.
//  Copyright © 2019 cgtn. All rights reserved.
//

import UIKit

class HCTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let recommendVC = PoemRecommendsViewController()
        addChildVC(controller: recommendVC, title: "推荐", imgName: "recommand")
        
        let findMoreVC = FindMoreViewController()
        addChildVC(controller: findMoreVC, title: "发现", imgName: "poem_search")
        
        let meVC = MeViewController()
        addChildVC(controller: meVC, title: "我", imgName: "me")
    }
    

    func addChildVC(controller: UIViewController, title: String, imgName: String) {
        let meNav = HCNavigationController(rootViewController: controller)
        controller.title = title
        controller.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: UIControl.State.selected)
        controller.tabBarItem.image = UIImage(named: imgName)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        controller.tabBarItem.selectedImage = UIImage(named: imgName + "_selected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        addChild(meNav)
    }

}
