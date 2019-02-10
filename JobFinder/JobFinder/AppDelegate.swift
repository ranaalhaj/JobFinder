//
//  AppDelegate.swift
//  JobFinder
//
//  Created by Rana Alhaj on 2/5/19.
//  Copyright © 2019 ProgressSoft. All rights reserved.
//

import UIKit
import GooglePlaces


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //GooglePlaces
        GMSPlacesClient.provideAPIKey(GOOGLEMAP_KEY)
       
        
        //Change App Appearance
        UINavigationBar.appearance().barTintColor = UIColor(red:  30.0/255.0, green: 140/255.0, blue: 233/255.0, alpha: 100.0/255.0)
      
        UINavigationBar.appearance().tintColor = UIColor.white
   
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
     
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
       
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
       
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
      
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
       
    }


}

