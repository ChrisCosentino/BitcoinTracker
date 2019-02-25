//
//  FeedCell.swift
//  CryptoTracker
//
//  Created by Chris Cosentino on 2018-07-09.
//  Copyright © 2018 Chris Cosentino. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var lblTickerSymbol: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblOneHourPercent: UILabel!
    @IBOutlet weak var lbl24HourPercent: UILabel!
    @IBOutlet weak var lbl7DayPercent: UILabel!
    @IBOutlet weak var lblTickerName: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lbl7DayPercent.text = "0.0"
        self.lblOneHourPercent.text = "0.0"
        self.lbl24HourPercent.text = "0.0"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
