//
//  HSEBuilding.swift
//  HseAbitu
//
//  Created by Ирина Улитина on 01/02/2019.
//  Copyright © 2019 Sergey. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class HSEBuilding: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    
    var locationName: String
    //мясницкая, кочна или тп
    var title: String?
    
    var subdivisions: [String]?
    
    var type: String
    
    init(coords: CLLocationCoordinate2D, title: String, locationName: String, subdivisions: [String]?, type: String) {
        coordinate = coords
        self.title = title
        self.subdivisions = subdivisions
        self.type = type
        self.locationName = locationName
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
    
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = subtitle
        return mapItem
    }
    
    
    var markerTintColor: UIColor  {
        switch type {
        case "StudyBuilding":
            return .red
        case "Hall of resedence":
            return .cyan
        default:
            return .green
        }
    }
    
    var imageName: String {
        switch type {
        case "StudyBuilding":
            return "buildingIcon"
        case "Hall of resedence":
            return "resedenceIcon"
        default:
            return "AppIcon"
        }
    }
}
