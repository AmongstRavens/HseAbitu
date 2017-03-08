//
//  FilterViewController.swift
//  HseAbitu
//
//  Created by Sergey on 11/22/16.
//  Copyright © 2016 Sergey. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController{
    private var circlesState = [UIButton : Bool]()
    private var isFilterChanged = false
    private var initialFilter = [String : Bool]()
    
    @IBOutlet var labels: [UIButton]!
    @IBOutlet var circles: [UIButton]!
    @IBOutlet weak var exitButton: UIButton!

    
    @IBAction func exitView(_ sender: UIButton) {
        let size = self.navigationController?.viewControllers.count
        if size! >= 2{
            (navigationController?.viewControllers[size! - 2] as! EventsCollectionViewController).isNeededToReload = (self.initialFilter != newsFilter.filterMask)
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.initialFilter = newsFilter.filterMask
        setView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    
    @IBAction func filterPressed(_ sender: UIButton) {
        
        if circles.contains(sender){
            if circlesState[sender] == true{
                newsFilter.filterMask[String(circles.index(of: sender)! + 1)] = false
                circlesState[sender] = false
                sender.setBackgroundImage(#imageLiteral(resourceName: "oval"), for: .normal)
                sender.setNeedsDisplay()
            } else {
                newsFilter.filterMask[String(circles.index(of: sender)! + 1)] = true
                circlesState[sender] = true
                sender.setBackgroundImage(#imageLiteral(resourceName: "oval94"), for: .normal)
                sender.setNeedsDisplay()
            }
        } else {
            let index = labels.index(of: sender)
            if circlesState[circles[index!]] == true{
                newsFilter.filterMask[String(index! + 1)] = false
                circlesState[circles[index!]] = false
                circles[index!].setBackgroundImage(#imageLiteral(resourceName: "oval"), for: .normal)
                circles[index!].setNeedsDisplay()
            } else {
                newsFilter.filterMask[String(index! + 1)] = true
                circlesState[circles[index!]] = true
                circles[index!].setBackgroundImage(#imageLiteral(resourceName: "oval94"), for: .normal)
                circles[index!].setNeedsDisplay()
            }
        }
    }
    
    private func setView(){
        for i in (0...circles.count - 1){
            circlesState[circles[i]] = newsFilter.filterMask[String(i + 1)]
            if newsFilter.filterMask[String(i + 1)] == true{
                circles[i].setBackgroundImage(#imageLiteral(resourceName: "oval94"), for: .normal)
            } else{
                circles[i].setBackgroundImage(#imageLiteral(resourceName: "oval"), for: .normal)
            }
        }
    }


}
