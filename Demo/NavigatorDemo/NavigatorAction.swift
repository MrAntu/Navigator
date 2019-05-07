//
//  NavigatorAction.swift
//  NavigatorDemo
//
//  Created by weiwei.li on 2019/4/17.
//  Copyright © 2019 dd01.leo. All rights reserved.
//

import Foundation
import UIKit

let kNavigatorSecondVC = "navigator://secondVC"
let kNavigatorThirdVC = "navigator://thirdVC"

let kShowAlert = "navigator://showAlert"

enum NavigatorAction {
    static func initialize() {
        Navigator.shared.register(kNavigatorSecondVC) { (url, params) -> UIViewController? in
            return SecondViewController()
        }
        
        Navigator.shared.register(kNavigatorThirdVC) { (url, params) -> UIViewController? in
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ThirdViewController") as? ThirdViewController {
                return vc
            }
            return nil
        }
        
        Navigator.shared.registerAction(kShowAlert) { (url, params) -> Bool in
            
            guard let params = params,
             let vc = params["vc"] as? UIViewController,
                let callBack = params["callBack"] as? ((String) -> Void) else {
                return false
            }
            
            //弹窗提示
            let alertVC = UIAlertController(title: "温馨提示", message: "哈哈哈", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "取消", style: .default) { (action) in
            }
            let actionCommit = UIAlertAction(title: "去设置", style: .default) { (action) in
               callBack("我要回调啦")
            }
            alertVC.addAction(cancelAction)
            alertVC.addAction(actionCommit)
            
            vc.present(alertVC, animated: true, completion: nil)
            
            return true
        }
    }
}
