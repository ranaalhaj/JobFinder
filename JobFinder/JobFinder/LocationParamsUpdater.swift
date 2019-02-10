//
//  Pagintaions.swift
//  JobFinder
//
//  Created by Rana Alhaj on 2/7/19.
//  Copyright © 2019 ProgressSoft. All rights reserved.
//

import Foundation

 
//This class is to add or update Loaction params for each provider depends on the apis
//When add anew provider you should implement a new funv to get it's params

class LoactionParamsUpdater {
    
    class func getLoactioParameters(forProviderAtindex index:NSInteger,currentLoaction location: String, currentParams params: [String : Any]! ) ->  [String : Any] {
        
        var updatedParams:  [String : Any]!
        
        if (index == GITHUB_INDEX){
            updatedParams =  getGithiubLoactioParams(_: location , currentParams: params)
        }else if(index == SEARCH_GOV_INDEX){
            updatedParams = getSearchGovLoactioParams(_ :  location, currentParams: params)
        }
        return updatedParams
    }
    
  //GitHub
    class private func getGithiubLoactioParams(_ location: String, currentParams params: [String : Any]!)->  [String : Any] {
      
        //lat=""&long=""
        var updatedParams  = params
        if (updatedParams == nil){
            updatedParams =  [String : Any]()
        }
        
        
        let loc = location.split(separator: ",") as [String.SubSequence]
        let latitude = String(loc[0]) as String
        let longtitude = String(loc[1]) as String
        
        if (latitude != "" &&  longtitude != ""){
            if updatedParams!["lat"] != nil {//update available value
                updatedParams!.updateValue(latitude, forKey: "lat")
                
            }else{ //add for first time
                updatedParams!["lat"] = latitude
            }
            
            if updatedParams!["long"] != nil {//update available value
                updatedParams!.updateValue(longtitude , forKey: "long")
                
            }else { //add for first time
                updatedParams!["long"] = longtitude
            }
        }
        return updatedParams!
    }
    
    
    //SearchGov
     class private func getSearchGovLoactioParams(_ location: String, currentParams params: [String : Any]!)->  [String : Any] {
        //‘lat_lon=37.783333,-122.416667’
        
        var updatedParams  = params
        
        if (updatedParams == nil){
            updatedParams =  [String : Any]()
        }
        
        if updatedParams!["lat_lon"] != nil {
            updatedParams!.updateValue(location , forKey: "lat_lon")
        }else{ //add for first time
            updatedParams!["lat_lon"] = location
        }
        
        return updatedParams!
        
    }

}
