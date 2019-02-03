//
//  BuildingDetailView.swift
//  HseAbitu
//
//  Created by Ирина Улитина on 01/02/2019.
//  Copyright © 2019 Sergey. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class BuildingDetailView : UIView {
    var once: Bool! = false
    var blurTopAnchor : NSLayoutYAxisAnchor!
    var blurBottomAnchor : NSLayoutYAxisAnchor!
    
    lazy var blurContainerView : UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let v = UIVisualEffectView(effect: blurEffect)
        v.alpha = 0.8
        //v.backgroundColor = UIColor.init(white: 1.0, alpha: 0.2)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        gesture.numberOfTapsRequired = 1
        v.addGestureRecognizer(gesture)
        //v.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return v
    }()
    
    let addressLabel : IndentLabel = {
        let label = IndentLabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let detailInfoPlaceholder : IndentLabel = {
        let label = IndentLabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.lightGray
        label.text = "Подробнее:"
        return label
    }()
    
    let detailInfoTextLabel : IndentLabel = {
        let label = IndentLabel(padding: UIEdgeInsets.zero)
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = -1
        return label
    }()
    
    let buildingImageView : CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let imageContainerView : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        v.alpha = 1
        return v
    }()
    
    lazy var showOnMapButton : UIButton = {
        let button = UIButton()
        button.setTitle("Show on Map", for: .normal)
        let iv = UIImageView(image: #imageLiteral(resourceName: "AppleMaps_logo.svg"))
        iv.contentMode = .scaleAspectFit
        button.addSubview(iv)
        button.backgroundColor = UIColor.green
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        iv.anchor(top: button.topAnchor, left: nil, bottom: button.bottomAnchor, right: button.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 5, paddingRight: 5, width: 0, height: 0)
        iv.widthAnchor.constraint(equalTo: iv.heightAnchor, multiplier: 1).isActive = true
        button.addTarget(self, action: #selector(openOnMap), for: .touchUpInside)
        return button
    }()
    
    @objc func openOnMap() {
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        building.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
    @objc func handleTap(gesture: UITapGestureRecognizer) {
        if (contView.frame.contains(gesture.location(in: blurContainerView))) {
            return
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            self.frame = CGRect(x: 0, y: -self.frame.height, width: self.frame.width, height: self.frame.height)
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    let contView : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        v.clipsToBounds = true
        v.layer.cornerRadius = 10
        v.alpha = 1
        return v
    }()
    
    var building : HSEBuilding! {
        didSet {
            addressLabel.text = building.locationName
            buildingImageView.image = UIImage(named: "Buisness_career")
            detailInfoTextLabel.text = "Тут должно быть очень много тексста чтобы потестить вот так вот получилось извиняйте ваваыа ывамцгУШРТкшгцмтрагшмцтазшмтшаггМРАм зам "
        }
    }
    
    func animeBlock(const: CGFloat) {
        blurBottomAnchor = blurContainerView.bottomAnchor
        blurTopAnchor = blurContainerView.topAnchor
        //!!!
        blurContainerView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        blurContainerView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(blurContainerView)
        blurContainerView.translatesAutoresizingMaskIntoConstraints = false
        animeBlock(const: frame.height)
        blurContainerView.contentView.addSubview(contView)
        
        
        imageContainerView.addSubview(buildingImageView)
        buildingImageView.anchor(top: imageContainerView.topAnchor, left: nil, bottom: imageContainerView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: 0, height: 0)
        buildingImageView.widthAnchor.constraint(equalTo: buildingImageView.heightAnchor, multiplier: 1).isActive = true
        buildingImageView.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [imageContainerView, addressLabel, detailInfoPlaceholder, detailInfoTextLabel, showOnMapButton])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        
        for el in stackView.arrangedSubviews {
            el.translatesAutoresizingMaskIntoConstraints = false
        }
        
        imageContainerView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.25).isActive = true
        addressLabel.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.11).isActive = true
        detailInfoPlaceholder.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.07).isActive = true
        detailInfoTextLabel.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.45).isActive = true
        
        
        blurContainerView.contentView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.centerXAnchor.constraint(equalTo: blurContainerView.contentView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: blurContainerView.contentView.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: blurContainerView.contentView.widthAnchor, multiplier: 0.7).isActive = true
        stackView.heightAnchor.constraint(equalTo: blurContainerView.contentView.heightAnchor, multiplier: 0.5).isActive = true
        contView.anchor(top: stackView.topAnchor, left: stackView.leftAnchor, bottom: stackView.bottomAnchor, right: stackView.rightAnchor, paddingTop: -8, paddingLeft: -8, paddingBottom: -8, paddingRight: -8, width: 0, height: 0)
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print(self.frame)
        //blurTopAnchor.constraint(equalTo: self.topAnchor).isActive = true
        //blurBottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        buildingImageView.layer.cornerRadius = buildingImageView.frame.width / 2
        ///!!!!
        if (!once) {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                self.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
            }, completion: nil)
            once = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
