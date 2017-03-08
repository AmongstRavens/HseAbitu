//
//  EventsCollectionViewController.swift
//  HseAbitu
//
//  Created by Sergey on 11/22/16.
//  Copyright © 2016 Sergey. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class EventsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    var isNeededToReload : Bool!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var eventsCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    private let veilView = UIView()
    private var navigationBarShadowImage : UIImage?

    
    private var eventsData = [(id: String, title : String, text : String, image : UIImage, place : String, date : String)]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isNeededToReload = true
        activityIndicator.layer.zPosition = 10
        collectionViewFlowLayout.minimumLineSpacing = 30
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationBarShadowImage = self.navigationController?.navigationBar.shadowImage
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
        setCommonNavigationBar()
        if self.isNeededToReload == true{
            fetchEvents()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.shadowImage = self.navigationBarShadowImage
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.isNeededToReload = false
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.eventsData.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Event Cell", for: indexPath) as! EventCollectionViewCell
        cell.eventMainText.text = eventsData[indexPath.row].title
        cell.dateLabel.text = eventsData[indexPath.row].date
        cell.placeLabel.text = eventsData[indexPath.row].place
        cell.backgroundImage.image = eventsData[indexPath.row].image
        

        if (cell.didAddedFilterToImageView == false){
            let imageFilter = UIView()
            imageFilter.frame = CGRect(x: 0, y: 0, width: cell.bounds.size.width, height: cell.bounds.size.height)
            imageFilter.isOpaque = true
            imageFilter.backgroundColor = UIColor.black.withAlphaComponent(0.65)
            cell.backgroundImage.addSubview(imageFilter)
            cell.didAddedFilterToImageView = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: eventsCollectionView.bounds.size.width, height: eventsCollectionView.bounds.size.width * (4 / 6))
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Show Event Information", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Filter View"{
            setCustomNavigationBar()
        }
        if segue.identifier == "Show Event Information"{
            let destinationVC = segue.destination as! NewsInformationViewController
            let transferData = self.eventsData[(sender as! IndexPath).row]
            destinationVC.eventData = transferData
        }
        
    }
    
    private func fetchEvents(){
        self.activityIndicator.startAnimating()
        
        self.eventsData.removeAll()
        self.eventsCollectionView.reloadData()
        
        let url = URL(string: "http://abitir.styleru.net/api/getAllArticles")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                print(error!)
                return
            }
            
            DispatchQueue.global(qos: .userInitiated).async {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! Array<Any>
                    for dictionary in json as! [[String : String]]{
                        let articleImage : UIImage
                        if let imageUrl = URL(string: dictionary["article_file"]!){
                            if let cachedImage = imageCache.cache.object(forKey: imageUrl as AnyObject) as! UIImage?{
                                articleImage = cachedImage
                            } else{
                                do{
                                    let imageData = try Data(contentsOf: imageUrl)
                                    articleImage = UIImage(data: imageData)!
                                    imageCache.cache.setObject(articleImage, forKey: imageUrl as AnyObject)
                                }
                                catch{
                                    articleImage = #imageLiteral(resourceName: "raven_org")
                                }
                            }
                        } else {
                            articleImage = #imageLiteral(resourceName: "raven_org")
                        }
                        
                        if newsFilter.isFilterON() == false{
                            self.eventsData.append((id: dictionary["article_id"]!, title: dictionary["article_title"]!,
                                                    text : dictionary["article_text"]!,
                                                    image : articleImage,
                                                    place : dictionary["article_place"]!,
                                                    date : dictionary["article_date"]!))
                        } else{
                            if (dictionary["articles_filter"]! >= "0" &&  dictionary["articles_filter"]! <= "4" && newsFilter.filterMask[dictionary["articles_filter"]!]!){
                                self.eventsData = [(id: dictionary["article_id"]!,title: dictionary["article_title"]!,
                                                    text : dictionary["article_text"]!,
                                                    image : articleImage,
                                                    place : dictionary["article_place"]!,
                                                    date : dictionary["article_date"]!)]
                            }
                        }
                    }
                    
                }
                catch{
                    print("Unable to read data from url")
                    return
                }
                
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.eventsCollectionView.reloadData()
                }
            }
            
            
            
            
        }
        task.resume()
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
