//
//  ViewController.swift
//  MyBluetooth
//
//  Created by 이기완 on 2023/07/13.
//

import UIKit


class BluetoothListViewController: UIViewController {
    
    @IBOutlet weak var indicatorView: NVActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    let manager = BluetoothManager.shared
    var devices: [Device] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        bind()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        manager.notifiy = { [unowned self] device in
            var device = device
            
            let isRegistered = RegisteredDeviceManager.shared.isRegistered(device)
            device.isRegistered = isRegistered
            RegisteredDeviceManager.shared.update(device)
            
            updateDevice(device)
        }
        
    }
    
    func attribute() {
        tableView.register(UINib(nibName: "DeviceTableViewCell", bundle: .main), forCellReuseIdentifier: "DeviceTableViewCell")
        
        indicatorView.color = .black700
        indicatorView.type = .ballScaleRippleMultiple
        indicatorView.startAnimating()
        manager.checkBluePermission()
        
    }
    
    func bind() {
    
    }
    
    func updateDevice(_ device: Device) {
        for i in 0 ..< devices.count {
            if devices[i].name == device.name {
                updateTableViewCell(device, indexPath: IndexPath(row: i, section: 0))
                return
            }
        }
        
        appendTableViewCell(device)
    }
    
    
    func appendTableViewCell(_ device: Device) {
        devices.append(device)
        tableView.insertRows(at: [IndexPath(row: devices.count - 1, section: 0)], with: .automatic)
    }

    
    func updateTableViewCell(_ device: Device, indexPath: IndexPath) {
        devices[indexPath.row].lastSeenDate = device.lastSeenDate
        
        if let visibleRows = tableView.indexPathsForVisibleRows {
            for visibleRow in visibleRows {
                if visibleRow == indexPath {
                    let cell = tableView.cellForRow(at: indexPath) as? DeviceTableViewCell
                    cell?.device = device
                    
                    return
                }
            }
        }
    }
    
    
}



extension BluetoothListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceTableViewCell", for: indexPath) as! DeviceTableViewCell
        cell.delegate = self
        
        cell.device = devices[indexPath.row]
    
        return cell
        
    }
}

extension BluetoothListViewController: DeviceTableViewCellDelegate {
    func deviceTableViewCell(_ view: DeviceTableViewCell, device: Device, isFavorited: Bool) {
        for i in 0 ..< devices.count {
            if device.name == devices[i].name {
                devices[i].isRegistered.toggle()
                if devices[i].isRegistered {
                    RegisteredDeviceManager.shared.append(device)
                } else {
                    RegisteredDeviceManager.shared.remove(device)
                }
                
                break
            }
        }
        tableView.reloadData()
    }
    
}

