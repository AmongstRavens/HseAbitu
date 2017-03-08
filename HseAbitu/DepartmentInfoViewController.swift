//
//  DepartmentInfoViewController.swift
//  HseAbitu
//
//  Created by Sergey on 12/20/16.
//  Copyright © 2016 Sergey. All rights reserved.
//
import UIKit

class DepartmentInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var buttonsTopConstraintsCollection: [NSLayoutConstraint]!
    @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var tableViewsHeightConstraintCollection: [NSLayoutConstraint]!
    @IBOutlet var tableViewsCollection: [UITableView]!
    @IBOutlet var buttonsCollection: [UIButton]!
    
    private var buttonHeight : CGFloat!
    private var maxValueForTableViewHeight : CGFloat = 2000
    private var calculatedValueForTableViewHeightConstraint : CGFloat = 0
    private var heightConstraintsCalculatedValues : [CGFloat] = [
        0, 0, 0, 0, 0
    ]
    
    internal var departmentName : String!
    internal var data = [[String]](repeating: [""], count: 5)

    

    override func viewDidLoad() {
        self.titleLabel.text = self.departmentName
        firstRunSettup()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setCommonNavigationBar()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addBlackLines()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[tableViewsCollection.index(of: tableView) ?? 0].count + 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Info Cell") as! DepartmentInfoTableViewCell
        
        let index = tableViewsCollection.index(of: tableView)!
        self.calculatedValueForTableViewHeightConstraint += cell.bounds.size.height
        
        if indexPath.row == data[index].count + 1{
            heightConstraintsCalculatedValues[index] = calculatedValueForTableViewHeightConstraint
            tableViewsHeightConstraintCollection[index].constant = 0
            calculatedValueForTableViewHeightConstraint = 0
        }
        
        if indexPath.row != data[index].count + 1 && indexPath.row != 0{
            cell.label.text = data[index][indexPath.row - 1]
        } else {
            cell.label.text = ""
        }
        return cell
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let index = buttonsCollection.index(of: sender) ?? 0
        if tableViewsHeightConstraintCollection[index].constant == 0{
            tableViewsHeightConstraintCollection[index].constant = heightConstraintsCalculatedValues[index]
            setShadowOnTableView(inputTableView: tableViewsCollection[index])
            contentViewHeightConstraint.constant += tableViewsHeightConstraintCollection[index].constant
            if index < self.buttonsCollection.count - 1{
                buttonsTopConstraintsCollection[index].constant -= buttonsCollection[index].bounds.size.height / 2
            }
        } else {
            let temp = tableViewsHeightConstraintCollection[index].constant
            offsetShadowFromTableView(inputTableView: tableViewsCollection[index])
            tableViewsHeightConstraintCollection[index].constant = 0
            contentViewHeightConstraint.constant -= temp
            if index < self.buttonsCollection.count - 1{
                buttonsTopConstraintsCollection[index].constant += buttonsCollection[index].bounds.size.height / 2
            }
        }
    }
    
    private func setShadowOnTableView(inputTableView : UITableView){
        inputTableView.layer.masksToBounds = false
        inputTableView.layer.shadowRadius = 5
        inputTableView.layer.shadowColor = UIColor.black.cgColor
        inputTableView.layer.shadowOpacity = 0.5
    }
    
    
    private func offsetShadowFromTableView(inputTableView : UITableView){
        inputTableView.layer.masksToBounds = true
        inputTableView.layer.shadowRadius = 0
    }
    
    
    private func addBlackLines(){
        let topLine = UIView()
        topLine.frame = CGRect(x: self.scrollView.bounds.size.width - (self.scrollView.bounds.size.width * 1/5), y: 0, width: self.scrollView.bounds.size.width * 1/5, height: 2)
        topLine.backgroundColor = UIColor.black
        
        let leftLine = UIView()
        leftLine.backgroundColor = UIColor.black
        leftLine.frame = CGRect(x: 10, y: self.titleLabel.bounds.size.height + 40, width: 2, height: self.scrollView.bounds.size.height + 100)
        leftLine.layer.zPosition = 2
        self.view.addSubview(leftLine)
        self.view.addSubview(topLine)
    }
    
    private func setCustomNavigationBar(){
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func setCommonNavigationBar(){
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
    private func firstRunSettup(){
        var buttonsCommonHeight : CGFloat = 0
        for tableView in tableViewsCollection{
            tableView.alwaysBounceVertical = false
            tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
            tableView.separatorStyle = UITableViewCellSeparatorStyle.none
            tableView.layer.zPosition = -1
            tableView.allowsSelection = false
            tableView.estimatedRowHeight = 30
            tableView.rowHeight = UITableViewAutomaticDimension
        }
        
        for heightConstraint in tableViewsHeightConstraintCollection{
            heightConstraint.constant = maxValueForTableViewHeight
        }
        for button in buttonsCollection{
            button.layer.masksToBounds = false
            button.layer.shadowRadius = 3
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOpacity = 0.8
            buttonsCommonHeight += button.bounds.size.height
        }
        
        contentViewHeightConstraint.constant = buttonsCommonHeight * 3/2
    }
    

}
