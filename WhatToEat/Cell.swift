//
//  StationTableViewCell.swift
//  PBike
//
//  Created by 陳 冠禎 on 2016/10/24.
//  Copyright © 2016年 陳 冠禎. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {

    @IBOutlet weak var developmentListLabel: UILabel!
    
    override func awakeFromNib() {
    developmentListLabel.textColor = UIColor.white
    }
    
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
