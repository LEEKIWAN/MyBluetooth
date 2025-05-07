//
//  NoAuthorizedView.swift
//  MyBluetooth
//
//  Created by kiwan on 5/7/25.
//

import Foundation
import UIKit

class NoAuthorizedView: UIView {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var settingButton: UIButton!
    
    
    
    func setText(_ text: String) {
        descriptionLabel.text = text
        
    }
    
    @IBAction func onSettingTapped(_ sender: UIButton) {
        
        
    }
}
