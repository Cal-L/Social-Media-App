//
//  IncomingMessageCellController.swift
//  comblie
//
//  Created by Cal on 10/25/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class IncomingMessageCellController: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var messageBackground: UIView!
    @IBOutlet weak var message: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.profileImage.layer.cornerRadius = CGFloat(self.profileImage.frame.height/2)
        self.messageBackground.layer.cornerRadius = CGFloat(13)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
