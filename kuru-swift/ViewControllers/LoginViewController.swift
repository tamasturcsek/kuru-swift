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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        waiterButton.addTarget(self, action: #selector(LoginViewController.waiterlogin(_:)), forControlEvents: .TouchUpInside)
        
        customerButton.addTarget(self, action: #selector(LoginViewController.customerlogin(_:)), forControlEvents: .TouchUpInside)
    }
    
    func waiterlogin(sender: UIButton!) {
        let alertController = UIAlertController(title: "Üdvözöllek", message: "Bejelentkeztél a következő azonosítóval: " + waiterUsername.text!, preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: UIViewController = storyboard.instantiateViewControllerWithIdentifier("customerViewController") as UIViewController
            KuruVariables.username = self.waiterUsername.text!
            self.presentViewController(vc, animated: true, completion: nil)
        }
        alertController.addAction(OKAction)
        
        
        self.presentViewController(alertController, animated: true) {
            // ...
        }
        
    }
    
    func customerlogin(sender: UIButton!) {
        let alertController = UIAlertController(title: "Üdvözöllek", message: "Bejelentkezés a következő azonosítóval: " + customerCode.text!, preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: UIViewController = storyboard.instantiateViewControllerWithIdentifier("tabController") as UIViewController
            KuruVariables.customer = self.customerCode.text!
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
 
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
