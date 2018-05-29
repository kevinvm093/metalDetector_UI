//
//  Map_veiwController.swift
//  metalDetector_UI
//
//  Created by Kevin Vallejo on 5/26/18.
//  Copyright © 2018 Vallejo. All rights reserved.
//

import Cocoa
import FirebaseCore
import FirebaseDatabase
import FirebaseAuth
import MapKit
import CoreLocation

class Map_veiwController: NSViewController, MKMapViewDelegate,CLLocationManagerDelegate
{

    var handle:DatabaseHandle?
    var ref:DatabaseReference?
    var coords = [LOCATION]()

    var dict = [String: LOCATION]()
    let manager = CLLocationManager();
    
    var count:Int = 0
    
    func fetchCoords()
    {
        handle = ref?.child("maps").observe(DataEventType.childAdded, with: { (DataSnapshot) in
            if let Dictionary  = DataSnapshot.value as? [String: AnyObject]
            {
                print(Dictionary)
                print(DataSnapshot)
                let loc = LOCATION()
                let latitude = Dictionary["Latitude"]
                let longitude = Dictionary["Longitude"]
                let id = Dictionary["ID"]
                let acc = Dictionary["Accuracy"]
                
                
                
                loc.lat = latitude as? String
                loc.lng = longitude as? String
                loc.id = id as? String
                loc.accuracy = acc as? String
                
                
                self.coords.append(loc)
               
            }
            self.setPins(last: self.coords.last!)
      
        })
    }
   
    
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do view setup here.
        
        ref = Database.database().reference()
        self.fetchCoords()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
        
    }
    
    
    func setPins(last: LOCATION)
    {
        /*
         ****Fuction is called after everytime new data is fetched from the database****
         */
        
        print("******Setting pin on metallic object number #: ******", last.id!)
        
        
    
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
        let loc:CLLocationCoordinate2D = CLLocationCoordinate2DMake(Double(last.lat!)!, Double(last.lng!)!)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(loc, span)
        mapView.setRegion(region, animated: true)
        let pin = MKPointAnnotation()
        pin.coordinate = loc
        pin.title = "Metal object: "
        pin.title?.append(last.id!)
        pin.subtitle = "Accuracy: "
        pin.subtitle?.append(last.accuracy!)
        mapView.addAnnotation(pin)
    }
 
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let current = locations[0]
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.1,0.1)
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(current.coordinate.latitude, current.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        mapView.setRegion(region, animated: true)
        self.mapView.showsUserLocation = true
     
        
    }
   
}
