//
//  LogoDownloaderDelegate.swift
//  JobFinder
//
//  Created by Rana Alhaj on 2/8/19.
//  Copyright © 2019 ProgressSoft. All rights reserved.
//


import Foundation

import UIKit

//
// This is the DELEGATE PROTOCOL
//
protocol FilterFinishDelegate {
    // This delegate use to pass data  to the parent view controller 
    func didFinishFilter(_ sender : SelectionViewController, selectedProvidersIndex indexes:  [Int] , currentLoactionPoint  location : String! , placeName name: String!)
}
