//
//  Food.swift
//  Fresheries
//
//  Created by Manav Ramesh on 2/20/16.
//  Copyright © 2016 Manav Ramesh. All rights reserved.
//

import UIKit

class Food: NSObject {
    var buyDate: NSDate?
    var shelfLife: Int?
    var name: String?
    var category: String?
    var status: String? // reprsesents whether the food was consumed or expired
    var removedOn: NSDate? // on what date was the food consumed/did it expire?
    var daysLeft: Int? // number of days between buyDate and removedOn
}
