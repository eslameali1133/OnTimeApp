//
//  InvoiceVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/16/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit

class InvoiceVC: UIViewController , UITableViewDataSource , UITableViewDelegate{

    @IBOutlet weak var tblInvoice: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tblInvoice.delegate = self
        tblInvoice.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AloqoodTC", for: indexPath) as! AloqoodTC
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    
    
}
