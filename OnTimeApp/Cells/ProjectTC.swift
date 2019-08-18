//
//  ProjectTC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/15/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit

class ProjectTC: UITableViewCell {

    var id = ""
    var percentage = ""
    @IBOutlet weak var statusdescr: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var desce: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var img: customImageView!{
        didSet{
            img.layer.cornerRadius =  img.frame.width / 2
            img.layer.borderWidth = 0
            //            ProfileImageView.layer.borderColor =  UIColor(red: 0, green: 156, blue: 158, alpha: 1) as! CGColor
            
            img.clipsToBounds = true
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
