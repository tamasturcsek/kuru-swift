//
//  ArticlesViewController.swift
//  kuru-swift
//
//  Created by Tamas Turcsek on 24/03/16.
//  Copyright © 2016 Meruem Software. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ArticlesViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var articleCategoryScroll: UIScrollView!
    @IBOutlet weak var articlesView: UICollectionView!
    var articles = [Article]()
    var articleCategories = [ArticleCategory]()
    
    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.articleCategoryScroll.delegate = self
        refreshArticleCategories()
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        refreshArticleCategories()
        buildBackButton()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func redrawScroll() {
        var containerView = UIView()
        self.articleCategoryScroll.addSubview(containerView)
        var i = 0 as CGFloat
        for ac:ArticleCategory in articleCategories{
            let button   = UIButton(type: UIButtonType.System)
            button.backgroundColor = UIColor.greenColor()
            button.setTitle(ac.name, forState: UIControlState.Normal)
            button.frame = CGRectMake(0+(i*50), 0, 40, 40)
            containerView.addSubview(button)
            i += 1
        }
    }
    
    func refreshArticleCategories() {
        ArticleCategory.findAll({
            response in
            self.articleCategories = response
            //self.redrawScroll()
            
        })
        
    }
    
    
    func refreshArticleCategories(sender:AnyObject) {
        refreshArticleCategories()
    }
    
    
    @IBAction func back(sender: AnyObject) {
        if(KuruVariables.username == "") {
            let alertController = UIAlertController(title: "Kilépés", message: "Biztos, hogy kijelentkezel?", preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "Igen", style: .Default) { (action) in
                let vc: UIViewController = self.mainStoryboard.instantiateViewControllerWithIdentifier("loginViewController") as UIViewController
                KuruVariables.customer = ""
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
        } else {
            let vc: UIViewController = self.mainStoryboard.instantiateViewControllerWithIdentifier("customerViewController") as UIViewController
            KuruVariables.customer = ""
            self.presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    func buildBackButton() {
        if(KuruVariables.username == "") {
            backButton.setTitle("< Kilépés", forState: UIControlState.Normal)
        } else {
            backButton.setTitle("< Vissza", forState: UIControlState.Normal)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

