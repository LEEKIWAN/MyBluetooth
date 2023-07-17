//
//  Coordinator.swift
//  MyBluetooth
//
//  Created by 이기완 on 2023/07/14.
//

import Foundation
import UIKit

class Coordinator: NSObject {
    enum PresentStyle {
        case push
        case modal
        case fullScreen
//        case panModal
        case root
    }
    
    static func deviceDetailViewController(ric: String, style: PresentStyle = .push) {
//        let vc = IndexDetailViewController.instantiate()
//        vc.viewModel = IndexDetailViewModel(with: ric)
//        transition(to: vc)
    }
    
    static func stockDetailViewController(ric: String, style: PresentStyle = .push) {
//        let vc = StockDetailViewController2.instantiate()
//        vc.viewModel = StockDetailViewModel(with: ric)
//        transition(to: vc, isCoverredTabbar: false)
    }
    
    static func economicEventDetailViewController(ric: String, style: PresentStyle = .push) {
//        let vc = EconomicEventsDetailViewController.instantiate()
//        vc.viewModel = EconomicEventDetailViewModel(with: ric)
//        transition(to: vc)
    }
    
    
    
    
    
    static func presentDatePickerPopupViewController(selectedDate: Date, completion: ((Date) -> Void)?) {
        
    }

    

    static func transition(to viewController: UIViewController, isCoverredTabbar: Bool = false, style: PresentStyle = .push, animated: Bool = true) {
        switch style {
        case .push:
            if let tabBarController = UIApplication.topViewController()?.tabBarController, isCoverredTabbar == true {
                tabBarController.navigationController?.pushViewController(viewController, animated: animated)
            } else {
                UIApplication.topViewController()?.navigationController?.pushViewController(viewController, animated: animated)
            }
        case .modal:
            UIApplication.topViewController()?.present(viewController, animated: animated)
        case .fullScreen:
            viewController.modalPresentationStyle = .fullScreen
            UIApplication.topViewController()?.present(viewController, animated: animated)
            
        case .root:
//            guard let window = UIApplication.shared.keyWindow else { return }

            let window = UIApplication.shared.windows.first!
            
            window.rootViewController = viewController
            window.makeKeyAndVisible()
            
            UIView.transition(with: window, duration: animated ? 0.3 : 0, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
        
        
    }
    
    
    
}
