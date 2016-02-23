//
//  FoodTableViewCell.swift
//  Fresheries
//
//  Created by Manav Ramesh on 2/20/16.
//  Copyright © 2016 Manav Ramesh. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class FoodTableViewCell: MGSwipeTableCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var expirationDateLabel: UILabel!
    @IBOutlet weak var timeBarView: UIView!

    
    let green = UIColor(red:0.26, green:0.63, blue:0.27, alpha:1.0)
    let orange = UIColor(red:0.98, green:0.55, blue:0.0, alpha:1.0)
    let red = UIColor(red:0.9, green:0.22, blue:0.21, alpha:1.0)
    
    var food: Food? {
        didSet {
            timeBarView.frame.size.width = CGFloat(0)
            nameLabel.text = food?.name
            let currentDate = NSDate()
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "M/d/yy"
            
            var expiryDate:NSDate
            expiryDate = NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: (food?.shelfLife)!, toDate: (food?.buyDate)!, options: NSCalendarOptions(rawValue: 0))!
            var currentDiff = (NSCalendar.currentCalendar().components(.Day, fromDate: currentDate, toDate: expiryDate, options: []).day)
            currentDiff+=1
            timeLeftLabel.text = currentDiff == 365 ? "N/A" : String(currentDiff) + "d"
            expirationDateLabel.text = dateFormatter.stringFromDate(expiryDate)
            
            var percentDiff = Double(currentDiff)/30.0
            if percentDiff > 1.0 {
                percentDiff = 1.0
            }
            UIView.animateWithDuration(1.0) { () -> Void in
                self.timeBarView.frame.size.width = CGFloat(percentDiff * 243.0)
            }
            
            let statusColor: UIColor!
            if percentDiff > 0.6 {
                statusColor = green
            } else if percentDiff > 0.3 {
                statusColor = orange
            } else {
                statusColor = red
            }
            
            timeBarView.backgroundColor = statusColor
            expirationDateLabel.textColor = statusColor
            
            
            // etc
            // calculating length based on current date
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
