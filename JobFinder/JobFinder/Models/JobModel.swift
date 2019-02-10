//
//  JobModel.swift
//  JobFinder
//
//  Created by Rana Alhaj on 2/6/19.
//  Copyright © 2019 ProgressSoft. All rights reserved.
//

import Foundation

 //Use Same Model for all jobs for all providers

class JobModel {
    
    var  id : String?
    var url  :String?
    var title :String?
    var type : String?
    var start_date :String?
    var end_date  :String?
    var companyName :String?
    var company_url :String?
    var location :String!
    var description: String?
    var how_to_apply :String?
    var company_logo :String?
    var rate_interval_code  :String?
    var minimum : Int!
    var maximum : Int!
    
    
    //here get data from dictionary by keys and fill in the shared model for each providers
    //So when add a new provider you should implement a new init func to get data from it
     init (provider index: NSInteger, Data dict: Dictionary<String, Any>){
        switch index {
        case GITHUB_INDEX:
            initWithGitHubJobDict(Data: dict)
              break
        case SEARCH_GOV_INDEX:
            initWithSearchGovJobDict(Data: dict)
              break
        default:
            break
        }
        
        
    }
    
    
  
    //fill from GitHub Dictionary
    func initWithGitHubJobDict (Data dir: Dictionary<String, Any>){
        self.id = dir["id"] as? String ?? ""
        self.type = dir["type"] as? String
        self.start_date = dir["created_at"] as? String ?? ""
        self.companyName = dir["company"] as? String
        self.company_url = dir["company_url"] as? String
        self.company_logo = dir["company_logo"] as? String ?? ""
        self.location = dir["location"] as? String
        self.title = dir["title"] as? String ?? ""
        self.description = dir["description"] as? String ?? ""
        self.how_to_apply = dir["how_to_apply"] as? String ?? ""
        self.url = dir["url"] as? String ?? ""
        
        //SearchGov Returned Keys
        self.end_date = ""
        self.rate_interval_code = ""
    }
    
    
     //fill from SaerchGov Dictionary
    func initWithSearchGovJobDict (Data dir: Dictionary<String, Any>){
        
        self.id = dir["id"] as? String ?? ""
        self.title = dir["position_title"] as? String ?? ""
        self.start_date = dir["start_date"] as? String ?? ""
        self.end_date = dir["end_date"] as? String ?? ""
        self.companyName = dir["organization_name"] as? String
        let locations = dir["locations"] as?  [String]
        let locationsString = locations!.joined(separator: ",")
        self.location = locationsString
        self.maximum = dir["maximum"] as? Int
        self.minimum = dir["minimum"] as? Int
        self.rate_interval_code = dir["rate_interval_code"] as? String ?? ""
        self.url = dir["url"] as? String ?? ""
        
        
        //GitHubReturend Keys
        self.company_url = ""
        self.company_logo =  ""
        self.type = ""
        self.description =  ""
        self.how_to_apply = ""
       
    }

}


