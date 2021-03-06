//
//  HistoryViewController.swift
//  kuru-swift
//
//  Created by Tamas Turcsek on 24/03/16.
//  Copyright © 2016 Meruem Software. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var historyTable: UITableView!
    
    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

    var bills = [Bill]()
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HistoryViewController.handleRefresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.historyTable.addSubview(self.refreshControl)
        self.historyTable.dataSource = self
        self.historyTable.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        
        // Simply adding an object to the data source for this example
        
        refresh()
        self.historyTable.reloadData()
        refreshControl.endRefreshing()
    }

    
   override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        buildBackButton()
            refresh()
    }
    

    func refresh() {
        Bill.findByCustomerCode(KuruVariables.customer.code,success: {
            response in
            self.bills = response
            self.historyTable.reloadData()
        })
        
        
    }
    func refresh(sender:AnyObject) {
        refresh()
    }
    
     @IBAction func back(sender: AnyObject) {
        if(KuruVariables.username == "") {
            let alertController = UIAlertController(title: "Kilépés", message: "Biztos, hogy kijelentkezel?", preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "Igen", style: .Default) { (action) in
                let vc: UIViewController = self.mainStoryboard.instantiateViewControllerWithIdentifier("loginViewController") as UIViewController
                KuruVariables.customer = Customer()
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
        } else {
            let vc: UIViewController = self.mainStoryboard.instantiateViewControllerWithIdentifier("customerViewController") as UIViewController
            KuruVariables.customer = Customer()
            self.presentViewController(vc, animated: true, completion: nil)
            KuruVariables.cart.removeAll()
        }
    }
    
    func buildBackButton() {
        if(KuruVariables.username == "") {
            backButton.setTitle("< Kilépés", forState: UIControlState.Normal)
        } else {
            backButton.setTitle("< Vissza", forState: UIControlState.Normal)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bills.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->   UITableViewCell {
        let bill = bills[indexPath.row]
        historyTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "billCell")
        let cell = historyTable.dequeueReusableCellWithIdentifier("billCell", forIndexPath: indexPath)
        let s = bill.currency == "HUF" ? String(Int(bill.sum)) : String(bill.sum)
        let sum = s + " " + bill.currency
        if(bill.closed) {
            let date = bill.closeDate!
            let dateMakerFormatter = NSDateFormatter()
            dateMakerFormatter.dateFormat = "yyyy.MM.dd"
            let formatedDate = dateMakerFormatter.stringFromDate(date)
            cell.textLabel?.text = sum + " (\(formatedDate))"
        } else {
            cell.textLabel?.text = sum
        }
        if(bill.closed) {
            cell.textLabel?.textColor = UIColor.redColor()
        } else {
            cell.textLabel?.textColor = UIColor.greenColor()
        }
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        historyTable.deselectRowAtIndexPath(indexPath, animated: true)

    }
    
}