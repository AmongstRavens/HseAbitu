//
//  FraternitiesViewController.swift
//  HseAbitu
//
//  Created by Sergey on 10/27/16.
//  Copyright © 2016 Sergey. All rights reserved.
//

import UIKit
import Foundation

class FraternitiesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private var fraternityData = [(String, String, UIImage)]()
    private var navigationBarShadowImage : UIImage?
    
    @IBOutlet weak var fraternityCollectionView: UICollectionView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFraternities()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.activityIndicator.layer.zPosition = 10
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationBarShadowImage = self.navigationController?.navigationBar.shadowImage
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
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Fraternity Cell", for: indexPath) as! FraternityCollectionViewCell
        cell.fraternityName.text = fraternityData[indexPath.row].1
        cell.fraternityName.textColor = UIColor.white
        cell.fraternityImage.image = fraternityData[indexPath.row].2
        
        if cell.didAddedImageFilter == false{
            let imageFilter = UIView()
            imageFilter.frame = CGRect(x: 0, y: 0, width: cell.bounds.size.width, height: cell.bounds.size.height)
            imageFilter.isOpaque = true
            imageFilter.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            cell.fraternityImage.addSubview(imageFilter)
            cell.didAddedImageFilter = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fraternityData.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if fraternityData.count - 1 == indexPath.row && indexPath.row % 2 == 0{
            return CGSize(width: view.frame.width, height: view.frame.width / 2)
        } else{
            return CGSize(width: view.frame.width / 2, height: view.frame.width / 2)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Show Organizations", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let desinationVC = segue.destination as! FraternitiesListViewController
        let index = (sender as! IndexPath).row
        desinationVC.fraternityData = self.fraternityData[index]
    }
    
    private func fetchFraternities(){
        let url = URL(string: "http://abitir.styleru.net/api/getAllOrganizationGroup")
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
                        let name = dictionary["name"] as! String
                        let id = dictionary["id"] as! String
                        let image : UIImage!
                        do{
                            if let imageUrl = URL(string: dictionary["org_img"] as! String){
                                if let cachedImage = imageCache.cache.object(forKey: imageUrl as AnyObject) as! UIImage?{
                                    image = cachedImage
                                } else {
                                    let imageData = try Data(contentsOf: imageUrl)
                                    image = UIImage(data: imageData)
                                    imageCache.cache.setObject(image, forKey: imageUrl as AnyObject)
                                }
                            } else{
                                image = #imageLiteral(resourceName: "raven_org")
                                print("Invalid URL")
                            }
                        } catch{
                            image = #imageLiteral(resourceName: "raven_org")
                            print("Image Parsing Exception")
                        }
                        self.fraternityData.append((id, name, image))
                    }
                    
                    
                    DispatchQueue.main.async {
                        self.fraternityCollectionView.reloadData()
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
