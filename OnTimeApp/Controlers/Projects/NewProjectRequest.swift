//
//  NewProjectRequest.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/28/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit

class NewProjectRequest: UIViewController {

    var isimgChecked1 = false
    var isimgChecked2 = false
    var isimgChecked3 = false
    var isimgChecked4 = false
    @IBOutlet weak var imgVoice: UIImageView!
    @IBOutlet weak var imgQueikService: UIImageView!
    @IBOutlet weak var imgTranslation: UIImageView!
    @IBOutlet weak var imgScinario: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSideMenue(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Projects", bundle: nil)
        let cont = storyboard.instantiateViewController(withIdentifier: "RightMenuNavigationController")
        cont.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        cont.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        self.present(cont, animated: true, completion: nil)
    }

    @IBAction func btnQueckService(_ sender: Any) {
        if isimgChecked1 == false {
            imgQueikService.image = UIImage(named: "check")
            isimgChecked1 = true
        }else{
            imgQueikService.image = UIImage(named: "check (1)")
            isimgChecked1 = false
        }
    }
    @IBAction func btnVoice(_ sender: Any) {
        if isimgChecked2 == false {
            imgVoice.image = UIImage(named: "check")
            isimgChecked2 = true
        }else{
            imgVoice.image = UIImage(named: "check (1)")
            isimgChecked2 = false
        }
    }
    @IBAction func btnTranslation(_ sender: Any) {
        if isimgChecked3 == false {
            imgTranslation.image = UIImage(named: "check")
            isimgChecked3 = true
        }else{
            imgTranslation.image = UIImage(named: "check (1)")
            isimgChecked3 = false
        }
    }
    @IBAction func btnScinario(_ sender: Any) {
        if isimgChecked4 == false {
            imgScinario.image = UIImage(named: "check")
            isimgChecked4 = true
        }else{
            imgScinario.image = UIImage(named: "check (1)")
            isimgChecked4 = false
        }
    }
    @IBAction func DismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
