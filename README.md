# JobFinder
 JobFinder is a job search solution that looks into many providers and display results from all the available job providers



Fill all providers in list of object provider, then get data from server for each provider dpend on spectial params 


To add new provider you have to update on
1- GeneralConstant Class 
2- JobModel calss add a new inot function to read data from new provider dictionary
3- update on all params updater class such as (PaginationParamsUpdater, LocationParamsUpdater,.....)
4- deal with new provider index in other classes



Used Pod Libraries:

pod 'Alamofire', '~> 5.0.0.beta.1'
  pod 'SDWebImage', '~>3.8'
  pod 'SelectionList'
  pod 'GoogleMaps'
  pod 'GooglePlaces'
  
  
  You can find features such as :
  1- Paginations
  2- Search by word(or words)
  3- filter by provider
  4- filter by current location
  5- filter by place address (using Google Places SDK)
  
  
  
  

