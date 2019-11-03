//
//  UserTableViewCell.swift
//  HackDuke2019
//
//  Created by codeplus on 11/2/19.
//  Copyright © 2019 luiza. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var labelContainerView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        iconImageView.layer.cornerRadius = 16
//        iconImageView.layer.masksToBounds = true
//
//        labelContainerView.layer.cornerRadius = 8
//        labelContainerView.layer.masksToBounds = true
//
//        labelContainerView.backgroundColor = .mainGreen
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(with message: Message) {
        
        iconImageView.image = UIImage(named: message.getImage())
        
        messageLabel.text = message.text
        messageLabel.textColor = .black
//
//        let dateFormatterMessage = DateFormatter()
//        dateFormatterMessage.setLocalizedDateFormatFromTemplate("hh:mm")
//        timeLabel.text = dateFormatterMessage.string(from: message.date)
//        timeLabel.textColor = .green
        
    }
}
