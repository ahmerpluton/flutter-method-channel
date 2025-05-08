// import UIKit
// import Flutter

// @UIApplicationMain
// @objc class AppDelegate: FlutterAppDelegate {
//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {
//     GeneratedPluginRegistrant.register(with: self)
//     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//   }
// }


import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var loaderView: UIView?

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "com.example.native_loader", binaryMessenger: controller.binaryMessenger)

        channel.setMethodCallHandler { [weak self] (call, result) in
            switch call.method {
            case "showLoader":
                self?.showNativeLoader()
                result(nil)
            case "hideLoader":
                self?.hideNativeLoader()
                result(nil)
            default:
                result(FlutterMethodNotImplemented)
            }
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
     }


   private func showNativeLoader() {
     

    let dimView = UIView(frame: window.bounds)
    dimView.backgroundColor = UIColor.black.withAlphaComponent(0.5)

    let spinner: UIActivityIndicatorView
    if #available(iOS 13.0, *) {
        spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .green
    } else {
        spinner = UIActivityIndicatorView(style: .whiteLarge)
        spinner.color = .green

    }

    spinner.center = dimView.center
    spinner.startAnimating()
    dimView.addSubview(spinner)

    window.addSubview(dimView)
    self.loaderView = dimView
}


    private func hideNativeLoader() {
        loaderView?.removeFromSuperview()
        loaderView = nil
    }
}
