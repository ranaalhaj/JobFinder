//
//  JobTableViewCell.swift
//  JobFinder
//
//  Created by Apple User on 2/7/19.
//  Copyright © 2019 ProgressSoft. All rights reserved.
//

import UIKit

class JobTableViewCell: UITableViewCell {

    
    @IBOutlet var compnayImageView: UIImageView!
    @IBOutlet var jobTitleLabel: UILabel!
    @IBOutlet var companyNameLabel: UILabel!
    @IBOutlet var startDateLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
   
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
