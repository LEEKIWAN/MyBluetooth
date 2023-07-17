//
//  UIApplication+.swift
//  MyBluetooth
//
//  Created by kiwan on 2021/07/27.
//

import Foundation
import UIKit

extension UIApplication {    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
 
    func publicThemeColors() {
        // tabbar
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .layer
        
//        appearance.stackedLayoutAppearance.normal.iconColor = .white
        appearance.stackedLayoutAppearance.selected.iconColor = .white
        
//        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 10, weight: .bold)]
//        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 10, weight: .regular)]
                
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = UITabBar.appearance().standardAppearance
        
        
        
        // tableview
        
//        if #available(iOS 15.0, *) {
//            UITableView.appearance().sectionHeaderTopPadding = 0
//            UITableView.appearance().sectionFooterHeight = 0
//
//        }
//
//        KafkaRefreshDefaults.standard().headDefaultStyle = .replicatorAllen
//        KafkaRefreshDefaults.standard().themeColor = .success
//
//        //
//        UITextField.appearance().tintColor = .white700
//
//        // NVActivityIndicatorView
//        NVActivityIndicatorView.DEFAULT_TYPE = .lineScale
    }
}


extension UIApplication {
    
    var keyWindow: UIWindow? {
        // Get connected scenes
        return UIApplication.shared.connectedScenes
            // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
            // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
            // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
            // Finally, keep only the key window
            .first(where: \.isKeyWindow)
        
    }
    
}



extension UIApplication {
    private static let notificationSettingsURLString: String? = {
        if #available(iOS 16, *) {
            return UIApplication.openNotificationSettingsURLString
        }
        
//        if #available(iOS 15.4, *) {
//            return UIApplicationOpenNotificationSettingsURLString
//        }
        
        if #available(iOS 8.0, *) {
            return UIApplication.openSettingsURLString
        }
        
        return nil
    }()
    
    private static let appNotificationSettingsURL = URL(string: notificationSettingsURLString ?? "")
    
    func openAppNotificationSettings() {
        guard let url = UIApplication.appNotificationSettingsURL, canOpenURL(url) else { return }
        
        UIApplication.shared.open(url)
//        return await self.open(url)
    }
}

