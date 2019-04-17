//
//  ThirdViewController.swift
//  NavigatorDemo
//
//  Created by weiwei.li on 2019/4/17.
//  Copyright © 2019 dd01.leo. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("接受到的参数")
        print(params)
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func closeAction(_ sender: Any) {
        navigateCompletion?(params)
        dismiss(animated: true, completion: nil)
    }

}
