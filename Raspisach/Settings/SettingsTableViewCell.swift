//
//  SettingsTableViewCell.swift
//  Raspisach
//
//  Created by Евгений Фомин on 11.05.2018.
//  Copyright © 2018 Евгений Фомин. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var settingLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
