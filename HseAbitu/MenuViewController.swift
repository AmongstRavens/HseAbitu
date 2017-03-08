//
//  MenuViewController.swift
//  HseAbitu
//
//  Created by Sergey on 10/27/16.
//  Copyright © 2016 Sergey. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    let veilView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        veilView.frame = CGRect(x: 0, y: 0, width: self.revealViewController().rearViewController.view.bounds.size.width, height: self.revealViewController().rearViewController.view.bounds.size.height)
        veilView.layer.isOpaque = true
        veilView.backgroundColor = UIColor.black.withAlphaComponent(0)
        veilView.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.revealViewController().frontViewController != nil{
            self.revealViewController().frontViewController.view.addSubview(veilView)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        veilView.removeFromSuperview()
    }
    
}
