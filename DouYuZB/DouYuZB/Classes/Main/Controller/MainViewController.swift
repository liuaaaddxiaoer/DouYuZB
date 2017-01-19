//
//  MainViewController.swift
//  DouYuZB
//
//  Created by 刘小二 on 2017/1/11.
//  Copyright © 2017年 刘小二. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.isTranslucent = false
        
        addChildViewController("Home")
        addChildViewController("Live")
        addChildViewController("Follow")
        addChildViewController("Profile")
    }

    private  func addChildViewController(_ storyName: String) {
        let childVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        addChildViewController(childVC);
    }

}
