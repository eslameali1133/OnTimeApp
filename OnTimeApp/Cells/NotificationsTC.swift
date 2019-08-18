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
    @IBOutlet weak var imgNotification: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
