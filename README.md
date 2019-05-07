# Navigator

实现路由跳转，完成`push`和`present`操作, 轻松解决耦合，复用跳转逻辑代码。

#### 1.register

```swift
let kNavigatorSecondVC = "navigator://secondVC"
enum NavigatorAction {
    static func initialize() {
        Navigator.shared.register(kNavigatorSecondVC) { (url, params) -> UIViewController? in
            return SecondViewController()
        }
}

```

在appdelegate中完成初始化

```swift
 func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //提前注册navigator
        NavigatorAction.initialize()
        
        return true
    }
```

#### 2. push & present

```swift
 Navigator.shared.push(kNavigatorSecondVC, params: "hahahaha") { (value) in
            print("接收到上级回调传值")
            print(value)
        }
```

push函数具体参数解释：

```swift
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
        return self.pushURL(url, params: params, isNeedPush: isNeedPush,animated: animated, navigateCompletion: navigateCompletion)
    }
```

present同理，具体参见demo。

#### 3. action
注册action，方便各模块复用
```swift
  Navigator.shared.action(kShowAlert, params: ["vc": self, "callBack": { (str : String) in
                print(str)
            }])
```
参数解析：

```swift
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
```

#### 4. params & navigateCompletion

`push & present`的操作时，会对每个`viewController`通过runtime绑定一个`params`，和`navigateCompletion`。
`params`：为入参。
`navigateCompletion`：上级`viewcontroller`的闭包回调，轻松实现传值回调


