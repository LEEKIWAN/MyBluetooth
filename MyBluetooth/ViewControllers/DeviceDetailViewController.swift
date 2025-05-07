//
//  DeviceDetailViewController.swift
//  MyBluetooth
//
//  Created by 이기완 on 2023/07/14.
//

import UIKit

class DeviceDetailViewController: UIViewController {
    
    
    
    
    let manager = BluetoothManager.shared
    
    var device: Device?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastSeenDateLabel: UILabel!
    
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var phoneImageView: UIImageView!
    @IBOutlet weak var indicatorView: NVActivityIndicatorView!
    @IBOutlet weak var circularSlider: MTCircularSlider!
    
    @IBOutlet weak var estimateDistanceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        bind()
        updateUI()
        initializeCircleIndicatorView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        manager.notifiy = { [unowned self] device in
            if self.device?.name == device.name {
                self.device = device
                
                updateUI()
                updateCircleIndicatorView(device.rssi)
            }
        }
        
    }
    
    func attribute() {
        indicatorView.color = .black700
        indicatorView.type = .ballScaleMultiple
        indicatorView.startAnimating()
                    
        phoneImageView.layer.cornerRadius = phoneImageView.frame.height / 2
        
    }
    
    func bind() {
        
    }
    
    func updateUI() {
        guard let device = device else { return }
        
        nameLabel.text = device.name
        lastSeenDateLabel.text = device.lastSeenDate.formatted(date: .abbreviated, time: .standard)
        
    }
    
    func initializeCircleIndicatorView() {
        statusLabel.text = "아직 신호가 없습니다"
        descriptionLabel.text = "신호를 받을 때까지 기다려보세요"
    }
    
    func updateCircleIndicatorView(_ rssi: Int) {
        if rssi > -50 {
            statusLabel.text = "가까이 있습니다"
            descriptionLabel.text = "근처에서 찾아보세요"
            circularSlider.minTrackTint = .success
            estimateDistanceLabel.textColor = .success
        } else if rssi > -70 && rssi <= -50 {
            statusLabel.text = "여기 어딘가에 있습니다."
            descriptionLabel.text = "인접한 지역을 찾아보세요"
            circularSlider.minTrackTint = .good
            estimateDistanceLabel.textColor = .good
        } else if rssi > -90 && rssi <= -70 {
            statusLabel.text = "멀리 있습니다."
            descriptionLabel.text = "주변을 걸어다녀보세요"
            circularSlider.minTrackTint = .error
            estimateDistanceLabel.textColor = .error
        } else if rssi < -90 {
            statusLabel.text = "신호가 약합니다."
            descriptionLabel.text = "걸어다녀보세요"
            circularSlider.minTrackTint = .red
            estimateDistanceLabel.textColor = .red
        }
        
        
        estimateDistanceLabel.text = "Estimate Distance: \(BluetoothManager.shared.distance(rssi: rssi))m"
        circularSlider.value = 1
        
    }
    
    
    
    
    @IBAction func onBackTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
