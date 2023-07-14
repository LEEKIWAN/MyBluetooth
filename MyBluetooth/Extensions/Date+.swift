//
//  Date+.swift
//  MyBluetooth
//
//  Created by 이기완 on 2023/07/14.
//

import UIKit

extension Date {

    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        
        formatter.dateTimeStyle = .named
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
