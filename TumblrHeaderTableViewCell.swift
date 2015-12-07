//
//  TumblrHeaderTableViewCell.swift
//  comblie
//
//  Created by Cal on 10/23/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class TumblrHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageBackground: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.profileImageBackground.layer.cornerRadius = CGFloat(self.profileImageBackground.frame.height/2)
        self.profileImage.layer.cornerRadius = CGFloat(self.profileImage.frame.height/2)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
