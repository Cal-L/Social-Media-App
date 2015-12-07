//
//  OutgoingMessageCellController.swift
//  comblie
//
//  Created by Cal on 10/25/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class OutgoingMessageCellController: UITableViewCell {

    @IBOutlet weak var messageBackground: UIView!
    @IBOutlet weak var message: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.messageBackground.layer.cornerRadius = CGFloat(13)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
