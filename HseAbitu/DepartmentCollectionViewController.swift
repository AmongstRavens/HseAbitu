//
//  DepartmentCollectionViewController.swift
//  HseAbitu
//
//  Created by Sergey on 11/4/16.
//  Copyright © 2016 Sergey. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class DepartmentCollectionViewController: UICollectionViewController {
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var department_images : [String] = ["sherspir", "sherspir", "sherspir", "sherspir", "sherspir", "sherspir", "sherspir", "sherspir", "sherspir", "sherspir", "sherspir"]
    var department_names : [String] = ["Социальные науки", "Юриспруденция", "Инжинерные и технические науки", "Экономика", "Социальные науки", "Матемитика и Физика", "Гуманитарные науки", "Управление", "Компьютерные науки", "Коммуникация, медиа и дизаин"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes

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
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return department_names.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DepartmentCollectionViewCell
        
        
        cell.departmentImage.image = UIImage(named: department_images[indexPath.row])
        cell.layer.bounds.size.height = 200
        cell.layer.bounds.size.width = 200
        
        cell.departmentImage.image = UIImage(named: department_images[indexPath.row])
        cell.backgroundColor = UIColor.red
    
        cell.departmentName.text = department_names[indexPath.row]
//        cell.bounds.size.height = self.view.bounds.size.width / 2
//        cell.bounds.size.width = cell.bounds.size.height
        
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
