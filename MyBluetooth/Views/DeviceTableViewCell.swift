//
//  DeviceTableViewCell.swift
//  MyBluetooth
//
//  Created by 이기완 on 2023/07/13.
//

import UIKit

protocol DeviceTableViewCellDelegate: NSObjectProtocol {
    func deviceTableViewCell(_ view: DeviceTableViewCell, device: Device, isFavorited: Bool)
}

class DeviceTableViewCell: UITableViewCell {

    weak var delegate: DeviceTableViewCellDelegate?
    
    let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d h:mm:ss a"
        return formatter
    }()
    
    var device: Device? {
        didSet {
            updateUI()
        }
    }
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastSeenDateLabel: UILabel!
    @IBOutlet weak var deviceImageView: UIImageView!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        containerView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func updateUI() {
        guard let device = device else { return }
        
        nameLabel.text = device.name
        
        lastSeenDateLabel.text = dateFormatter.string(from: device.lastSeenDate)
        
        
        deviceImageView.image = AppUtils.deviceImage(device.name)
        
        favoriteButton.isSelected = device.isRegistered
        
    }
    
    
    @IBAction func onFavoriteTapped(_ sender: UIButton) {
        guard let device = device else { return }
        
        delegate?.deviceTableViewCell(self, device: device, isFavorited: device.isRegistered)
    }
}
