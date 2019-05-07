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
    private var handlerFactories = [URLPattern: OpenHandlerFactory]()
    
    private init() { }
    
    // 外界无需调用
    public func register(_ pattern: URLPattern, _ factory: @escaping ViewControllerFactory) {
        viewControllerFactories[pattern] = factory
    }
    
    // 外界无需调用
    public func viewController(for url: URLPattern, params: NavigatorParams? = nil) -> UIViewController? {
        let urlArr = Array(viewControllerFactories.keys)
        if urlArr.contains(url) == false {
            return nil
        }
        guard let factory = viewControllerFactories[url] else {
            return nil
        }
        return factory(url, params)
    }
    
    // 外界无需调用
    public func registerAction(_ pattern: URLPattern, _ factory: @escaping OpenHandlerFactory) {
        handlerFactories[pattern] = factory
    }
    
    // 外界无需调用
    public func actionHandle(for url: URLPattern, params: NavigatorParams? = nil) -> Bool {
        let urlArr = Array(handlerFactories.keys)
        if urlArr.contains(url) == false {
            return false
        }
        guard let factory = handlerFactories[url] else {
            return false
        }
        return factory(url, params)
    }

}
