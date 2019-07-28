//
//  AMCircleImageView.swift
//  pro2
//
//  Created by Ahmed Wahdan on 6/15/17.
//  Copyright © 2016 Ahmed Wahdan. All rights reserved.
//


import UIKit

@IBDesignable
class AMCircleImageView: UIImageView {
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = self.borderColor.cgColor
            self.layer.borderWidth = 5.0
        }
    }
    
    @IBInspectable var isCircle: Bool = false {
        didSet {
            if self.isCircle {
                self.layer.cornerRadius = self.bounds.height / 2
                self.layer.masksToBounds = true
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

extension UIView {
    func circleView(_ borderColor: UIColor, borderWidth: CGFloat) {
        self.layer.cornerRadius = self.bounds.height / 2
//        self.layer.cornerRadius = 7.0
        self.layer.masksToBounds = true
        
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
    }
}

@IBDesignable
class AMCircleUIView: UIView {
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = self.borderColor.cgColor
            self.layer.borderWidth = 1.0
        }
    }
    
    @IBInspectable var isCircle: Bool = false {
        didSet {
            if self.isCircle {
                self.layer.cornerRadius = self.bounds.height / 2
                self.layer.masksToBounds = true
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

@IBDesignable
class AMUIView: UIView {
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = self.borderColor.cgColor
            self.layer.borderWidth = 2.0
        }
    }
    
    @IBInspectable var isCornerRadius: Bool = false {
        didSet {
            if self.isCornerRadius {
                self.layer.cornerRadius = 10.0
                self.layer.masksToBounds = true
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

@IBDesignable
class AMUILabel: UILabel {
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = self.borderColor.cgColor
            self.layer.borderWidth = 1.0
        }
    }
    
    @IBInspectable var isCornerRadius: Bool = false {
        didSet {
            if self.isCornerRadius {
                self.layer.cornerRadius = 10.0
                self.layer.masksToBounds = true
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}


//let imageCash = NSCache<AnyObject, AnyObject>()
//
//class customImageView: UIImageView{
//    var imageUrlString : String?
//    //use setup image to download from api
//    func loadimageUsingUrlString(url:String){
//        
//        imageUrlString = url
//        
//        let Url = URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
////            URL(string:url)
//        let urlRequest = URLRequest(url: Url!)
//        
//        image = #imageLiteral(resourceName: "officePlaceholder")
//        if let imageForCash = imageCash.object(forKey: Url as AnyObject) as? UIImage{
//            
//            self.image = imageForCash
//            return
//        }
//        
//        //        self.image = #imageLiteral(resourceName: "officePlaceholder")
//        let config = URLSessionConfiguration.default
//        let session = URLSession(configuration: config)
//        
//        let task = session.dataTask(with: urlRequest) {
//            (data, response, error) in
//            
//            // check for any errors
//            guard error == nil else{
//                print("Error :Calling API")
//                print(error!)
//                return
//            }
//            
//            DispatchQueue.global(qos: .userInitiated).async {
//                // Bounce back to the main thread to update the UI
//                DispatchQueue.main.async {
//                    
//                    let imageToCash = UIImage(data: data!)
//                    
//                    if self.imageUrlString == url{
//                        self.image = imageToCash
//                    }
//                    
//                    if imageToCash != nil
//                    {
//                        imageCash.setObject(imageToCash!, forKey: Url as AnyObject)
//                    }else
//                    {
//                        self.image = #imageLiteral(resourceName: "officePlaceholder")
//                    }
//                }
//                
//                
//            }
//            
//            
//            
//            
//        }
//        
//        task.resume()
//        
//    }
//    
//}
//
//
//
