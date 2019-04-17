//
//  Navigator.swift
//  NavigatorDemo
//
//  Created by weiwei.li on 2019/4/17.
//  Copyright © 2019 dd01.leo. All rights reserved.
//

import Foundation
import UIKit

open class Navigator: NavigatorType {
    static let shared = Navigator()
    private var viewControllerFactories = [URLPattern: ViewControllerFactory]()
//    private var handlerFactories = [URLPattern: URLOpenHandlerFactory]()
    
    private init() { }
    
    public func register(_ pattern: URLPattern, _ factory: @escaping ViewControllerFactory) {
        viewControllerFactories[pattern] = factory
    }

    func viewController(for url: URLPattern, params: NavigatorParams? = nil) -> UIViewController? {
        let urlArr = Array(viewControllerFactories.keys)
        if urlArr.contains(url) == false {
            return nil
        }
        guard let factory = viewControllerFactories[url] else {
            return nil
        }
        return factory(url, params)
    }
    
//    public func handle(_ pattern: URLPattern, _ factory: @escaping URLOpenHandlerFactory) {
//        handlerFactories[pattern] = factory
//    }

//    func handler(for url: URLPattern, params: NavigatorParams? = nil) -> Bool {
//        let urlArr = Array(handlerFactories.keys)
//        if urlArr.contains(url) == false {
//            return false
//        }
//        guard let factory = handlerFactories[url] else {
//            return false
//        }
//        return factory(url, params)
//    }
    
}
