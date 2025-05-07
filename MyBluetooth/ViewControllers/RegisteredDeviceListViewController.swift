//
//  RegisteredDeviceListViewController.swift
//  MyBluetooth
//
//  Created by 이기완 on 2023/07/14.
//

import UIKit

class RegisteredDeviceListViewController: UIViewController {
  
    @IBOutlet weak var tableView: UITableView!
    
    let manager = BluetoothManager.shared
    var devices: [Device] = RegisteredDeviceManager.shared.devices

    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadDeviceList()
        
        manager.notifiy = { [unowned self] device in
            updateDevice(device)
        }
        
    }
    
    func attribute() {
        tableView.register(UINib(nibName: "RegisteredDeviceTableViewCell", bundle: .main), forCellReuseIdentifier: "RegisteredDeviceTableViewCell")
    }
    
    func bind() {
        
    }
    
    
    func reloadDeviceList() {
        devices = RegisteredDeviceManager.shared.devices
        tableView.reloadData()
    }
    
    
    func updateDevice(_ device: Device) {
        for i in 0 ..< devices.count {
            if devices[i].name == device.name {
                RegisteredDeviceManager.shared.update(device)
                updateTableViewCell(device, indexPath: IndexPath(row: i, section: 0))
                return
            }
        }
    }
    
    
    func updateTableViewCell(_ device: Device, indexPath: IndexPath) {
        devices[indexPath.row].lastSeenDate = device.lastSeenDate
        
        if let visibleRows = tableView.indexPathsForVisibleRows {
            for visibleRow in visibleRows {
                if visibleRow == indexPath {
                    let cell = tableView.cellForRow(at: indexPath) as? RegisteredDeviceTableViewCell
                    cell?.device = device
                    return
                }
            }
        }
    }
    
    
}


extension RegisteredDeviceListViewController: UITableViewDataSource, UITableViewDelegate {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegisteredDeviceTableViewCell", for: indexPath) as! RegisteredDeviceTableViewCell
        
        cell.device = devices[indexPath.row]
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DeviceDetailViewController.instantiate()
        vc.device = devices[indexPath.row]
        tabBarController?.navigationController?.pushViewController(vc, animated: true)
    }
}

//extension RegisteredDeviceListViewController: DeviceTableViewCellDelegate {
//    func deviceTableViewCell(_ view: DeviceTableViewCell, device: Device, isFavorited: Bool) {
//    }
//    
//}


