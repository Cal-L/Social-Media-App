//
//  NotificationCell.swift
//  comblie
//
//  Created by Cal on 10/17/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {
    
    // MARK: Properties
    
   
    @IBOutlet weak var notification: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    
    @IBOutlet weak var profileImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        changeText()
        styleContent()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func styleContent() {
        self.separatorInset = UIEdgeInsetsZero
        self.profileImage.layer.cornerRadius = CGFloat(self.profileImage.frame.size.height/2)
        self.profileImage.clipsToBounds = true
        /*let font = UIFont(name: "HelveticaNeueLTStd-Lt", size: CGFloat(10.0))
        self.message.font = font*/
        
        /*self.messageText.contentInset = UIEdgeInsetsMake(-4, -4, 0, 0)
        
        let say = "hahahaoasidjsasdoasjdaoisdjaoidjaosijdoiasjdisajdoiasdjoaisjdoaisjoaijdsaidhasiduhasiduhasiudhasiHello Hello"
        let num = say.endIndex.advancedBy(-4)
        self.messageText.text = say.substringToIndex(num)*/
        
    }

    
    func changeText() {
        var firstWord = "Angelina Jolie "
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: firstWord, attributes: [NSFontAttributeName:UIFont(
            name: "HelveticaNeueLTStd-Md",
            size: 12.0)!])
        
        var secondWord = "commented on your post on "
        var styleString = NSMutableAttributedString()
        styleString = NSMutableAttributedString(string: secondWord, attributes: [NSFontAttributeName:UIFont(
            name: "HelveticaNeueLTStd-Roman",
            size: 12.0)!])
        
        var thirdWord = "Vine."
        var thirdStyleString = NSMutableAttributedString()
        thirdStyleString = NSMutableAttributedString(string: thirdWord, attributes: [NSFontAttributeName:UIFont(
            name: "HelveticaNeueLTStd-Md",
            size: 12.0)!])

        
        myMutableString.appendAttributedString(styleString)
        myMutableString.appendAttributedString(thirdStyleString)
        notification.attributedText = myMutableString
    }

}
