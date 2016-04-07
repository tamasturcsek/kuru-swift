//
//  CustomerViewController.swift
//  kuru-swift
//
//  Created by Tamas Turcsek on 24/03/16.
//  Copyright © 2016 Meruem Software. All rights reserved.
//

import UIKit

class CustomerViewController: UITableViewController{
    
    @IBOutlet weak var userTable: UITableView!
    var customers = [Customer]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up the refresh control
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl?.addTarget(self, action: #selector(CustomerViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        
      refresh()
    }

    func refresh() {
        Customer.findAll({
            response in
            self.customers = response
            
            self.refreshControl?.endRefreshing()
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.userTable.reloadData()
            })
            }
        })
    }
    func refresh(sender:AnyObject) {
        refresh()
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customers.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->   UITableViewCell {
        let customer = customers[indexPath.item]
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "userCell")
        let cell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath)
        cell.textLabel?.text = customer.name
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
}
