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

class ArticlesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var backButton: UIButton!
    
    
    @IBOutlet weak var articlesView: UICollectionView!
    @IBOutlet weak var articleCatScroll: UIScrollView!
    @IBOutlet weak var articleCatView: UIView!
    var articles = [Article]()
    var articleCategories = [ArticleCategory]()
    
    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.articlesView.dataSource = self
        self.articlesView.delegate = self

        // Do any additional setup after loading the view, typically from a nib.

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        refreshArticleCategories()
        showAll(self)
        buildBackButton()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    
    func redrawScroll() {
        let allButton = myUIButton(type: UIButtonType.RoundedRect)
        allButton.backgroundColor = UIColor.orangeColor()
        allButton.tintColor = UIColor.whiteColor()
        allButton.setTitle("Minden", forState: UIControlState.Normal)
        allButton.frame = CGRectMake(10, 10, 80, 80)
        allButton.addTarget(self, action: #selector(ArticlesViewController.showAll(_:)), forControlEvents: .TouchUpInside)
        self.articleCatView.addSubview(allButton)
        var i = 0 as CGFloat
        for ac:ArticleCategory in articleCategories{
            let button   = myUIButton(type: UIButtonType.RoundedRect)
            button.backgroundColor = UIColor.orangeColor()
            button.tintColor = UIColor.whiteColor()
            button.setTitle(ac.name, forState: UIControlState.Normal)
            button.frame = CGRectMake(100+(i*90), 10, 80, 80)
            button.ac = ac
            button.addTarget(self, action: #selector(ArticlesViewController.showArticles(_:)), forControlEvents: .TouchUpInside)
            self.articleCatView.addSubview(button)
            i += 1
        }
        self.articleCatView.frame = CGRectMake(0, 0, 100+(i*90), 100)
        articleCatScroll.contentSize = CGSize(width: articleCatView.frame.size.width, height: articleCatView.frame.size.height)
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
    
    func showAll(sender: AnyObject) {
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

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell :CollectionViewCell = articlesView.dequeueReusableCellWithReuseIdentifier("articleCell", forIndexPath: indexPath) as! CollectionViewCell
        cell.label.text = articles[indexPath.row].name
        cell.price.text = String(articles[indexPath.row].price) + "HUF / " + articles[indexPath.row].unit
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let item = Item(bill: Bill(),article: self.articles[indexPath.row] ,amount: 1,createdate: NSDate(),outdate: nil)
        var incremented = false
        for var i in KuruVariables.cart {
            if i.article.id == item.article.id {
                i.amount += 1
                incremented = true
            }
        }
        if !incremented {
            KuruVariables.cart.append(item)
        }
        if let badgeValue = tabBarController?.tabBar.items?[1].badgeValue,
            nextValue = Int(badgeValue)?.successor() {
            tabBarController?.tabBar.items?[1].badgeValue = String(nextValue)
        } else {
            tabBarController?.tabBar.items?[1].badgeValue = "1"
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 5, 10, 5) // margin between cells
    }
    
}

