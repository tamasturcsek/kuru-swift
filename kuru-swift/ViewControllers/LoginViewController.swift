//
//  LoginViewController.swift
//  kuru-swift
//
//  Created by Tamas Turcsek on 24/03/16.
//  Copyright © 2016 Meruem Software. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var waiterUsername: UITextField!
    @IBOutlet weak var waiterPassword: UITextField!
    @IBOutlet weak var waiterButton: UIButton!
    @IBOutlet weak var customerCode: UITextField!
    @IBOutlet weak var customerButton: UIButton!
    
    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        waiterButton.addTarget(self, action: #selector(LoginViewController.waiterlogin(_:)), forControlEvents: .TouchUpInside)
        
        customerButton.addTarget(self, action: #selector(LoginViewController.customerlogin(_:)), forControlEvents: .TouchUpInside)
        //enableEnterKeyForFields()
    }
    
    func waiterlogin(sender: UIButton!) {
        let user: 	[String:AnyObject] = [
            "username" : waiterUsername.text!,
            "password" : waiterPassword.text!]
        User.login(user, success: {
            response in
            if(response == 200) {
                self.login()
            }
            else {
                self.showError()
            }
        })
    }
    
    func showError() {
        let alertController = UIAlertController(title: "Figyelmeztetés", message: "Hibás felhasználónév, vagy jelszó!", preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            self.waiterUsername.text = ""
            self.waiterPassword.text = ""
        }
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true) {
            // ...
        }
    }
    
    func login() {
        
            let alertController = UIAlertController(title: "Üdvözöllek", message: "Bejelentkeztél a következő azonosítóval: " + self.waiterUsername.text!, preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                let vc: UIViewController = self.mainStoryboard.instantiateViewControllerWithIdentifier("customerViewController") as UIViewController
                KuruVariables.username = self.waiterUsername.text!
                self.presentViewController(vc, animated: true, completion: nil)
            }
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true) {
                // ...
            }

    }
    
    func customerlogin(sender: UIButton!) {
        Customer.findByCode(customerCode.text!, success: {
            response in
            let customer = response
                let alertController = UIAlertController(title: "Üdvözöllek", message: "Bejelentkezés a következő azonosítóval: " + self.customerCode.text!, preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                    let vc: UIViewController = self.mainStoryboard.instantiateViewControllerWithIdentifier("tabController") as UIViewController
                    KuruVariables.customer = customer
                    self.presentViewController(vc, animated: true, completion: nil)
                }
                alertController.addAction(OKAction)
                
                let CancelAction = UIAlertAction(title: "Mégsem", style: .Cancel) { (action) in
                    // Do nothing
                }
                alertController.addAction(CancelAction)
                
                self.presentViewController(alertController, animated: true) {
                    // ...
                }
           
            }, onFailure: {
                
                let alertController = UIAlertController(title: "Figyelmeztetés", message: "Helytelen ügyfélazonosító!", preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                    self.customerCode.text = ""
                }
                alertController.addAction(OKAction)
                self.presentViewController(alertController, animated: true) {
                    // ...
                }
        }
        })
        
        
    }
    
    func enableEnterKeyForFields() {
        //waiterUsername.focus
        waiterPassword.enablesReturnKeyAutomatically = true
        customerCode.enablesReturnKeyAutomatically = true
    }
    
    

}
