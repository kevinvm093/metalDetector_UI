//
//  data_viewController.swift
//  metalDetector_UI
//
//  Created by Kevin Vallejo on 5/29/18.
//  Copyright © 2018 Vallejo. All rights reserved.
//

import Cocoa
import FirebaseCore
import FirebaseDatabase
import FirebaseAuth

class data_viewController: NSViewController {
    
    var handle:DatabaseHandle?
    var ref:DatabaseReference?
    var coords = [LOCATION]()
    
    var dict = [String: LOCATION]()
    let manager = CLLocationManager();
    

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        self.fetchCoords()
        // Do view setup here.
    }
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
    

    
}
