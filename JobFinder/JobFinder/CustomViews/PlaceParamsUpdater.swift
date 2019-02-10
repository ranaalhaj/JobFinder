//
//  Pagintaions.swift
//  JobFinder
//
//  Created by Rana Alhaj on 2/7/19.
//  Copyright © 2019 ProgressSoft. All rights reserved.
//

import Foundation

 

//This class is to add or update Places params for each provider depends on the apis
//When add anew provider you should implement a new funv to get it's params

class PlaceParamsUpdater {
    
    class func getPlaceParameters(forProviderAtindex index:NSInteger,placeName name: String, currentParams params: [String : Any]! ) ->  [String : Any] {
        
        var updatedParams:  [String : Any]!
        if (index == GITHUB_INDEX){
            updatedParams =  getGithiubPlaceParams(_: name , currentParams: params)
        }else if(index == SEARCH_GOV_INDEX){
            updatedParams = getSearchGovPlaceParams(_ :  name, currentParams: params)
        }
        return updatedParams
    }
    
    
    class private func getGithiubPlaceParams(_ name: String, currentParams params: [String : Any]!)->  [String : Any] {
       
        //provider api for places
        // https://jobs.github.com/positions.json?location=amman
        
        
        var updatedParams  = params
        if (updatedParams == nil){
            updatedParams =  [String : Any]()
        }
        if updatedParams!["location"] != nil {//update available value
            updatedParams!.updateValue(name, forKey: "location")
        }else{//add for first time
            updatedParams!["location"] = name
        }
        
        return updatedParams!
    }
    
     class private func getSearchGovPlaceParams(_ name: String, currentParams params: [String : Any]!)->  [String : Any] {
       
        //provider api replace " " with + and send all in the same key "query"
        //Part-time nursing jobs with Veterans Affairs in NY https://jobs.search.gov/jobs/search.json?query=parttime+nursing+jobs+with+veterans+affairs+in+ny
        
        var updatedParams  = params
        if (updatedParams == nil){
            updatedParams =  [String : Any]()
        }
        
        if updatedParams!["query"] != nil {//update available value
            var query = updatedParams!["query"] as! String
            if (query != ""){
                query = query + "+" + name
            }else{
                query = name
            }
            updatedParams!.updateValue(query , forKey: "query")
        }else{//add for first time
            updatedParams!["query"] = name
        }
    
        return updatedParams!
        
    }

}
