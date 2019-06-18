//
//  AllProjectVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 6/17/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit

class AllProjectVC: UIViewController , UITableViewDataSource , UITableViewDelegate {

    @IBOutlet weak var tblProjects: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tblProjects.delegate = self
        tblProjects.dataSource = self
        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectTC", for: indexPath) as! ProjectTC
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProjectDetails", bundle:nil)
        let cont = storyBoard.instantiateViewController(withIdentifier: "ProjectMessagesVC")as! ProjectMessagesVC
        self.present(cont, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

}
