//
//  SitesSearchViewController.swift
//  Password
//
//  Created by Devansh Kaloti on 2020-07-25.
//  Copyright © 2020 Devansh Kaloti. All rights reserved.
//

import UIKit


class SitesSearchViewController: UIViewController {

    var data: [Site]!
    var allData: [Site]!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        get(url: "https://haveibeenpwned.com/api/v3/breaches") { (dt) in
            let decodedSite = Site.decodeAll(dt)
            
            if let decodedSite = decodedSite {
                self.loadTableViewData(data: decodedSite)
            } else {
                print("UNKNOWN ERROR ")
            }
         }
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func loadTableViewData(data: [Site]) {
        DispatchQueue.main.async {
            self.data = data
            self.tableView.reloadData()
        }
    }
    

}


// TODO:- Put this in a generic class
extension SitesSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = data {
            return data.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = data[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell") as! EmailSearchResultCell
        cell.title.text = row.Title
        cell.logo.downloaded(from: row.LogoPath)
        cell.numPwned.text = "\(row.PwnCount.withCommas())"
        cell.dateBreached.text = row.BreachDate

        if (row.DataClasses.count >= 2 ) {
            cell.dataClasses.text = "\(row.DataClasses[0]), \(row.DataClasses[1]), + more"
        } else if (row.DataClasses.count == 1) {
            cell.dataClasses.text = "\(row.DataClasses[0])"
        } else {
            cell.dataClasses.text = "Unknown entities leaked"
        }

        return cell

    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newvc = self.storyboard?.instantiateViewController(withIdentifier: "siteDetail") as! SiteDetailsViewController

        newvc.site = data[indexPath.row]
        newvc.sites = data

        self.present(newvc, animated: true, completion: nil)
        
    }


}
