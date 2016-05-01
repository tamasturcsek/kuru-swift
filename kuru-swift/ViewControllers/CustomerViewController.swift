//
//  CustomerViewController.swift
//  kuru-swift
//
//  Created by Tamas Turcsek on 24/03/16.
//  Copyright © 2016 Meruem Software. All rights reserved.
//

import UIKit

class CustomerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var userTable: UITableView!
    
    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    var customers = [Customer]()
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(CustomerViewController.handleRefresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        return refreshControl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        refresh()
        self.userTable.addSubview(self.refreshControl)
        self.userTable.dataSource = self
        self.userTable.delegate = self
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        
        // Simply adding an object to the data source for this example
        
        refresh()
        self.userTable.reloadData()
        refreshControl.endRefreshing()
    }

    func refresh() {
        Customer.findAll({
            response in
            self.customers = response
            self.userTable.reloadData()
        })
        

    }
    func refresh(sender:AnyObject) {
        refresh()
    }
    
    
    @IBAction func exit(sender: AnyObject) {
        let alertController = UIAlertController(title: "Kilépés", message: "Biztos, hogy kijelentkezel?", preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "Igen", style: .Default) { (action) in
            let vc: UIViewController = self.mainStoryboard.instantiateViewControllerWithIdentifier("loginViewController") as UIViewController
            KuruVariables.username = ""
            self.presentViewController(vc, animated: true, completion: nil)
            KuruVariables.cart.removeAll()
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
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->   UITableViewCell {
        let customer = customers[indexPath.row]
        userTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "userCell")
        let cell = userTable.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath) 
        cell.textLabel?.text = customer.name + " (" + customer.code + ")"
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        userTable.deselectRowAtIndexPath(indexPath, animated: true)
        let vc: UIViewController = self.mainStoryboard.instantiateViewControllerWithIdentifier("tabController") as UIViewController
        KuruVariables.customer = customers[indexPath.row]
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    
}
