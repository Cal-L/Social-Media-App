//
//  IncomingMessageTwoCellController.swift
//  comblie
//
//  Created by Cal on 10/22/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class IncomingMessageTwoCellController: UITableViewCell {
    
    //MARK: Properties
    
    
    @IBOutlet weak var messageBackground: UIView!
    @IBOutlet weak var message: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.messageBackground.layer.cornerRadius = CGFloat(13)
        print(messageBackground.frame.height)
       self.layoutIfNeeded()
        print(messageBackground.frame.height)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected states
    }

}
