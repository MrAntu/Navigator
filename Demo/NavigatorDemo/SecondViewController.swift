//
//  SecondViewController.swift
//  NavigatorDemo
//
//  Created by weiwei.li on 2019/4/17.
//  Copyright © 2019 dd01.leo. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("接受到的参数")
        print(params)
        // Do any additional setup after loading the view.
    }


    @IBAction func completionAction(_ sender: Any) {
        navigateCompletion?("我给你传了一个字符串")
    }
    
}
