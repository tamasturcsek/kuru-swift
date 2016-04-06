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
        let alertView = UIAlertView();
        alertView.addButtonWithTitle("Ok");
        alertView.title = waiterUsername.text!;
        alertView.message = waiterPassword.text;
        alertView.show();
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewControllerWithIdentifier("tabController") as UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    func customerlogin(sender: UIButton!) {
        let alertView = UIAlertView();
        alertView.addButtonWithTitle("Ok");
        alertView.title = customerCode.text!;
        alertView.message = customerCode.text;
        alertView.show();
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
