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
    @IBOutlet weak var icon: customImageView!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var desce: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var widthconst: NSLayoutConstraint!
    @IBOutlet weak var img: customImageView!{
        didSet{
            img.layer.cornerRadius =  img.frame.width / 2
            img.layer.borderWidth = 0
            //            ProfileImageView.layer.borderColor =  UIColor(red: 0, green: 156, blue: 158, alpha: 1) as! CGColor
            
            img.clipsToBounds = true
            
        }
    }
    @IBOutlet weak var viewStatus: UIView!
    @IBOutlet weak var viewMain: AMCircleUIView!
    override func awakeFromNib() {
        
        self.layer.cornerRadius = 8.0
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.3
        //self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
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
