//
//  AppDelegate.swift
//  metalDetector_UI
//
//  Created by Kevin Vallejo on 5/25/18.
//  Copyright © 2018 Vallejo. All rights reserved.
//

import Cocoa
import FirebaseCore



@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


   
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        FirebaseApp.configure()
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

