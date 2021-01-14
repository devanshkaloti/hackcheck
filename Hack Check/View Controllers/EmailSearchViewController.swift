//
//  EmailSearchViewController.swift
//  Password
//
//  Created by Devansh Kaloti on 2020-07-22.
//  Copyright © 2020 Devansh Kaloti. All rights reserved.
//

import UIKit
import AnimatedField
import FirebaseAnalytics
import Flurry_iOS_SDK
import PMAlertController

class EmailSearchViewController: UIViewController {

    @IBOutlet weak var emailField: AnimatedField!
    @IBOutlet weak var emailFieldGoBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var resultCard: Cards!
    @IBOutlet weak var resultTitle: UILabel!
    @IBOutlet weak var resultBody: UILabel!
    
    
    var data: [Site]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupEmailField()
        self.tableView.tableFooterView = UIView()
        self.resultCard.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        setupDoneButton()
        
        
    }
    
    
    func setupDoneButton() {
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: .init(width: view.frame.width, height: 30)))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        
        self.emailField.accessoryView = toolbar
        
    }
    
    @objc func doneButtonAction() {
        self.view.endEditing(true)
    }
    
    
    
    @IBAction func emailSearchBtnClick(_ sender: Any) {

        let num = Int.random(in: 0...10000)
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-\(num)-\(emailField.text)",
            AnalyticsParameterItemName: "Email Searched",
            AnalyticsParameterContentType: "Searched for \(emailField.text)"
        ])
        
        let param = ["Email ID": emailField.text];
        Flurry.logEvent("Search", withParameters: param);
        
        
        self.view.endEditing(true)
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
     
        
        
        
        if !emailPred.evaluate(with: emailField.text) {
            // Not valid email!
        }
        
        let escapedEmail =  emailField.text!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
     
        get(url: "https://haveibeenpwned.com/api/v3/breachedaccount/\(escapedEmail)") { (data) in
            let rows = Email.decode(data)
            var siteData = [Site]()
            
            if let rows = rows {
                
                if rows.count <= 0 {
                    return
                }
                for i in 0...rows.count-1 {
                               
                    get(url: "https://haveibeenpwned.com/api/v3/breach/\(rows[i].Name)") { (dt) in
                       let decodedSite = Site.decode(dt)
                        if let ds = decodedSite {
                            siteData.append(ds)
                        }
                        
                        DispatchQueue.main.async {
                            self.data = siteData
                            self.tableView.reloadData()
                            self.result()
                         }
                
                    }

               }
            } else {
                DispatchQueue.main.async {
                    self.data = siteData
                    self.tableView.reloadData()
                    self.result()
                    
                 }
            }
        }
    }
    
    
    
}

// MARK:- Textfield
extension EmailSearchViewController {
    func setupEmailField() {
        var format = AnimatedFieldFormat()

        
//        emailField.placeholder = "Email Address"
        emailField.attributedPlaceholder = NSAttributedString(string: "Email Address",
                                                              attributes:[.foregroundColor: UIColor.white.withAlphaComponent(0.82)])
        
        format.titleAlwaysVisible = false
    

        format.titleFont = UIFont.init(name: "Lato-Bold", size: 13) ?? UIFont.systemFont(ofSize: 13)
    
        format.textFont = UIFont.init(name: "Lato-Regular", size: 18) ?? UIFont.systemFont(ofSize: 18)
  
        format.counterFont = UIFont.systemFont(ofSize: 13, weight: .regular)
        format.lineColor = UIColor.white.withAlphaComponent(0.82)
        format.titleColor = UIColor.white.withAlphaComponent(0.82)

        format.textColor = UIColor.white
        format.counterColor = UIColor.darkGray
        format.alertEnabled = true
        format.alertFont = UIFont.systemFont(ofSize: 13, weight: .regular)
        format.alertColor = UIColor.red
        format.alertFieldActive = true
        format.alertLineActive = true
        format.alertTitleActive = true
        format.alertPosition = .top
            
//        /// Secure icon image (On status)
//        format.visibleOnImage = IconsLibrary.imageOfEye(color: .red)
            
        /// Secure icon image (Off status)
//        format.visibleOffImage = IconsLibrary.imageOfEyeoff(color: .red)
            
        format.counterEnabled = false
            
        format.countDown = false

        format.counterAnimation = false
            
        format.highlightColor = UIColor(displayP3Red: 0, green: 139/255, blue: 96/255, alpha: 1.0)
        
        emailField.format = format
        

        UIView.animate(withDuration: 0.6,
        animations: {
            self.emailFieldGoBtn.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        },
        completion: { _ in
            UIView.animate(withDuration: 0.6) {
                self.emailFieldGoBtn.transform = CGAffineTransform.identity
            }
        })
        
    }
    
    func result() {
        
        if let data = data {
            if data.count > 0 {
                resultCard.backgroundColor = UIColor(red: 232, green: 48, blue: 32).withAlphaComponent(0.82)
                self.resultTitle.text = "Oh No!"
                self.resultBody.text = "Your information has been leaked at least \(self.data.count) times"
                
            } else {
                resultCard.backgroundColor = UIColor(rgb: 0x000195074).withAlphaComponent(0.82)
                self.resultTitle.text = "Phew, we didn't find anything"
                self.resultBody.text = "However, this does not imply it was never hacked. "
            }
        } else {
            resultCard.backgroundColor = UIColor(red: 0, green: 79, blue: 255).withAlphaComponent(0.82)
            self.resultTitle.text = "An error occurred... "
            self.resultBody.text = "Please ensure you are connected to the internet"
        }
        self.resultCard.isHidden = false
    }
}


extension EmailSearchViewController: UITableViewDelegate, UITableViewDataSource {
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

    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
         if let cell = tableView.cellForRow(at: indexPath) as? EmailSearchResultCell {

            UIView.animate(withDuration: 0.6,
                   animations: {
                       cell.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                   },
                   completion: { _ in
                       UIView.animate(withDuration: 0.6) {
                        cell.transform = CGAffineTransform.identity
                       }
                   })
            }
        
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let newvc = self.storyboard?.instantiateViewController(withIdentifier: "siteDetail") as! SiteDetailsViewController

        newvc.site = data[indexPath.row]
        newvc.sites = data

        self.present(newvc, animated: true, completion: nil)

    }
}
