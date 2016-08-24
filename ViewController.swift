//
//  ViewController.swift
//  MapDemo
//
//  Created by Felicia Weathers on 8/22/16.
//  Copyright © 2016 Felicia Weathers. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        var latitude:CLLocationDegrees = 43.095181
        var longitude:CLLocationDegrees = -79.006424
        
        var latDelta:CLLocationDegrees = 0.05
        var longDelta:CLLocationDegrees = 0.05
        
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        map.setRegion(region, animated: false)
        
        var annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Niagara Falls"
        annotation.subtitle = "One day I will go here..."
        
        map.addAnnotation(annotation)
    
        
        var uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.action(gestureRecognizer:)))
        uilpgr.minimumPressDuration = 2
        
        map.addGestureRecognizer(uilpgr)
    }
    
    func action(gestureRecognizer: UILongPressGestureRecognizer) {
        
        print("Gesture recognized")
        
        var touchPoint = gestureRecognizer.location(in: self.map)
        
        var newCoordinate:CLLocationCoordinate2D = map.convert(touchPoint, toCoordinateFrom: self.map)
        
        var annotation = MKPointAnnotation()
        annotation.coordinate = newCoordinate
        annotation.title = "New Adventures Await"
        annotation.subtitle = "One day I will go here..."
        
        map.addAnnotation(annotation)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations)
        
        var userLocation: CLLocation = locations[0]
        
        var latitude = userLocation.coordinate.latitude
        var longitude = userLocation.coordinate.longitude
        
        var latDelta:CLLocationDegrees = 0.05
        var longDelta:CLLocationDegrees = 0.05
        
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        self.map.setRegion(region, animated: false)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

