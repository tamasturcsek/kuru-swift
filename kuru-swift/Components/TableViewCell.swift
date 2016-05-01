//
//  TableViewCell.swift
//  kuru-swift
//
//  Created by Tamas Turcsek on 01/05/16.
//  Copyright © 2016 Meruem Software. All rights reserved.
//

import UIKit

class TableViewCell : UITableViewCell {

    @IBOutlet weak var plus: CartUIButton!
    @IBOutlet weak var minus: CartUIButton!
    @IBOutlet weak var article: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var price: UILabel!

}
