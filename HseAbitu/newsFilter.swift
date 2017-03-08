//
//  newsFilter.swift
//  HseAbitu
//
//  Created by Sergey on 12/3/16.
//  Copyright © 2016 Sergey. All rights reserved.
//

import Foundation

class newsFilter{
    static var filterMask : [String : Bool] = ["1" : false, "2" : false, "3" : false, "4" : false]
    static func isFilterON() -> Bool{
        for i in 1...4{
            if self.filterMask[String(i)] == true{
                return true
            }
        }
        return false
    }

}
