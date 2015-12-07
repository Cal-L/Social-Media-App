//
//  CommentCellController.swift
//  comblie
//
//  Created by Cal on 11/8/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class CommentCellController: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var postUsername: UILabel!
    @IBOutlet weak var postComment: UILabel!
    @IBOutlet weak var postTime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.profileImage.layer.cornerRadius = CGFloat(self.profileImage.frame.height/2)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
