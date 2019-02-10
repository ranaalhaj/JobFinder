//
//  ViewController.swift
//  JobFinder
//
//  Created by Apple User on 2/5/19.
//  Copyright © 2019 ProgressSoft. All rights reserved.
//

import UIKit
import CoreLocation
import SelectionList


class ViewController: UIViewController {

    
    @IBOutlet var selectionList: SelectionList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLocationManager()
        initSelectionList()
        
        
    }


    func initSelectionList(){
    
        
        selectionList.items = ["One", "Two", "Three", "Four", "Five"]
        selectionList.selectedIndexes = [0, 1, 4]
        selectionList.allowsMultipleSelection = true
        selectionList.addTarget(self, action: #selector(selectionChanged), for: .valueChanged)
        selectionList.setupCell = { (cell: UITableViewCell, _: Int) in
            cell.textLabel?.textColor = .gray
        }
    }
        
        
        @objc func selectionChanged() {
            print(selectionList.selectedIndexes)
            //        selectionList.items.append("\(selectionList.selectedIndexes)")
            //        selectionList.selectedIndexes = [0, 2, 4]
        }
        
    func initLocationManager(){
        let locationManager = CLLocationManager()
        //locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //let locValue:CLLocationCoordinate2D = manager.location!.coordinate
       // print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    
}


/*extension ViewController : CLLocationManagerDelegate{
    
    
    
    
}
*/
