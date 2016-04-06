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
    @IBOutlet weak var articles: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

