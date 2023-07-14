//
//  RegisteredDeviceTableViewCell.swift
//  MyBluetooth
//
//  Created by 이기완 on 2023/07/14.
//

import UIKit

class RegisteredDeviceTableViewCell: UITableViewCell {
    weak var delegate: DeviceTableViewCellDelegate?
        
    var device: Device? {
        didSet {
            updateUI()
        }
    }
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastSeenDateLabel: UILabel!
    @IBOutlet weak var deviceImageView: UIImageView!
        
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
        
        lastSeenDateLabel.text = device.lastSeenDate.timeAgoDisplay()
        deviceImageView.image = UIImage(systemName: "laptopcomputer")
        
        
    }
    
    
}
