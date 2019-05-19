//
//  HomeProjectVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/15/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit

class HomeProjectVC: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    @IBOutlet weak var tblProjects: UITableView!
    override func viewDidLoad() {
       
       
       tblProjects.delegate = self
        tblProjects.dataSource = self
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
