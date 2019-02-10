//
//  JobsTableViewController.swift
//  JobFinder
//
//  Created by Rana Alhaj on 2/5/19.
//  Copyright © 2019 ProgressSoft. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage


class JobsTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var countersLabel: UILabel!
    @IBOutlet var searchBar: UISearchBar!

    
    var selectionViewController : SelectionViewController!
    
    
    var filterdProviders  = [ProviderModel]()
    var refreshControl = UIRefreshControl()
    var pageCounter : Int = 1
    private var didTapDeleteKey = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "JobFinder"
        
        //At first time default providers are all job finder providers
        let defProviders = JOBFINDER_ALL_PROVIDERS_INDEXS
        
        //fill providers in array to get data and jobs
        filterdProviders = fillFilteredJobFinderProviders(filteredProvidersIndexes: defProviders)
        
        //Add Refresh controller
        addSubViews()
        
        //Prepare for first request
        prepareForFirstRequest()
        //get Data From server
        getProvidersJobsData()
        
    }


    func addSubViews(){
        addRefreshController()
    }
    
    func addRefreshController(){
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    
    //This funcution is for fill providers data by array of indexes
    //If we add a new provider we should add the new case here
    func fillFilteredJobFinderProviders(filteredProvidersIndexes indexsArray: [Int]) -> [ProviderModel]{
        
        var  providers  = [ProviderModel]()
        pageCounter = 1
        for index in indexsArray
        {
            var provider : ProviderModel!
            switch index{
            case GITHUB_INDEX:
                provider = ProviderModel.init(initWithID: index, Name: JOBFINDER_ALL_PROVIDERS_NAMES[index], BaseUrl: GITHUB_BASEURL)
                break
            case SEARCH_GOV_INDEX:
                provider = ProviderModel.init(initWithID: index, Name: JOBFINDER_ALL_PROVIDERS_NAMES[index], BaseUrl: SEARCH_GOV_BASEURL)
                break
                
            default:
                break
            }
            providers.append(provider)
        }
        
        return providers
    }
    
    
    //openSelectionViewController is to open filter screen, pass the current providers indexes and use delegate to get passed data when return to this viewcontroller
    @IBAction func openSelectionViewController(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let selectionViewController = storyBoard.instantiateViewController(withIdentifier: "SelectionViewController") as! SelectionViewController
        var prevProviders = [Int] ()
       
        for provier in filterdProviders{
            prevProviders.append(provier.id)
        }
        
        selectionViewController.prevSelectedProviders = prevProviders
        //Use delegate to pass data from filter screen to this viewcontroller
        selectionViewController.delegate = self
        let navigationViewController = UINavigationController(rootViewController: selectionViewController)
        self.present(navigationViewController, animated: true, completion: nil)
    }
    
    //init all required values for each provider  inclunding : params, pagination, search...
    func prepareForFirstRequest(){
        pageCounter = 1
        countersLabel.text =  "Page: " + String(pageCounter) 
        
        for provider in filterdProviders
        {
            provider.availableJobs.totalJobsCount = 0
            provider.availableJobs.currentPage = pageCounter - 1
            
            provider.availableJobs.jopsPerPage.removeAll()
            
            let fromRecord = provider.availableJobs.totalJobsCount
            
            let params = PaginationParamsUpdater.getPaginiationParameters(forProviderAtindex: provider.id, lastRecordIndex : fromRecord , currentPage: pageCounter, currentParams: provider.params ?? nil)
            provider.params = params
            
        }
    }
   
    
    //get loaction params that will be passed in the new reuest and add it to the available pamas
    func addLoactionFilter(_ loaction : String ){
        for provider in filterdProviders
        {
            let Params  = LoactionParamsUpdater.getLoactioParameters(forProviderAtindex: provider.id, currentLoaction: loaction, currentParams: provider.params)
            provider.params = Params
        }
    }
    
    //get place params that will be passed in the new reuest and add it to the available pamas
    func addPlaceFilter(_ place : String ){
        for provider in filterdProviders
        {
            let Params  = PlaceParamsUpdater.getPlaceParameters(forProviderAtindex: provider.id, placeName : place, currentParams: provider.params)
            provider.params = Params
        }
    }
    
    //get search params that will be passed in the new reuest and add it to the available pamas
    func addSearchParams(_ words : String ){
        for provider in filterdProviders
        {
            let Params  = SearchParamsUpdater.getSearchParameters(forProviderAtindex: provider.id, searchWord:words,  currentParams: provider.params ?? nil)
            provider.params = Params
        }
    }
    
    //used with UIRefresh controller
    @objc func refresh() {
        refreshControl.endRefreshing()
        prepareForFirstRequest()
        self.tableView.reloadData()
        getProvidersJobsData()
    }
    
    
    //For pagination --> go to the next page every time we update page number and update the request params and get the new data from server
    @IBAction func goToNextPage(_ sender: Any) {
        pageCounter += 1
        countersLabel.text =  "Page: " + String(pageCounter)
        updateProvidersPageNumber()
    
    }
    
    //For pagination --> go to the previous page, here no need to send a request to the servser, data already saved in pages in providerModel for each provider
    @IBAction func goToPrevPage(_ sender: Any) {
        pageCounter -= 1
        if (pageCounter < 1){
            pageCounter = 1
        }
        countersLabel.text =  "Page: " + String(pageCounter)
        
        //Here No need to reload data it is alredy saved in the provider jobs
        for provider in filterdProviders
        {
            provider.availableJobs.currentPage = pageCounter - 1
            tableView.reloadData()
        }
        
    }
    
    //get jobs for each provider
    func getProvidersJobsData(){
        for provider in filterdProviders
        {
            fetchJobsFromProvider(_ :provider)
        }
    }
    
    
    
    //update paginations to get new data
    func updateProvidersPageNumber(){
        
        for provider in filterdProviders
        {
            let fromRecord = provider.availableJobs.totalJobsCount  - 1
            let paginationParams = PaginationParamsUpdater.getPaginiationParameters(forProviderAtindex: provider.id, lastRecordIndex : fromRecord , currentPage: pageCounter,  currentParams: provider.params ?? nil)
            provider.availableJobs.currentPage = pageCounter - 1
            provider.params = paginationParams
            fetchJobsFromProvider(_ :provider)
        }
    }

    
    // here we get the jobs from servers, pass provider object that contains all required data just like url, params and provider index
    func fetchJobsFromProvider(_ provider : ProviderModel ) {
        guard let url = URL(string: provider.baseUrl!) else {
            return
        }
        
      provider.availableJobs.jopsPerPage.append([JobModel]())
      AF.request(url, method: .get, parameters: provider.params ).responseJSON(completionHandler:
            { response in
                switch response.result {
                case .failure(let error):
                    print(error)
                    if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                        print(responseString)
                    }
                case .success(let responseObject):
                    print(responseObject)
                    
                    //fill returened data to job model, here we deal with each provider and fill this object by keys for each one So JobModel is the same model for all providers jobs
                    var jobsPerPage : [JobModel]? = [JobModel]()
                    
                    let tempJobsArray = responseObject as! [[String : Any]]
                    for dir in tempJobsArray
                    {
                        let job = JobModel(provider: provider.id, Data: dir)
                        jobsPerPage?.append(job)
                    }
                    //fill jobs in provider pages array
                    provider.availableJobs!.jopsPerPage[provider.availableJobs!.currentPage] = jobsPerPage!
                    //add new jobs counter to sum of totle jobs
                    provider.availableJobs.totalJobsCount += jobsPerPage!.count
                    
                    //reload data
                    self.tableView.reloadData()
                    
                }
        })
        
    }
}
    


