//
//  moreTC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/23/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit

class moreTC: UITableViewCell {

    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var img: customImageView!
//        {
//        didSet{
//            img.layer.cornerRadius =  img.frame.width / 2
//            img.layer.borderWidth = 1
//            //            ProfileImageView.layer.borderColor =  UIColor(red: 0, green: 156, blue: 158, alpha: 1) as! CGColor
//
//            img.clipsToBounds = true
//
//        }
//    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            frame.origin.y += 10
            frame.size.height -= 2 * 5
            super.frame = frame
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
