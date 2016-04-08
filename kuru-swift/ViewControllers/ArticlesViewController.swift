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
    
    func refreshArticleCategories() {
        ArticleCategory.findAll({
            response in
            self.articleCategories = response
            
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

