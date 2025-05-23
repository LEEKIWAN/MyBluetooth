//
//  BluetoothManager.swift
//  MyBluetooth
//
//  Created by 이기완 on 2023/07/13.
//

import CoreBluetooth
import CoreLocation
import UIKit

class BluetoothManager: NSObject {

    static let shared = BluetoothManager()

    var centralManager: CBCentralManager!
    var devicePeripheral: CBPeripheral!

    var notifiy: ((Device) -> Void)?

    override init() {
        super.init()
    }

    func checkBluePermission() {
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    func startScanning() {
        print("Start scanning...")
        centralManager.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
    }

    func stopScanning() {
        print("Stop scanning...")
        centralManager.stopScan()
    }

    func restartScanning() {
        stopScanning()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in  // 1초 후 재스캔
            self?.startScanning()
        }
    }

    // [애플리케이션 설정창 이동 실시 메소드]
    func intentAppSettings(content: String) {
        print("Intent")
        // 앱 설정창 이동 실시
        //        let settingsAlert = UIAlertController(title: "권한 설정 알림", message: content, preferredStyle: UIAlertController.Style.alert)
        //
        //        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
        //            // [확인 버튼 클릭 이벤트 내용 정의 실시]
        //            if let url = URL(string: UIApplication.openSettingsURLString) {
        //
        //                UIApplication.shared.open(url, options: [:], completionHandler: nil)
        //            }
        //        }
        //        settingsAlert.addAction(okAction) // 버튼 클릭 이벤트 객체 연결
        //
        //        let noAction = UIAlertAction(title: "취소", style: .default) { (action) in
        //            // [취소 버튼 클릭 이벤트 내용 정의 실시]
        //            return
        //        }
        //        settingsAlert.addAction(noAction) // 버튼 클릭 이벤트 객체 연결
        //
        //        // [alert 팝업창 활성 실시]
        //        present(settingsAlert, animated: false, completion: nil)
    }
}

// [블루투스 상태 체크 실시]
extension BluetoothManager: CBCentralManagerDelegate {
    // [블루투스 상태 및 권한 부여 확인 실시]
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("[MainController > CBCentralManager : 블루투스 상태 알수 없음]")
        case .resetting:
            print("[MainController > CBCentralManager : 블루투스 서비스 리셋]")
        case .unsupported:
            print("[MainController > CBCentralManager : 기기가 블루투스를 지원하지 않습니다]")
        case .unauthorized:
            print("[MainController > CBCentralManager : 블루투스 사용 권한 확인 필요]")
            // [앱 블루투스 권한 사용 설정창 이동]
            self.intentAppSettings(content: "블루투스 사용 권한을 허용해주세요")
        case .poweredOff:
            print("[MainController > CBCentralManager : 블루투스 비활성 상태]")
        // [자동으로 시스템에서 비활성 상태 알림 및 팝업창 호출 실시]
        case .poweredOn:
            print("[MainController > CBCentralManager : 블루투스 활성 상태]")
            // [블루투스 스캔 실시]

            startScanning()
        @unknown default:
            print("[MainController > CBCentralManager : 블루투스 CASE DEFAULT]")
        }
    }

    //장치를 찾았을 때 실행되는 이벤트
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {

        guard let name = peripheral.name else { return }

        print("===============================")
        print("[MainController > 블루투스 스캔 [UUID] : \(String(peripheral.identifier.uuidString))]")
        print("[MainController > 블루투스 스캔 [RSSI] : \(String(RSSI.intValue))]")
        print("[MainController > 블루투스 스캔 [NAME] : \(String(peripheral.name ?? ""))]")

        var device = Device(uuid: peripheral.identifier.uuidString, rssi: RSSI.intValue, name: name, lastSeenDate: Date())
        
        device.distance = distance(rssi: RSSI.intValue)

        print("[MainController > 블루투스 스캔 [Distnace] : \(String(device.distance ?? 0))]")
        print("===============================")
        notifiy?(device)

    }

//    func distance(txPower: Double = -59, rssi: Int) -> Double {
//        let distnace = pow(10, ((txPower - Double(truncating: NSNumber(value: rssi))) / 20) )
//        let digit: Double = pow(10, 1)
//        let floored = floor(distnace * digit) / digit
//        return floored
//    }
    
    func distance(rssi: Int) -> Double {
        let txPower = -59.0
        let ratio = Double(rssi) / txPower
        
        var estimateDistance: Double = 0
        
        if ratio < 1.0 {
            estimateDistance = pow(ratio, 10)
        } else {
            estimateDistance = (0.89976) * pow(ratio, 7.7095) + 0.111
        }
        
        
        
        let digit: Double = pow(10, 1)
        let floored = floor(estimateDistance * digit) / digit
        
        return floored
    }
    
}
