//
//  NavigatorType.swift
//  NavigatorDemo
//
//  Created by weiwei.li on 2019/4/17.
//  Copyright © 2019 dd01.leo. All rights reserved.
//

import Foundation
import UIKit

public typealias URLPattern = String
public typealias NavigatorParams = [String: Any]
public typealias ViewControllerFactory = (_ url: URLPattern, _ params: NavigatorParams?) -> UIViewController?
public typealias OpenHandlerFactory = (_ url: URLPattern, _ params: NavigatorParams?) -> Bool
//用于上级回调
public typealias NavigateCompletion = (Any?)->()

public protocol NavigatorType {

    func register(_ pattern: URLPattern, _ factory: @escaping ViewControllerFactory)
    
    func viewController(for url: URLPattern, params: NavigatorParams?) -> UIViewController?

    func registerAction(_ pattern: URLPattern, _ factory: @escaping OpenHandlerFactory)

    func actionHandle(for url: URLPattern, params: NavigatorParams?) -> Bool

}

//MARK -- fileprivate
extension NavigatorType {
    @discardableResult
    fileprivate func pushURL(_ url: URLPattern, params: NavigatorParams? = nil, isNeedPush: Bool = true, animated: Bool = true, navigateCompletion: NavigateCompletion? = nil) -> UIViewController? {
        guard let viewController = self.viewController(for: url, params: params)  else {
            return nil
        }
        return pushViewController(viewController, params: params, isNeedPush: isNeedPush,animated: animated, navigateCompletion: navigateCompletion)
    }
    
    @discardableResult
    fileprivate func pushViewController(_ viewController: UIViewController, params: NavigatorParams? = nil, isNeedPush: Bool = true,  animated: Bool, navigateCompletion: NavigateCompletion? = nil) -> UIViewController? {
        // 获取最上层的VC
        guard let topVc = UIViewController.navigateTopViewController else {
            return nil
        }
        if topVc.navigationController == nil {
            return nil
        }
        
        viewController.navigateCompletion = navigateCompletion
        viewController.params = params
        if isNeedPush {
            topVc.navigationController?.pushViewController(viewController, animated: animated)
        }
        return viewController
    }
    
    @discardableResult
    fileprivate func presentURL(_ url: URLPattern, params: NavigatorParams? = nil, isNeedPresent: Bool = true, animated: Bool, completion: (() -> Void)?, navigateCompletion: NavigateCompletion? = nil) -> UIViewController? {
        guard let viewController = self.viewController(for: url, params: nil) else {
            return nil
        }
        return presentViewController(viewController,params: params, isNeedPresent: isNeedPresent,animated: animated, completion: completion, navigateCompletion: navigateCompletion)
    }
    
    @discardableResult
    fileprivate func presentViewController(_ viewController: UIViewController, params: NavigatorParams? = nil, isNeedPresent: Bool = true,  animated: Bool, completion: (() -> Void)?, navigateCompletion: NavigateCompletion? = nil) -> UIViewController? {
        guard let topVC = UIViewController.navigateTopViewController else {
            return nil
        }
        viewController.navigateCompletion = navigateCompletion
        viewController.params = params
        if isNeedPresent {
            topVC.present(viewController, animated: animated, completion: completion)
        }
        return viewController
    }

}

//MARK -- 外部调用方法
extension NavigatorType {
    /// push
    ///
    /// - Parameters:
    ///   - url: url
    ///   - params: 传的参数
    ///   - isNeedPush: 是否需要navigtor去执行push操作
    ///   - animated: 是否需要动画
    ///   - navigateCompletion: 上级闭包回调
    /// - Returns: UIViewController
    @discardableResult
    public func push(_ url: URLPattern, params: NavigatorParams? = nil, isNeedPush: Bool = true, animated: Bool = true, navigateCompletion: NavigateCompletion? = nil) -> UIViewController? {
        return pushURL(url, params: params, isNeedPush: isNeedPush,animated: animated, navigateCompletion: navigateCompletion)
    }

    /// present
    ///
    /// - Parameters:
    ///   - url: url
    ///   - params: 参数
    ///   - isNeedPresent: 是否需要navigtor去执行present操作
    ///   - animated: 是否需要动画
    ///   - completion: present完成闭包回调
    ///   - navigateCompletion: 上级闭包回调
    /// - Returns: UIViewController
    @discardableResult
    public func present(_ url: URLPattern, params: NavigatorParams? = nil, isNeedPresent: Bool = true, animated: Bool = true, completion: (() -> Void)? = nil, navigateCompletion: NavigateCompletion? = nil) -> UIViewController? {
        return presentURL(url, params: params, isNeedPresent: isNeedPresent, animated: animated, completion: completion, navigateCompletion: navigateCompletion)
    }
    
    
    /// action
    ///
    /// - Parameters:
    ///   - url: url
    ///   - params: 参数
    /// - Returns: action是否成功
    @discardableResult
    public func action(_ url: URLPattern, params: NavigatorParams? = nil) -> Bool {
        return actionHandle(for: url, params: params)
    }

}
