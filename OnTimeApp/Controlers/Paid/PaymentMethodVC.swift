//
//  PaymentMethodVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/28/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit

class PaymentMethodVC: UIViewController , OPPCheckoutProviderDelegate {

    let checkoutID = "132342545"
    override func viewDidLoad() {
        super.viewDidLoad()

        let provider = OPPPaymentProvider(mode: OPPProviderMode.test)
        
        let checkoutSettings = OPPCheckoutSettings()
        
        // Set available payment brands for your shop
        checkoutSettings.paymentBrands = ["VISA", "DIRECTDEBIT_SEPA"]
        // Set shopper result URL
        checkoutSettings.shopperResultURL = "com.OnTime.OnTimeApp.payments://result"

        let checkoutProvider = OPPCheckoutProvider(paymentProvider: provider, checkoutID: checkoutID, settings: checkoutSettings)
        
        // Since version 2.13.0
        checkoutProvider?.presentCheckout(forSubmittingTransactionCompletionHandler: { (transaction, error) in
            guard let transaction = transaction else {
                // Handle invalid transaction, check error
                return
            }
            
            if transaction.type == .synchronous {
                print("Synchronous")
                // If a transaction is synchronous, just request the payment status
                // You can use transaction.resourcePath or just checkout ID to do it
            } else if transaction.type == .asynchronous {
               print("aynchronous")
                // The SDK opens transaction.redirectUrl in a browser
                // See 'Asynchronous Payments' guide for more details
            } else {
                print("error")
                // Executed in case of failure of the transaction for any reason
            }
        }, cancelHandler: {
            // Executed if the shopper closes the payment page prematurely
        })
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DINNextLTW23-Regular", size: 20.0)!]
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSideMenue(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Projects", bundle: nil)
        let cont = storyboard.instantiateViewController(withIdentifier: "RightMenuNavigationController")
        cont.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        cont.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        self.present(cont, animated: true, completion: nil)
    }

    @IBAction func btnPay(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ProjectDetails", bundle: nil)
        let cont = storyboard.instantiateViewController(withIdentifier: "ProjectMessagesVC")
        
        self.present(cont, animated: true, completion: nil)

    }
    @IBAction func DismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func RequestCheckoutID (){
        
    let merchantServerRequest = NSURLRequest(url: URL(string: "https://YOUR_URL/?amount=100&currency=EUR&paymentType=DB")!)
    URLSession.shared.dataTask(with: merchantServerRequest as URLRequest) { (data, response, error) in
    // TODO: Handle errors
    if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
    let checkoutID = json?["checkoutId"] as? String
    }
    }.resume()
    }
    
    func CheckoutPage () {
        
    }
    
    @IBAction func checkoutButtonAction(_ sender: UIButton) {
        // Set a delegate property for the OPPCheckoutProvider instance
        //self.checkoutProvider.delegate = self
    }
    
    // Implement a callback, it will be called right before submitting a transaction to the Server
    func checkoutProvider(_ checkoutProvider: OPPCheckoutProvider, continueSubmitting transaction: OPPTransaction, completion: @escaping (String?, Bool) -> Void) {
        print("any")
        // To continue submitting you should call completion block which expects 2 parameters:
        // checkoutID - you can create new checkoutID here or pass current one
        // abort - you can abort transaction here by passing 'true'
        completion(transaction.paymentParams.checkoutID, false)
    }
}
