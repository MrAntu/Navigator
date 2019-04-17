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
    }
}
