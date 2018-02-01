//
//  ViewControllerTableViewCell.swift
//  Vistival
//
//  Created by Daan Demeulemeester on 01/02/2018.
//  Copyright © 2018 Stijn Huygh. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var lblCell: UIView!
    @IBOutlet weak var lblImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
