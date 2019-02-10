//
//  JobDetailsViewController.swift
//  JobFinder
//
//  Created by Apple User on 2/9/19.
//  Copyright © 2019 ProgressSoft. All rights reserved.
//

import UIKit

class JobDetailsViewController: UIViewController {

    @IBOutlet var companyLogoImage: UIImageView!
    @IBOutlet var jobTitleLabel: UILabel!
    @IBOutlet var companyNameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var startDateLabel: UILabel!
    @IBOutlet var descriptionWebView: UIWebView!
  
    
    public var job :JobModel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fillJobDetails()
        // Do any additional setup after loading the view.
    }
    

    //fill passed data in the view controller
    func fillJobDetails(){
        
        jobTitleLabel?.text = job.title
        companyNameLabel?.text = job.companyName
        locationLabel?.text = job.location
        startDateLabel?.text = "Date: " + job.start_date!
        
        //load description as uiwebview
        descriptionWebView.loadHTMLString(job.description! , baseURL: nil)
        
        //get company logo without default image
        var url  : URL?
        
        if (job.company_logo != nil)
        {
            url = URL(string:job.company_logo!)
        }
        
        companyLogoImage.sd_setImage(with: url)
        
        
    }
   
    
    // visit web site button opens a new viewcontroller with UIWebView
    @IBAction func openPageInWebSite(_ sender: Any) {
        
        //if no url return 
        if job.url == nil {
            
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        
        controller.urlStr = job.url!
    
        self.navigationController?.pushViewController(controller, animated: true)
    }
    

}
