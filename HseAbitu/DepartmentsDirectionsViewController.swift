//
//  DepartmentsDirectionsViewController.swift
//  HseAbitu
//
//  Created by Sergey on 11/21/16.
//  Copyright © 2016 Sergey. All rights reserved.
//

import UIKit

class DepartmentsDirectionsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    
    
    private var navigationBarShadowImage : UIImage?
    private var directionsArray = [(String, UIImage, String)]()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var DepartmentsDirectionsViewController: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBarShadowImage = self.navigationController?.navigationBar.shadowImage
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.isTranslucent = true

        self.activityIndicator.layer.zPosition = 10
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        fetchDepartmentsDirections()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setCustomNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setCommonNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.shadowImage = self.navigationBarShadowImage

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return directionsArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Departments Direction Cell", for: indexPath) as! DepartmentsDirectionsCollectionViewCell
        cell.DirectionName.textColor = UIColor.white
        cell.DirectionName.text = directionsArray[indexPath.row].0
        cell.DirectionImage.image = directionsArray[indexPath.row].1
        
        if cell.didAddedImageFilter == false{
            let imageFilter = UIView()
            imageFilter.frame = CGRect(x: 0, y: 0, width: cell.bounds.size.width, height: cell.bounds.size.height)
            imageFilter.isOpaque = true
            imageFilter.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            cell.DirectionImage.addSubview(imageFilter)
            cell.didAddedImageFilter = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == directionsArray.count - 1 && indexPath.row % 2 == 0{
            return CGSize(width: DepartmentsDirectionsViewController.bounds.size.width, height: DepartmentsDirectionsViewController.bounds.size.width / 2)
        } else {
            return CGSize(width: DepartmentsDirectionsViewController.bounds.size.width / 2, height: DepartmentsDirectionsViewController.bounds.size.width / 2)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Show Departments", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        if segue.identifier == "Show Departments"{
            let destinationVC = segue.destination as! DepartmentsViewController
            destinationVC.directionID = String((sender as! IndexPath).row + 1)
            destinationVC.directionImage = directionsArray[(sender as! IndexPath).row].1
            destinationVC.directionName = directionsArray[(sender as! IndexPath).row].0
        }
    }
    
    private func fetchDepartmentsDirections(){
        let url = URL(string: "http://abitir.styleru.net/api/getAllDirections")
        self.activityIndicator.startAnimating()
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                print("Error")
                return
            }
            
            DispatchQueue.global(qos: .userInitiated).async {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! Array<Any>
                    for dictionary in json as! [[String : AnyObject]]{
                        
                        let departmentDictionary = dictionary["directions"] as! [String : AnyObject]
                        
                        let name = departmentDictionary["dir_name"] as! String
                        let id = departmentDictionary["dir_id"] as! String
                        let image : UIImage
                        do{
                            
                            if let imageUrl = URL(string: departmentDictionary["dir_img"] as! String){
                                if let cachedImage = imageCache.cache.object(forKey: imageUrl as AnyObject) as! UIImage?{
                                    image = cachedImage
                                } else{
                                    let imageData = try Data(contentsOf: imageUrl)
                                    image = UIImage(data: imageData)!
                                    imageCache.cache.setObject(image, forKey: imageUrl as AnyObject)
                                }
                            } else {
                                image = #imageLiteral(resourceName: "raven_dir")
                            }
                            self.directionsArray.append((name, image, id))
                            
                        } catch{
                            image = #imageLiteral(resourceName: "raven_dir")
                            self.directionsArray.append((name, image, id))
                            print("Image Parsing Exception")
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.DepartmentsDirectionsViewController.reloadData()
                        self.activityIndicator.stopAnimating()
                    }
                    
                    
                } catch{
                    print("Serialization Exception")
                }
            }
            
            }.resume()
    }
    
    private func setCustomNavigationBar(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }

    private func setCommonNavigationBar(){
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }
   
    
}
