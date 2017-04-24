//
//  LiveBusDetailTableViewCell.swift
//  dc_metro
//
//  Created by Aarya BC on 4/23/17.
//  Copyright © 2017 Aarya BC. All rights reserved.
//

import UIKit

class LiveBusDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var directionName: UILabel!
    @IBOutlet weak var directionTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
