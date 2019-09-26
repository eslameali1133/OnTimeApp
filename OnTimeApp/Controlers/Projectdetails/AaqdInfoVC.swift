//
//  AaqdInfoVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/28/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit
import SwiftyJSON
class AaqdInfoVC: UIViewController {
var imgChecked1 = false
    var imgChecked2 = false
    @IBOutlet weak var imgScinario: UIImageView!
    @IBOutlet weak var imgQuickService: UIImageView!
    @IBOutlet weak var AddOnesCV: UICollectionView!
    @IBOutlet weak var ComponentsCV: UICollectionView!
    @IBOutlet weak var tblComponent: UITableView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var txtTerms: UITextView!
    @IBOutlet weak var txtDesc: UITextView!
    @IBOutlet var popupPolecies: UIView!
    @IBOutlet var popupprojectDetails: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        SetData()
        AddOnesCV.delegate = self
        AddOnesCV.dataSource = self
        ComponentsCV.delegate = self
        ComponentsCV.dataSource = self
        tblComponent.dataSource = self
        tblComponent.delegate = self
         popupPolecies.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(popupPolecies)
        popupPolecies.isHidden = true
        
        popupprojectDetails.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(popupprojectDetails)
        popupprojectDetails.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnPolecies(_ sender: Any) {
        popupPolecies.isHidden = false
        popupPolecies.backgroundColor = UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.75)
    }
    
    @IBAction func btnHidePopDetail(_ sender: Any) {
        popupprojectDetails.isHidden = true
    }
    @IBAction func btnHideProjectDetails(_ sender: Any) {
        popupprojectDetails.isHidden = true
    }
    @IBAction func btnHidePolicies(_ sender: Any) {
        popupPolecies.isHidden = true
    }
    @IBAction func btnQuickService(_ sender: Any) {
        if imgChecked1 == false {
            imgQuickService.image = UIImage(named: "check")
            imgChecked1 = true
        }else{
            imgQuickService.image = UIImage(named: "check (1)")
            imgChecked1 = false
        }
    }
    @IBAction func btnScinario(_ sender: Any) {
        if imgChecked2 == false {
            imgScinario.image = UIImage(named: "check")
            imgChecked2 = true
        }else{
            imgScinario.image = UIImage(named: "check (1)")
            imgChecked2 = false
        }
    }
    @IBAction func btnShowDetails(_ sender: Any) {
       
        popupprojectDetails.isHidden = false; popupprojectDetails.backgroundColor = UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.75)
    }
    @IBAction func DismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func SetData(){
    
        lblName.text = GRequestDetail._request_name
        txtDesc.text = GRequestDetail._request_descr
        txtTerms.text = GRequestDetail._terms
    }

}
extension AaqdInfoVC : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.AddOnesCV {
        return GRequestDetail._addons.count
        }
        else{
            return GRequestDetail._components.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.AddOnesCV {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addOnesCVC", for: indexPath) as! addOnesCVC
        cell.lblName.text = GRequestDetail._addons[indexPath.row]._name
        cell.Id = GRequestDetail._addons[indexPath.row]._id
        cell.price = GRequestDetail._addons[indexPath.row]._price
            return cell
            
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComponentDetailsCVC", for: indexPath) as! ComponentDetailsCVC
            cell.done = GRequestDetail._components[indexPath.row]._done
            cell.endDate = GRequestDetail._components[indexPath.row]._end_date
         //   cell.imgType =
            cell.lblName.text = GRequestDetail._components[indexPath.row]._component_name
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 30)
    }
}
extension AaqdInfoVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return GRequestDetail._components.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComponentPopUpTC", for: indexPath) as! ComponentPopUpTC
        
        cell.lblDate.text = GRequestDetail._components[indexPath.row]._end_date
        //   cell.imgType =
        cell.lblName.text = GRequestDetail._components[indexPath.row]._component_name
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
}
