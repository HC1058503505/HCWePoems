//
//  HCNavigationController.swift
//  HCWePoems
//
//  Created by cgtn on 2019/9/6.
//  Copyright © 2019 cgtn. All rights reserved.
//

import UIKit

class HCNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        delegate = self

        interactivePopGestureRecognizer?.delegate = self
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        return super.popViewController(animated: animated)
    }
}

extension HCNavigationController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if navigationController.viewControllers.count <= 1 {
            return
        }
        
        let backBtn = UIButton(type: UIButton.ButtonType.custom)
        backBtn.setImage(UIImage(named: "back_icon"), for: UIControl.State.normal)
        backBtn.addTarget(self, action: #selector(HCNavigationController.popViewController(animated:)), for: UIControl.Event.touchUpInside)
        let backItem = UIBarButtonItem(customView: backBtn)
        viewController.navigationItem.leftBarButtonItem = backItem
    }
}


extension HCNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
