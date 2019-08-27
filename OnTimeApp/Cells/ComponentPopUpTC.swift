//
//  ComponentPopUpTC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 8/26/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit

class ComponentPopUpTC: UITableViewCell {

    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imgType: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
