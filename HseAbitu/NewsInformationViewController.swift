//
//  NewsInformationViewController.swift
//  HseAbitu
//
//  Created by Sergey on 12/19/16.
//  Copyright © 2016 Sergey. All rights reserved.
//

import UIKit

class NewsInformationViewController: UIViewController {

    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventPlace: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventContent: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    internal var eventData : (id: String, title : String, text : String, image : UIImage, place : String, date : String)?
    private var registerButtonWidth : CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleData(data: eventData)
        addRegisterButton()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addBlackLines()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    @objc private func register(sender : UIButton){
        let url = URL(string: "https://www.hse.ru")
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(NSURL(string:"https://www.hse.ru") as! URL)
        }
        
        
    }
    
    
    private func addBlackLines(){
        let topLine = UIView()
        topLine.frame = CGRect(x: self.mainView.bounds.size.width - (registerButtonWidth! + 30), y: 0, width: registerButtonWidth! + 30, height: 2)
        topLine.backgroundColor = UIColor.black
        
        let leftLine = UIView()
        leftLine.backgroundColor = UIColor.black
        leftLine.frame = CGRect(x: 15, y: self.eventTitle.bounds.size.height + 25, width: 2, height: self.mainView.bounds.size.height - self.eventTitle.bounds.size.height + 20)
        
        self.view.addSubview(leftLine)
        self.view.addSubview(topLine)
    }
    
    private func addRegisterButton(){
        let button = UIButton(type: .custom)
        button.setTitle("Регистрация", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.layer.backgroundColor = UIColor.black.cgColor
        button.layer.cornerRadius = 12.0
        button.sizeToFit()
        button.bounds.size.width *= 3/2
        button.addTarget(self, action: #selector(NewsInformationViewController.register(sender:)), for: .touchUpInside)
        registerButtonWidth = button.bounds.size.width
        let registerButton = UIBarButtonItem(customView: button)
        
        self.navigationItem.rightBarButtonItem = registerButton
    }
    
    
    private func handleData(data : (id: String, title : String, text : String, image : UIImage, place : String, date : String)? ){
        guard data != nil else{
            print("Empty Data")
            return
        }
    
        self.eventImage.image = data!.image
        self.eventTitle.text = data!.title
        eventTitle.sizeToFit()
        self.eventContent.text = data!.text
        self.eventPlace.text = data!.place
        self.eventDate.text = data!.date
        
    }


}
