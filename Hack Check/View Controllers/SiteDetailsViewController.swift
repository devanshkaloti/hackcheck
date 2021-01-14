//
//  SiteDetailsViewController.swift
//  Password
//
//  Created by Devansh Kaloti on 2020-07-23.
//  Copyright © 2020 Devansh Kaloti. All rights reserved.
//

import UIKit
import Flurry_iOS_SDK

class SiteDetailsViewController: UIViewController {

    var site: Site! 
    var sites: [Site]!
    
    @IBOutlet weak var secondTitle: UILabel!
    @IBOutlet weak var domain: UILabel!
    @IBOutlet weak var accountsNum: UILabel!
    @IBOutlet weak var breachDate: UILabel!
    @IBOutlet weak var informationLeaked: UILabel!
 
    @IBOutlet weak var descriptionBody: UILabel!
    @IBOutlet weak var logo: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadDataInView()
    }
    
    func loadDataInView() {
        self.descriptionBody.text = site.Description.stripOutHtml()
    
        
//        self.mainTitle.text = site.Title
        self.secondTitle.text = site.Title
        self.domain.text = site.Domain
        self.accountsNum.text = "\(site.PwnCount.withCommas())"
        self.breachDate.text = site.BreachDate
        self.informationLeaked.text = site.DataClasses.joined(separator: ", ")
        self.logo.downloaded(from: site.LogoPath)
        
        let param = ["Domain": site.Domain];
        Flurry.logEvent("Viewed Breach Details", withParameters: param);
    }
    

    @IBAction func backToEmailSearch(_ sender: Any) {
        let newvc = self.storyboard?.instantiateViewController(withIdentifier: "emailSearch") as! EmailSearchViewController
        
        newvc.data = self.sites
        self.present(newvc, animated: true, completion: nil)
        
    }
}
