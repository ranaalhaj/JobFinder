//
//  Pagintaions.swift
//  JobFinder
//
//  Created by Rana Alhaj on 2/7/19.
//  Copyright © 2019 ProgressSoft. All rights reserved.
//

import Foundation


//This class is to add or update Search params for each provider depends on the apis
//When add anew provider you should implement a new funv to get it's params


class SearchParamsUpdater {
    

    class func getSearchParameters(forProviderAtindex index:NSInteger, searchWord word: String, currentParams params: [String : Any]!) ->  [String : Any] {
       
       
        
        var updatedParams:  [String : Any]!
    
        if (index == GITHUB_INDEX){
            updatedParams =  getGithiubSearchParams(seachBy : word, currentParams:  params )
        }else if(index == SEARCH_GOV_INDEX){
            updatedParams = getSearchGovPaginationParams(seachBy : word, currentParams:  params)
        }
        return updatedParams
    }
    
    
    
    //GitHub
     class private func getGithiubSearchParams(seachBy word: String , currentParams params: [String : Any]!)->  [String : Any] {
    
        //GitHub search Api
        //https://jobs.github.com/positions.json?page=1&search=code
        
        
        var updateParams  = params
        if (updateParams == nil){
            updateParams =  [String : Any]()
        }
        
        if updateParams!["search"] != nil {//update available value
            updateParams!.updateValue(word , forKey: "search")
        }else{//add for first time
            updateParams!["search"] = word
        }
        
        return updateParams!
        
    }
   
    
    //SearchGov
     class private func getSearchGovPaginationParams(seachBy words: String , currentParams params: [String : Any]!)->  [String : Any] {
        
        var updateParams  = params
        if (updateParams == nil){
            updateParams =  [String : Any]()
        }
        
        //SearchGov search Api
        //https://jobs.search.gov/jobs/search.json?query=word1+word2+....
        
        
        let queryString = words.replacingOccurrences(of: " ", with: "+")
        
        if updateParams!["query"] != nil {//update available value
            updateParams!.updateValue(queryString , forKey: "query")
        }else{//add for first time
            updateParams!["query"] = queryString
        }
    
    
        return updateParams!
    }
    
    
    
}
