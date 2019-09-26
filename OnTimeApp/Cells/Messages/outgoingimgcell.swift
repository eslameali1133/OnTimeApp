//
//  outgoingimgcell.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 9/15/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit

class outgoingimgcell: UITableViewCell {

    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var img: customImageView!
    @IBOutlet weak var lblTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
