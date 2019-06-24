//
//  NotificationVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/28/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit
import SideMenu
class NotificationVC: UIViewController , UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var btnSideMenue: UIBarButtonItem!
    @IBOutlet weak var tblNotification: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        sideMenue()
        tblNotification.delegate = self
        tblNotification.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnPayment(_ sender: Any) {
    }
    @IBAction func btnSideMenue(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Projects", bundle: nil)
        let cont = storyboard.instantiateViewController(withIdentifier: "RightMenuNavigationController")
        cont.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        cont.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        self.present(cont, animated: true, completion: nil)
    }

    @IBAction func DismissView(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Projects", bundle:nil)
        let cont = storyBoard.instantiateViewController(withIdentifier: "HomeNAV")
        self.revealViewController()?.pushFrontViewController(cont, animated: true)
    }
    
    
    
    func sideMenue(){
        if revealViewController() != nil {
            btnSideMenue.target = revealViewController()
            btnSideMenue.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            revealViewController()?.rightViewRevealWidth =  view.frame.width * 0.75
            revealViewController()?.rearViewRevealWidth = view.frame.width * 0.25
            view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationsTC", for: indexPath) as! NotificationsTC
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "ProjectDetails", bundle: nil)
        let cont = storyboard.instantiateViewController(withIdentifier: "RequestDetailsVC")
        
        self.present(cont, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}
