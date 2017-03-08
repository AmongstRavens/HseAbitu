//
//  OrganizationViewController.swift
//  HseAbitu
//
//  Created by Sergey on 11/13/16.
//  Copyright © 2016 Sergey. All rights reserved.
//

import UIKit

class OrganizationViewController: UIViewController {
    
    @IBOutlet weak var infoAssets: UIImageView!
    @IBOutlet weak var organizationName: UILabel!
    var name : String?
    @IBOutlet weak var viewText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let infoString : String = "Мы — студенческая организация,  занимающаяся обучением студентов дизайну, web и ios разработке. уже более 11 лет, и также поддержкой других организаций  в сферах IT и образования.  На нашем счету уже более 20ти реализованных проектов за последние 3 года."
        viewText.text = infoString
        let symbolsInSingleLine = 20
        viewText.numberOfLines = infoString.characters.count / symbolsInSingleLine
        
        
        
        
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
