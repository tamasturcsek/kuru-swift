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

class ArticlesViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var articleCategoryScroll: UIScrollView!
    @IBOutlet weak var containerView: UIView!
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
        //self.articleCategoryScroll.addSubview(containerView)
        var i = 0 as CGFloat
        for ac:ArticleCategory in articleCategories{
            let button   = myUIButton(type: UIButtonType.RoundedRect)
            button.backgroundColor = UIColor.blueColor()
            button.tintColor = UIColor.whiteColor()
            button.setTitle(ac.name, forState: UIControlState.Normal)
            button.frame = CGRectMake(90+(i*80), 10, 70, 70)
            button.ac = ac
            button.addTarget(self, action: #selector(ArticlesViewController.showArticles(_:)), forControlEvents: .TouchUpInside)
            self.containerView.frame = CGRectMake(0, 0, 90+(i*180), 120)
            //articleCategoryScroll.contentSize = CGSize(width: containerView.frame.size.width, height: containerView.frame.size.height)
            print(containerView.frame.size.width)
            self.containerView.addSubview(button)
            i += 1
        }
        /*for ac:ArticleCategory in articleCategories{
            let button   = UIButton(type: UIButtonType.RoundedRect)
            button.backgroundColor = UIColor.lightGrayColor()
            button.tintColor = UIColor.whiteColor()
            button.setTitle(ac.name, forState: UIControlState.Normal)
            button.frame = CGRectMake(10+(i*80), 10, 70, 70)
            self.containerView.addSubview(button)
            i += 1
        }*/
    }
    
    class myUIButton: UIButton {
        var ac: ArticleCategory?
        var art: Article?
    }
    
    func showArticles(sender: myUIButton!) {
        Article.findByArticleCategoryId(sender.ac!.id,success: {
            response in
            self.articles = response
            self.articlesView.reloadData()
        })
        
    }
    
    @IBAction func showAll(sender: AnyObject) {
        Article.findAll({
            response in
            self.articles = response
            self.articlesView.reloadData()
        })
    }
    
    func addToCart(sender: myUIButton!) {
                
    }
    
    func refreshArticleCategories() {
        ArticleCategory.findAll({
            response in
            self.articleCategories = response
            self.redrawScroll()
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

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell :CollectionViewCell = articlesView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CollectionViewCell
        cell.label.text = articles[indexPath.row].name
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Cell \(indexPath.row) selected")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

