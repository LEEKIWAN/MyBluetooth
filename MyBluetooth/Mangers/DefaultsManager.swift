//
//  DefaultsManager.swift
//  MyBluetooth
//
//  Created by kiwan on 2023/07/13.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    var scannedDevices: DefaultsKey<[Device]> { .init("scannedDevices", defaultValue: []) }
    var registeredDevices: DefaultsKey<[Device]> { .init("registeredDevices", defaultValue: []) }   
}
