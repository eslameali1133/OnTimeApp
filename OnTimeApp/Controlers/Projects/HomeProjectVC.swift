//
//  HomeProjectVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/15/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit
import SideMenu
class HomeProjectVC: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    @IBOutlet weak var tblProjects: UITableView!
    override func viewDidLoad() {
       
      //setupSideMenu()
       tblProjects.delegate = self
       tblProjects.dataSource = self
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
    
    ////Side Menu

    fileprivate func setupSideMenu() {
        
 SideMenuManager.default.menuRightNavigationController = storyboard!.instantiateViewController(withIdentifier: "RightMenuNavigationController") as? UISideMenuNavigationController
            SideMenuManager.default.menuLeftNavigationController?.leftSide = false
        SideMenuManager.default.menuAddPanGestureToPresent(toView:
            self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView:
            self.navigationController!.view)
        SideMenuManager.default.menuWidth = view.frame.width * 0.75
       
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectTC", for: indexPath) as! ProjectTC
       
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    

    
}
