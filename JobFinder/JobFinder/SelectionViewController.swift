//
//  SelectionViewController.swift
//  JobFinder
//
//  Created by Rana Alhaj on 2/8/19.
//  Copyright © 2019 ProgressSoft. All rights reserved.
//

import UIKit
import SelectionList
import CoreLocation
import GooglePlaces


class SelectionViewController: UIViewController {

    var delegate: FilterFinishDelegate?
    var loaction : CLLocation!
    var placeName : String!
    
    @IBOutlet var providersSelectionList: SelectionList! //multi selection list
    @IBOutlet var locationSelectionList: SelectionList! //single selection list
    
    @IBOutlet var placeNameLabel: UILabel!
    
    let locationManager = CLLocationManager()
    var prevSelectedProviders : [Int]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLocationManager()
        initProvidersSelectionList()
        initLocationSelectionList()
        
    }
    
    
    func initProvidersSelectionList(){
        // init the providers list from JOBFINDER_ALL_PROVIDERS_NAMES constant
        providersSelectionList.items = JOBFINDER_ALL_PROVIDERS_NAMES
        providersSelectionList.allowsMultipleSelection = true
        providersSelectionList.selectedIndexes = prevSelectedProviders
        providersSelectionList.addTarget(self, action: #selector(providersSelectionChanged), for: .valueChanged)
        providersSelectionList.setupCell = { (cell: UITableViewCell, _: Int) in
            cell.textLabel?.textColor = .gray
        }
    }
        
    
    func initLocationSelectionList(){
        //init loaction options list
        locationSelectionList.items = LOCATIONS_SELECTION_OPTIONS_TITLES
        locationSelectionList.allowsMultipleSelection = false
        
        locationSelectionList.addTarget(self, action: #selector(locationSelectionChanged), for: .valueChanged)
        locationSelectionList.setupCell = { (cell: UITableViewCell, _: Int) in
            cell.textLabel?.textColor = .gray
        }
    }
    
    
    @objc func providersSelectionChanged() {
        print(providersSelectionList.selectedIndexes)
    
       
    }
    
    
    @objc func locationSelectionChanged(){
        
        print(locationSelectionList.selectedIndexes)
        // cuurent location is selected
        if (locationSelectionList.selectedIndexes.count != 0){
            if (locationSelectionList.selectedIndexes[0] == CURRENTLOCATION_INDEX){
                isAuthorizedtoGetUserLocation()
                initLocationManager()
                placeNameLabel.text = ""
                placeName = nil
            }else {// google place is selected
                let  autocompleteController =  GMSAutocompleteViewController ()
                autocompleteController.delegate = self
                // Specify the place data types to return.
                let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
                    UInt(GMSPlaceField.placeID.rawValue))!
                autocompleteController.placeFields = fields
                
                // Specify a filter.
                let filter = GMSAutocompleteFilter()
                filter.type = .address
                autocompleteController.autocompleteFilter = filter

                present(autocompleteController , animated: true, completion: nil)
                
            }
        }
    }
    
    func isAuthorizedtoGetUserLocation() {
        
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse     {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
    @IBAction func cancelSelection(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func initLocationManager(){
        
        isAuthorizedtoGetUserLocation()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
       
    }

    //Seach button will call the delagate to finish this controller and getback to the parent with passed data
    @IBAction func startSearch(_ sender: Any) {
        
        var latlong : String!
        //Loaction or places
        if (locationSelectionList.selectedIndexes.count != 0){
            if (locationSelectionList.selectedIndexes[0] == CURRENTLOCATION_INDEX){
                if CLLocationManager.locationServicesEnabled() {
                    locationManager.requestLocation()
                   latlong =  String(loaction.coordinate.latitude) + ","  + String(loaction.coordinate.longitude)
                    placeName = nil
                }
                
            }else if  (locationSelectionList.selectedIndexes[0] == LOCATION_BY_ADDRESS_NAME_INDEX){
                latlong = nil
            }
        }
      
        
        delegate?.didFinishFilter(self, selectedProvidersIndex : providersSelectionList.selectedIndexes, currentLoactionPoint: latlong, placeName: placeName)
        
        self.dismiss(animated: true, completion: nil)
    }
}


//CLLocationManagerDelegate to get current loaction
extension SelectionViewController : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            print("User allowed us to access location")
           
        }
    }

    //this method is called by the framework on         locationManager.requestLocation();
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Did location updates is called")
        loaction = locations[locations.count - 1]
      
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Did location updates is called but failed getting location \(error)")
    }
}


//GMSAutocompleteViewControllerDelegate to get the searched place 
extension SelectionViewController :  GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        dismiss(animated: true, completion: nil)
        
        placeName = place.name
        placeNameLabel.text = placeName
        
        print("Place name: \(place.name)")
        print("Place ID: \(place.placeID)")
        print("Place attributions: \(place.attributions)")
        //dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
        //self.navigationController?.popViewController(animated: true)
        
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

}
