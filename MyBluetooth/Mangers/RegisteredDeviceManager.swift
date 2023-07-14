//
//  ScannedDeviceManager.swift
//  MyBluetooth
//
//  Created by 이기완 on 2023/07/13.
//

import UIKit
import SwiftyUserDefaults

class RegisteredDeviceManager {
    
    var devices: [Device] = Defaults.scannedDevices
    
    static let shared = RegisteredDeviceManager()
    
    
    func append(_ device: Device) {
        guard !devices.contains(where: { $0.name == device.name }) else { return }
        devices.append(device)
        
        Defaults.scannedDevices = devices
    }
    
    func remove(_ device: Device) {
        devices.removeAll { $0.name == device.name }
        
        Defaults.scannedDevices = devices
    }
    
    func update(_ device: Device) {
        for i in 0 ..< devices.count {
            if device.name == devices[i].name {
                devices[i] = device
            }
        }
        
        Defaults.scannedDevices = devices        
    }
    
    func isRegistered(_ device: Device) -> Bool {
        return devices.contains { $0.name == device.name }
    }
}
