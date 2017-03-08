//
//  FacultyViewController.swift
//  HseAbitu
//
//  Created by Sergey on 10/27/16.
//  Copyright © 2016 Sergey. All rights reserved.
//

import UIKit

class FacultyViewController: UIViewController {
    @IBOutlet weak var sport: UICollectionViewCell!

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.navigationItem.title = "Студ. огранизации"
        }
        
        sport.bounds.size.width = CGFloat(200)
        sport.bounds.size.height = CGFloat(200)
        let customCollectionLayout : UICollectionViewLayout
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
