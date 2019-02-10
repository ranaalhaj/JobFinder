//
//  Pagintaions.swift
//  JobFinder
//
//  Created by Rana Alhaj on 2/7/19.
//  Copyright © 2019 ProgressSoft. All rights reserved.
//

import Foundation

//This class is to add or update paginations params for each provider depends on the apis
//When add anew provider you should implement a new funv to get it's params


class PaginationParamsUpdater {
    
    
    class func getPaginiationParameters(forProviderAtindex index:NSInteger, lastRecordIndex lastRecord: Int, currentPage page: Int, currentParams params: [String : Any]! ) ->  [String : Any] {
        
       var updatedParams:  [String : Any]!
        
        if (index == GITHUB_INDEX){
            updatedParams =  getGithiubPaginationParams(_: page , currentParams: params)
        }else if(index == SEARCH_GOV_INDEX){
            updatedParams = getSearchGovPaginationParams(_ :  lastRecord, currentParams: params)
        }
        return updatedParams
}
    
    
    
    //For github
     class private func getGithiubPaginationParams(_ page: Int, currentParams params: [String : Any]!)->  [String : Any] {
        
        var updatedParams  = params
        if (updatedParams == nil){
            updatedParams =  [String : Any]()
        }
        
       
        if updatedParams!["page"] != nil { //update available value
            updatedParams!.updateValue(page , forKey: "page")
        }else{//add for first time
            updatedParams!["page"] = page
        }
        
        return updatedParams!
        
    }
   
    
    //For Search Gov
     class private func getSearchGovPaginationParams(_ lastRecord: Int, currentParams params: [String : Any]!)->  [String : Any] {
        
        
        var updatedParams  = params
        if (updatedParams == nil){
            updatedParams =  [String : Any]()
        }
        
        if updatedParams!["from"] != nil { //update available value
            updatedParams!.updateValue(lastRecord , forKey: "from")
           
        }else{//add for first time
              updatedParams!["from"] = lastRecord
        }
        
        if updatedParams!["size"] != nil {//update available value
            updatedParams!.updateValue(MAX_RECOREDS_AT_A_TIME , forKey: "size")
            
        }else {//add for first time
             updatedParams!["size"] = MAX_RECOREDS_AT_A_TIME
        }
    
          return updatedParams!
    }
    
    
    
}
