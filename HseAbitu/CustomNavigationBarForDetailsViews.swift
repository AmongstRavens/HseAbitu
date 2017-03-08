//
//  CustomNavigationBarForDetailsViews.swift
//  HseAbitu
//
//  Created by Sergey on 11/30/16.
//  Copyright © 2016 Sergey. All rights reserved.
//

import UIKit

class customNavigationBar{
    static func getBarForDetailView(with image: UIImage, width: CGFloat, height: CGFloat) -> UINavigationBar{
        let bar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: width, height: height))
        bar.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        return bar
    }
    
    static func getBarForDetailsView(width: CGFloat, height: CGFloat) -> UINavigationBar{
        let bar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: width, height: height))
        bar.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        bar.clipsToBounds = false
        return bar
    }
}
