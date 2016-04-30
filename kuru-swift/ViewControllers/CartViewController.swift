//
//  CartViewController.swift
//  kuru-swift
//
//  Created by Tamas Turcsek on 24/03/16.
//  Copyright © 2016 Meruem Software. All rights reserved.
//

import UIKit

class CartViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var sumlabel: UILabel!
    @IBOutlet weak var cartTable: UITableView!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var buyItems: UIButton!
    
    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    var customers = [Customer]()
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(CartViewController.handleRefresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        return refreshControl
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cartTable.addSubview(self.refreshControl)
        self.cartTable.dataSource = self
        self.cartTable.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        buildBackButton()
        refresh()
        
    }
    
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        
        // Simply adding an object to the data source for this example
        
        refresh()
        refreshControl.endRefreshing()
    }
    
    func refresh() {
        var sum = 0
        for item:Item in KuruVariables.cart {
            sum += item.amount*item.article.price
        }
        sumlabel.text = "\(sum) HUF"
        self.cartTable.reloadData()
        
    }
    func refresh(sender:AnyObject) {
        refresh()
    }

    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return KuruVariables.cart.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->   UITableViewCell {
        let item = KuruVariables.cart[indexPath.row]
        cartTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cartCell")
        let cell = cartTable.dequeueReusableCellWithIdentifier("cartCell", forIndexPath: indexPath)
        cell.textLabel?.text = "\(item.article.name) -  \(item.amount) \(item.article.unit) x \(item.amount*item.article.price) HUF"
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        cartTable.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    @IBAction func back(sender: AnyObject) {
        if(KuruVariables.username == "") {
            let alertController = UIAlertController(title: "Kilépés", message: "Biztos, hogy kijelentkezel?", preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "Igen", style: .Default) { (action) in
                let vc: UIViewController = self.mainStoryboard.instantiateViewControllerWithIdentifier("loginViewController") as UIViewController
                KuruVariables.customer = ""
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
            KuruVariables.customer = ""
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

