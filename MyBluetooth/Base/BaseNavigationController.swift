//
//  BaseNavigationController.swift
//  MyBluetooth
//
//  Created by kiwan on 5/7/25.
//

import Foundation
import UIKit

class BaseNavigationController: UINavigationController, UIGestureRecognizerDelegate {

    /// Custom back buttons disable the interactive pop animation
    /// To enable it back we set the recognizer to `self`
    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        guard viewControllers.count > 4 else { return }
        
        for i in stride(from: viewControllers.count - 1, through: 0, by: -1)  {
            let vcType = type(of: viewControllers[i]).description()
                        
            for j in 0 ..< viewControllers.count {
                let innerVCType = type(of: viewControllers[j]).description()
                    
                if vcType == innerVCType {
                    viewControllers.remove(at: j)
                    return
                }
            }
            
        }
        
    }
}
