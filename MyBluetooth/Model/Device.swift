//
//  Device.swift
//  MyBluetooth
//
//  Created by 이기완 on 2023/07/13.
//

import UIKit
import SwiftyUserDefaults

struct Device: Codable, DefaultsSerializable {
    var isRegistered = false
    let uuid: String
    let rssi: Int
    var name: String
    var lastSeenDate: Date
    
    var distance: Double?
}
