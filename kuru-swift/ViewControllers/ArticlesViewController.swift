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

class ArticlesViewController: UIViewController {
    
    @IBOutlet weak var articleCategoryScroll: UIScrollView!
    var containerView = UIView()
    @IBOutlet weak var articlesView: UICollectionView!
    var articles = [Article]()
    var articleCategories = [ArticleCategory]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshArticleCategories()
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    func redrawScroll() {
        var i = 0 as CGFloat
        for ac:ArticleCategory in articleCategories{
            let button   = UIButton(type: UIButtonType.System)
            button.backgroundColor = UIColor.greenColor()
            button.setTitle(ac.name, forState: UIControlState.Normal)
            button.frame = CGRectMake(0+(i*50), 0, 40, 40)
            self.articleCategoryScroll.addSubview(button)
            i += 1
        }
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

    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