extension JobsTableViewController: UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return filterdProviders.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = filterdProviders[section]
        if (section.availableJobs.jopsPerPage.count > 0  && section.availableJobs.jopsPerPage.count > section.availableJobs.currentPage)
        {
            let jobs = section.availableJobs.jopsPerPage[section.availableJobs.currentPage]
            let count  =  jobs.count
            return count
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! JobTableViewCell
       
        let section = filterdProviders[indexPath.section]
    
        let sectionJobs = section.availableJobs.jopsPerPage[filterdProviders[indexPath.section].availableJobs.currentPage]
        
        //fill data from currnt job to cell
        let currentJob = sectionJobs[indexPath.row]
        cell.jobTitleLabel?.text = currentJob.title
        cell.companyNameLabel?.text = currentJob.companyName
        cell.locationLabel?.text = currentJob.location
        cell.startDateLabel?.text = "Date: " + currentJob.start_date!
        
        var url  : URL?
        
        if (currentJob.company_logo != nil)
        {
            url = URL(string:currentJob.company_logo!)
        }
        
        cell.compnayImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "JobPlaceHolderImage"))
        
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let haederTitleText = filterdProviders[section].name!
        return haederTitleText
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.section).")
        print("Cell cliked value is \(indexPath.row)")
        
       //Open Job Details screen
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "JobDetailsViewController") as! JobDetailsViewController
        
        let section = filterdProviders[indexPath.section]
        
        let sectionJobs = section.availableJobs.jopsPerPage[filterdProviders[indexPath.section].availableJobs.currentPage]
       
        let currentJob = sectionJobs[indexPath.row]
        
        //pass the selected job
        controller.job = currentJob
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    func searchBarSearchButtonClicked(_ search_Bar: UISearchBar) {
        //Search by keywords  (words wil be added to the params for each provider
        search_Bar.resignFirstResponder()
        prepareForFirstRequest()
        self.tableView.reloadData()
        
        addSearchParams(_ : search_Bar.text ?? "")
        getProvidersJobsData()
    }
    
    
  
    
    func searchBar(_ searchBar: UISearchBar,
                   shouldChangeTextIn range: NSRange,
                   replacementText text: String) -> Bool
    {
        didTapDeleteKey = text.isEmpty
        
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String)
    {
        if !didTapDeleteKey && searchText.isEmpty {
            prepareForFirstRequest()
            self.tableView.reloadData()
            getProvidersJobsData()
        }
        
        didTapDeleteKey = false
    }
    

    
    
}


//this delegate is used to get passed data from filter screen and update data for user
extension JobsTableViewController : FilterFinishDelegate{
    
    func didFinishFilter(_ sender: SelectionViewController, selectedProvidersIndex indexes: [Int], currentLoactionPoint  location : String!, placeName name: String!) {
    
        
        var returenedIndexes = indexes
        if (returenedIndexes.count != 0){
            //rearrange providers by id to get the same order evry time
            returenedIndexes.sort{ $0 < $1 }
        }
        
        
        filterdProviders = fillFilteredJobFinderProviders(filteredProvidersIndexes: returenedIndexes)
       
        prepareForFirstRequest()
        
        //user didn't select any provider  just reload the tableview after removing all providers
        if (returenedIndexes.count == 0)
        {
            self.tableView.reloadData()
        }
        else
        {   // else add loaction or place params and get data from server
            if (location != nil && location != ""){
                addLoactionFilter(_: location)
            }else if (name != nil && name != "")
            {
                addPlaceFilter(_: name)
            }
            
            //get data from server
            getProvidersJobsData()
        }
        
        
    }
} 

