//
//  AppUtils.swift
//  MyBluetooth
//
//  Created by 이기완 on 2023/07/14.
//

import Foundation
import UIKit

class AppUtils {
    
    static func deviceImage(_ name: String) -> UIImage {
        
        if name.range(of: "airpod", options: .caseInsensitive) != nil || name.range(of: "buds", options: .caseInsensitive) != nil {
            
            if name.range(of: "max", options: .caseInsensitive) != nil {
                return UIImage(systemName: "airpodsmax")!
            }
            
            return UIImage(systemName: "earbuds")!
        }
        else if name.range(of: "phone", options: .caseInsensitive) != nil || name.range(of: "galaxy", options: .caseInsensitive) != nil {
            return UIImage(systemName: "apps.iphone")!
        }
        else if name.range(of: "tv", options: .caseInsensitive) != nil {
            return UIImage(systemName: "tv")!
        }
        else if name.range(of: "watch", options: .caseInsensitive) != nil {
            return UIImage(systemName: "applewatch")!
        }                
        else {
            return UIImage(systemName: "laptopcomputer")!
        }
        
    }
}
