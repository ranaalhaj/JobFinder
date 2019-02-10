//
//  JobModel.swift
//  JobFinder
//
//  Created by Rana Alhaj on 2/6/19.
//  Copyright © 2019 ProgressSoft. All rights reserved.
//

import Foundation

class ProviderModel {

    //Use This For Job Pagination
    public class AvailableJobs{
        public var  currentPage : Int = 0
        public var  totalJobsCount : Int = 0
        public var  jopsPerPage = [[JobModel]]() // here we fill the returned jobs from server
    }
    
    
    //Shared for all providers
    public var  id : Int!
    public var name  :String?
    public var baseUrl  :String?
    public var params  :[String: Any]?
    public var availableJobs : AvailableJobs! = AvailableJobs()
    
    
     required init(initWithID id:Int,Name name: String , BaseUrl baseUrl: String) {
    
        self.id = id
        self.name = name
        self.baseUrl = baseUrl
    }
    
}
