//
//  Extension+UIApplication.swift
//  TheWeather
//
//  Created by Иван Луганцов on 23.05.2023.
//

import UIKit

extension UIApplication {

    class func setRootViewController(_ vc: UIViewController) {
        if let nav = UIApplication.shared.currentUIWindow?.rootViewController as? UINavigationController {
            nav.viewControllers = [vc]
        } else {
            UIApplication.shared.currentUIWindow?.rootViewController = UINavigationController(rootViewController: vc)
            UIApplication.shared.currentUIWindow?.makeKeyAndVisible()
        }
    }

    var currentUIWindow: UIWindow? {
        let connectedScenes = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }

        let window = connectedScenes.first?
            .windows
            .first { $0.isKeyWindow }

        return window
    }
}
