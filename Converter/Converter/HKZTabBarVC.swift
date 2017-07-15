//
//  HKZTabBarVC.swift
//  Converter
//
//  Created by  on 17/6/11.
//  Copyright © 2017年 HK. All rights reserved.
//

import UIKit

class HKZTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = HKZBinaryVC()
        let nav1 = UINavigationController(rootViewController: vc1)
        nav1.tabBarItem = UITabBarItem(title: "二进制", image: nil, selectedImage: nil)
        
        let vc2 = HKZOctalVC()
        let nav2 = UINavigationController(rootViewController: vc2)
        nav2.tabBarItem = UITabBarItem(title: "八进制", image: nil, selectedImage: nil)
        
        let vc3 = HKZDecimalVC()
        let nav3 = UINavigationController(rootViewController: vc3)
        nav3.tabBarItem = UITabBarItem(title: "十进制", image: nil, selectedImage: nil)
        
        let vc4 = HKZHexadecimalVC()
        let nav4 = UINavigationController(rootViewController: vc4)
        nav4.tabBarItem = UITabBarItem(title: "十六进制", image: nil, selectedImage: nil)

        self.viewControllers = [nav1,nav2,nav3,nav4]

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
