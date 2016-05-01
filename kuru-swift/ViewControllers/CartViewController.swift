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
        getActiveBill()
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
        let cell: TableViewCell = cartTable.dequeueReusableCellWithIdentifier("cartCell", forIndexPath: indexPath) as! TableViewCell
        cell.article.text = item.article.name
        cell.amount.text = String(item.amount)
        cell.price.text = String(item.article.price * item.amount) + " HUF"
        cell.minus.item = item
        cell.minus.id = indexPath.row
        cell.minus.addTarget(self, action: #selector(CartViewController.removeItem(_:)), forControlEvents: .TouchUpInside)
        cell.plus.item = item
        cell.plus.addTarget(self, action: #selector(CartViewController.addItem(_:)), forControlEvents: .TouchUpInside)
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
    
    
    func removeItem(sender: CartUIButton) {
        let item = sender.item
        if(item?.amount == 1) {
            KuruVariables.cart.removeAtIndex(sender.id!)
        }else {
            item!.amount -= 1
        }
        refresh()
    }
    
    func addItem(sender: CartUIButton) {
        sender.item!.amount += 1
        refresh()
    }
    
    @IBAction func buyItems(sender: AnyObject) {
        Item.save(KuruVariables.cart,success: {
            response in
            let status = response
            
        })
    }
    
    func getActiveBill() {
        Bill.findActiveByCustomerCode(KuruVariables.customer.code,success: {
            response in
            let activebill = response
            for item: Item in KuruVariables.cart {
                item.bill = activebill
            }
        })
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

