//
//  ViewController.swift
//  NavigatorDemo
//
//  Created by weiwei.li on 2019/4/17.
//  Copyright © 2019 dd01.leo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    @IBAction func pushAction(_ sender: Any) {
        
        Navigator.shared.push(kNavigatorSecondVC, params: ["name": "lisi"]) { (value) in
            print("接收到上级回调传值")
            print(value)
        }
        
    }
    
    @IBAction func presentAction(_ sender: Any) {
       let vc = Navigator.shared.present(kNavigatorThirdVC, params: ["name": "lisi", "age": 12], isNeedPresent: false) { (value) in
            print("接收到上级回调传值")
            print(value)
        }
        
        present(vc ?? UIViewController(), animated: true, completion: nil)
    }
    
    @IBAction func alertAction(_ sender: Any) {        
        Navigator.shared.action(kShowAlert, params: ["vc": self, "callBack": { (str : String) in
                print(str)
            }])
    }
}

