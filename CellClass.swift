//
//  CellClass.swift
//  TableViewCoreDataIm
//
//  Created by mark me on 3/17/20.
//  Copyright © 2020 mark me. All rights reserved.
//

import UIKit
import CoreData

class CellClass: UITableViewCell {
    @IBOutlet var picture: UIImageView!
    @IBOutlet var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //picture.layer.cornerRadius = picture.bounds.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
