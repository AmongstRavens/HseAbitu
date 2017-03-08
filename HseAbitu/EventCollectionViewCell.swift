//
//  EventCollectionViewCell.swift
//  HseAbitu
//
//  Created by Sergey on 11/22/16.
//  Copyright © 2016 Sergey. All rights reserved.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var eventMainText: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var didAddedFilterToImageView : Bool = false
}
