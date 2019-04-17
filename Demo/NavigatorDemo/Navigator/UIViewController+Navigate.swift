//
//  UIViewController+Navigate.swift
//  NavigatorDemo
//
//  Created by weiwei.li on 2019/4/17.
//  Copyright © 2019 dd01.leo. All rights reserved.
//

import UIKit
extension UIViewController {
    // 嵌套结构体
    private struct NavigateAssociatedKeys {
        static var paramsKey = "DDRouterParameterKey"
        static var completeKey = "DDRouterComplete"
    }
    
    public var params: Any? {
        set {
            objc_setAssociatedObject(self, &NavigateAssociatedKeys.paramsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return objc_getAssociatedObject(self, &NavigateAssociatedKeys.paramsKey)
        }
    }
    
    /// 添加回调闭包，适用于反向传值，只能层级传递
    public var navigateCompletion: ((Any?)->())? {
        set {
            objc_setAssociatedObject(self, &NavigateAssociatedKeys.completeKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return objc_getAssociatedObject(self, &NavigateAssociatedKeys.completeKey) as? ((Any?) -> ())
        }
    }
}
