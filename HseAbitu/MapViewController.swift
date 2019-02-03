//
//  MapViewController.swift
//  HseAbitu
//
//  Created by Sergey on 10/27/16.
//  Copyright © 2016 Sergey. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var mapView: MKMapView!
    
    var timer : Timer?
    
    let initialLocation = CLLocation(latitude: 55.7558, longitude: 37.6173)
    let regionRadius : CLLocationDistance = 10000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        mapView.register(BuildingMarkerView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        MapInit(coords: initialLocation)
        mapView.addAnnotation(HSEBuilding(coords: CLLocationCoordinate2D(latitude: 55.759370, longitude: 37.636392), title: "Департамент психологии", locationName: "Армянский переулок, д. 4, стр. 2", subdivisions: nil, type: "StudyBuilding"))
        mapView.register(BuildingView.self,
                        forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.delegate = self
    }
    
    func MapInit(coords: CLLocation) {
        let coordRegion = MKCoordinateRegionMakeWithDistance(coords.coordinate, regionRadius, regionRadius)
        
        mapView.setRegion(coordRegion, animated: true)
    }

}

extension MapViewController : MKMapViewDelegate {
    //@available(iOS 11.0, *)
    /*func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let building = annotation as? HSEBuilding else { return nil }
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        
        if let dequedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequedView.annotation = building
            view = dequedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }*/
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        control.isEnabled = false
        let location = view.annotation as! HSEBuilding
        /*let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)*/
        let frame = self.navigationController!.view.frame
        let newframe = CGRect(x: 0, y: -frame.height, width: frame.width, height: frame.height)
        let detailView = BuildingDetailView(frame: newframe)
        detailView.building = location
        self.navigationController?.view.addSubview(detailView)
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            control.isEnabled = true
        })
    }
}
