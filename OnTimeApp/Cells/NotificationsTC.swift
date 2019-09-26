//
//  NotificationsTC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 6/12/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit

class NotificationsTC: UITableViewCell {

    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var BorderView: UIView!
    @IBOutlet weak var imgNotification: customImageView!{
        didSet{
            imgNotification.layer.cornerRadius =  imgNotification.frame.width / 2
            imgNotification.layer.borderWidth = 0
            //            ProfileImageView.layer.borderColor =  UIColor(red: 0, green: 156, blue: 158, alpha: 1) as! CGColor
            
            imgNotification.clipsToBounds = true
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()

        BorderView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        BorderView.layer.shadowOffset = CGSize(width: 0, height: 4)
        BorderView.layer.shadowOpacity = 1.0
        BorderView.layer.shadowRadius = 3.0
        BorderView.layer.masksToBounds = false
        
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            frame.origin.y += 20
            frame.size.height -= 2 * 5
            super.frame = frame
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
