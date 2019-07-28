//
//  CusImageview.swift
//  Taqseem
//
//  Created by apple on 3/13/19.
//  Copyright © 2019 OnTime. All rights reserved.
//

import Foundation
import UIKit
let imageCash = NSCache<AnyObject, AnyObject>()

class customImageView: UIImageView{
    var imageUrlString : String?
    //use setup image to download from api
    func loadimageUsingUrlString(url:String){
        print(url)
        imageUrlString = url
        
        let Url = URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        //            URL(string:url)
        if Url == nil{
            print("Error : Url is Emty")
            self.image = #imageLiteral(resourceName: "Group 660")
            return
        }
        let urlRequest = URLRequest(url: Url!)
        
        image = #imageLiteral(resourceName: "Group 660")
        if let imageForCash = imageCash.object(forKey: Url as AnyObject) as? UIImage{
            
            self.image = imageForCash
            return
        }
        
        //        self.image = #imageLiteral(resourceName: "officePlaceholder")
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            
            // check for any errors
            guard error == nil else{
                print("Error :Calling API")
                print(error!)
                return
            }
            
            DispatchQueue.global(qos: .userInitiated).async {
                // Bounce back to the main thread to update the UI
                DispatchQueue.main.async {
                    
                    let imageToCash = UIImage(data: data!)
                    
                    if self.imageUrlString == url{
                        self.image = imageToCash
                    }
                    
                    if imageToCash != nil
                    {
                        imageCash.setObject(imageToCash!, forKey: Url as AnyObject)
                    }else
                    {
                        self.image = #imageLiteral(resourceName: "Group 660")
                    }
                }
                
                
            }
            
            
            
            
        }
        
        task.resume()
        
    }
    
}



