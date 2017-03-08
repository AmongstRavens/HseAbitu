//
//  FraternitiesListViewController.swift
//  HseAbitu
//
//  Created by Sergey on 12/9/16.
//  Copyright © 2016 Sergey. All rights reserved.
//

import UIKit

class FraternitiesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    private var organizationData : [(id: String, name: String, image: UIImage, mainText: String, link: String)] = [
        (id: "1", name: "Бизнес в стиле .RU", image: #imageLiteral(resourceName: "raven_dir"), mainText: "Мы — студенческая организация,  занимающаяся обучением студентов дизайну, web и ios разработке. уже более 11 лет, и также поддержкой других организаций  в сферах IT и образования.  На нашем счету уже более 20ти реализованных проектов за последние 3 года.Мы — студенческая организация,  занимающаяся обучением студентов дизайну, web и ios разработке. уже более 11 лет, и также поддержкой других организаций  в сферах IT и образования.  На нашем счету уже более 20ти реализованных проектов за последние 3 года.Мы — студенческая организация,  занимающаяся обучением студентов дизайну, web и ios разработке. уже более 11 лет, и также поддержкой других организаций  в сферах IT и образования.  На нашем счету уже более 20ти реализованных проектов за последние 3 года.Мы — студенческая организация,  занимающаяся обучением студентов дизайну, web и ios разработке. уже более 11 лет, и также поддержкой других организаций  в сферах IT и образования.  На нашем счету уже более 20ти реализованных проектов за последние 3 года.", link: "https://www.hse.ru/ba/bi"),
        (id: "1", name: "Бизнес в стиле .RU", image: #imageLiteral(resourceName: "raven_dir"), mainText: "Мы — студенческая организация,  занимающаяся обучением студентов дизайну, web и ios разработке. уже более 11 лет, и также поддержкой других организаций  в сферах IT и образования.  На нашем счету уже более 20ти реализованных проектов за последние 3 года.", link: "https://www.hse.ru/ba/bi"),
        (id: "1", name: "Бизнес в стиле .RU", image: #imageLiteral(resourceName: "raven_org"), mainText: "Мы — студенческая организация,  занимающаяся обучением студентов дизайну, web и ios разработке. уже более 11 лет, и также поддержкой других организаций  в сферах IT и образования.  На нашем счету уже более 20ти реализованных проектов за последние 3 года.", link: "https://www.hse.ru/ba/bi")
    ]
    
    internal var fraternityData : (id : String, name: String, image: UIImage)!
    
    @IBOutlet weak var organizationTableView: UITableView!
    @IBOutlet weak var fraternityImage: UIImageView!
    @IBOutlet weak var fraternityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fraternityLabel.text = self.fraternityData.name
        self.fraternityImage.image = self.fraternityData.image
        self.organizationTableView.separatorStyle = .none
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setCustomNavigationBar()
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let imageFilter = UIView()
        imageFilter.frame = CGRect(x: 0, y: 0, width: self.fraternityImage.bounds.size.width, height: self.fraternityImage.bounds.size.height)
        imageFilter.isOpaque = true
        imageFilter.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        fraternityImage.addSubview(imageFilter)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return organizationData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = organizationTableView.dequeueReusableCell(withIdentifier: "Organization Cell") as! OrganizationTableViewCell
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: organizationData[indexPath.row].link)
        attributeString.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(0, attributeString.length))
        cell.organizationImage.image = organizationData[indexPath.row].image
        cell.organizationLabel.text = organizationData[indexPath.row].name
        cell.organizationReference.attributedText = attributeString
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Show Organization Info", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! OrganizationInformationViewController
        let index = (sender as! IndexPath).row
        destinationVC.organizationInfoData = self.organizationData[index]
    }
    
    private func setCustomNavigationBar(){
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
   
}
