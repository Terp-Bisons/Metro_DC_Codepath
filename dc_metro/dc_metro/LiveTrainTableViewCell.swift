//
//  LiveTrainTableViewCell.swift
//  dc_metro
//
//  Created by Aarya BC on 4/15/17.
//  Copyright © 2017 Aarya BC. All rights reserved.
//

import UIKit

class LiveTrainTableViewCell: UITableViewCell {

    @IBOutlet weak var blueLineView: UIView!
    @IBOutlet weak var destinationName: UILabel!
    @IBOutlet weak var destinationTime: UILabel!
    @IBOutlet weak var lineLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
