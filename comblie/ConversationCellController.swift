//
//  ConversationCellController.swiftMessageTableViewController
//  comblie
//
//  Created by Cal on 10/16/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class ConversationCellController: UITableViewCell {
    
    var messageRoomVC : UIViewController!

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var message: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        styleContent()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: Actions
    @IBAction func openConversation(sender: UIButton) {
        messageRoomVC = self.window?.rootViewController?.storyboard?.instantiateViewControllerWithIdentifier("MessageRoomPage") as! MessageRoomViewController
        //For keeping the opacity
        messageRoomVC.providesPresentationContextTransitionStyle = true
        messageRoomVC.definesPresentationContext = true
        messageRoomVC.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        self.window?.rootViewController?.presentViewController(messageRoomVC, animated: true, completion: populateConversation)
    }
    
    func populateConversation() {
        
    }
    
    func styleContent() {
        self.separatorInset = UIEdgeInsetsZero
        self.profileImage.layer.cornerRadius = CGFloat(self.profileImage.frame.size.height/2)
        self.profileImage.clipsToBounds = true
        
        let font = UIFont(name: "HelveticaNeueLTStd-Lt", size: CGFloat(10.0))
        self.message.font = font
        
        /*self.messageText.contentInset = UIEdgeInsetsMake(-4, -4, 0, 0)
        
        let say = "hahahaoasidjsasdoasjdaoisdjaoidjaosijdoiasjdisajdoiasdjoaisjdoaisjoaijdsaidhasiduhasiduhasiudhasiHello Hello"
        let num = say.endIndex.advancedBy(-4)
        self.messageText.text = say.substringToIndex(num)*/
        
    }


}
