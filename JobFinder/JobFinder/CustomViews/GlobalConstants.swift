//
//  GlobalConstants.swift
//  JobFinder
//
//  Created by  Rana Alhaj on 2/5/19.
//  Copyright © 2019 ProgressSoft. All rights reserved.
//

import Foundation


//All consatans values are her

enum Description : String{
    case  python
    case  ruby
}


let GOOGLEMAP_KEY = "AIzaSyAKHIO4vd16g2r51h-Fcg59ET9iVNjvPgk"


//to add a new provider you should add it's index here
let GITHUB_INDEX = 0
let SEARCH_GOV_INDEX = 1

//to add a new provider you should add it's url here
let GITHUB_BASEURL = "https://jobs.github.com/positions.json"
let SEARCH_GOV_BASEURL  = "https://jobs.search.gov/jobs/search.json"

//to add a new provider you should add it's title here
let JOBFINDER_ALL_PROVIDERS_INDEXS = [GITHUB_INDEX, SEARCH_GOV_INDEX]
let JOBFINDER_ALL_PROVIDERS_NAMES = ["GITHUB", "SEARCH GOV"]


//Loactions Options indexes in filter screen
let CURRENTLOCATION_INDEX = 0
let LOCATION_BY_ADDRESS_NAME_INDEX = 1

//Loactions Options titles in filter screen
let LOCATIONS_SELECTION_OPTIONS_TITLES =  ["Current loaction", "loaction by address name"]

//MAX_RECOREDS_AT_A_TIME mainly used in SEARCH GOV paginations
let MAX_RECOREDS_AT_A_TIME   = 10





/*
 
 Info from provider websites guides
 - Github: https://jobs.github.com/api
 
 https://jobs.github.com/positions.json?description=python&location=new+york
 https://jobs.github.com/positions.json?description=ruby&page=1
 https://jobs.github.com/positions.json?page=1&search=code
 https://jobs.github.com/positions.json?description=python&full_time=true&location=sf
 https://jobs.github.com/positions.json?search=node
 https://jobs.github.com/positions.json?lat=37.3229978&long=-122.0321823

 
 
 Parameters
 description — A search term, such as "ruby" or "java". This parameter is aliased to search.
 location — A city name, zip code, or other location search term.
 lat — A specific latitude. If used, you must also send long and must not send location.
 long — A specific longitude. If used, you must also send lat and must not send location.
 full_time — If you want to limit results to full time positions set this parameter to 'true'.
 
 
 GET /positions/ID.json
 Retrieve the JSON representation of a single job posting.
 
 Parameters
 
 markdown — Set to 'true' to get the description and how_to_apply fields as Markdown.
 Examples
 
 https://jobs.github.com/positions/21516.json
 https://jobs.github.com/positions/21516.json?markdown=true
 
 
 - search.gov: https://search.gov/developer/jobs.html
 
 
 All nursing jobs https://jobs.search.gov/jobs/search.json?query=nursing+jobs
 
 Nursing jobs in NY https://jobs.search.gov/jobs/search.json?query=nursing+jobs+in+ny
 
 Nursing jobs with a state government agency https://jobs.search.gov/jobs/search.json?query=nursing+jobs&tags=state
 
 Nursing jobs with a federal government agency https://jobs.search.gov/jobs/search.json?query=nursing+jobs&tags=federal
 
 Nursing jobs with Veterans Affairs in NY https://jobs.search.gov/jobs/search.json?query=nursing+jobs+with+veterans+affairs+in+ny
 
 Part-time nursing jobs with Veterans Affairs in NY https://jobs.search.gov/jobs/search.json?query=parttime+nursing+jobs+with+veterans+affairs+in+ny
 
 Seven parameters are accepted.
 
 query
 size
 from
 
 organization_ids (comma-separated)
 hl (for highlighting)
 tags (comma-separated)
 lat_lon
 Query
 Attempts to extract as much “signal” as possible from the input text. Handles word variants, so a search on “nursing jobs” will find a job titled “nurse practitioner” and “RN.” When parts of the query parameter are used to search against the position title, the results are ordered by relevance. When no query parameter is specified, they are ordered by date with the most recent listed first. For generic jobs searches (e.g., ‘jobs’, ‘internships’) where the lat_lon parameter is passed in, the results will be sorted by distance to the searcher’s geographic location.

 
 */

