//
//  BuildingMarkerView.swift
//  HseAbitu
//
//  Created by Ирина Улитина on 01/02/2019.
//  Copyright © 2019 Sergey. All rights reserved.
//

import Foundation
import MapKit

class BuildingMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let artwork = newValue as? HSEBuilding else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            // 2
            markerTintColor = artwork.markerTintColor
            
            ///!!!!
            //self.image = UIImage(named: "AppIcon")
            glyphText = String(artwork.type.first!)
        }
    }
}

class BuildingView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let artwork = newValue as? HSEBuilding else {return}
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            image = UIImage(named: artwork.imageName)
            
        }
    }
}
