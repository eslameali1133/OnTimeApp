//
//  addOnesCVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 7/8/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit
var AddonsR = [String]()
class addOnesCVC: UICollectionViewCell {
    var Id = ""
    var price = ""
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBAction func btnAddones(_ sender: UIButton) {
        if img.image == UIImage(named: "check") {
            img.image = UIImage(named: "check (1)")
            removee()
        }else if img.image == UIImage(named: "check (1)"){
            img.image = UIImage(named: "check")
            appendd()
        }
    }
    func removee ()
    {
        let index = AddonsR.index(of: Id)
        AddonsR.remove(at: index!)
        print(AddonsR.count)
    }
    func appendd ()
    {
        AddonsR.append(Id)
        print(AddonsR.count)
    }
}
