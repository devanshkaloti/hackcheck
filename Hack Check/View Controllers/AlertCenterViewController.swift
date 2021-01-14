//
//  AlertCenterViewController.swift
//  Password
//
//  Created by Devansh Kaloti on 2020-07-26.
//  Copyright © 2020 Devansh Kaloti. All rights reserved.
//

import UIKit
import AnimatedField
import UserNotifications
import FirebaseAnalytics
import Flurry_iOS_SDK

class AlertCenterViewController: UIViewController {


    @IBOutlet weak var emailField: AnimatedField!
    @IBOutlet weak var emailFieldBtn: UIButton!
    @IBOutlet weak var currentStatusMessage: UILabel!
    @IBOutlet weak var currentMessageView: Cards!
    
    var emailSetting = Setting(setting: "email")
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupEmailField()
        setupDoneButton()
    
        self.navigationController?.navigationBar.prefersLargeTitles = true
        statusMessage()
        
    }
    
    func statusMessage() {
        let checkFrequency = Setting(setting: "checkFrequency")
           if emailSetting.value != "" {
               currentStatusMessage.text = "\(emailSetting.value) is checked against the database every week \(checkFrequency.value)"
             currentMessageView.backgroundColor = UIColor(red: 0, green: 195, blue: 74).withAlphaComponent(0.82)
           } else {
               currentStatusMessage.text = "Provide an email id to be checked against the leak database regularly."
           }
        
    }
    
}

// MARK:- Email Field
extension AlertCenterViewController {
    func setupEmailField() {
        var format = AnimatedFieldFormat()
        
        if emailSetting.value != "" {
            emailField.text = emailSetting.value
        }
        

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
                
            format.counterEnabled = false
            format.countDown = false
            format.counterAnimation = false
                
            format.highlightColor = UIColor(displayP3Red: 0, green: 139/255, blue: 96/255, alpha: 1.0)
            
            emailField.format = format
        
            UIView.animate(withDuration: 0.6,
            animations: {
                self.emailFieldBtn.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.6) {
                    self.emailFieldBtn.transform = CGAffineTransform.identity
                }
            })
            
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
    
    @IBAction func emailFieldOnClick(_ sender: Any) {
        let num = Int.random(in: 0...10000)

        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-alert-\(num)-\(emailField.text)",
            AnalyticsParameterItemName: "Set alerts on email id",
            AnalyticsParameterContentType: "Alerts set for \(emailField.text)"
        ])
        
        
        let param = ["Alert Set": emailField.text];
        Flurry.logEvent("Email ID", withParameters: param);
        
        self.view.endEditing(true)
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
               let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
               if !emailPred.evaluate(with: emailField.text) {
                   // Not valid email!
                
                let alertVC = alertify(title: "Error: Invalid Email ID", message: "Please enter a valid email id")
                
                self.present(alertVC, animated: true, completion: nil)
                return
               }
        
        if let email = emailField.text {
            
            LocalNotificationManager().schedule { (result) in
                if result {
                    _ = Setting(setting: "email", value: email)
                    
                    
                    DispatchQueue.main.async {
                        let alertVC = alertify(title: "Success!", message: "Your email id will be checked every week and you will be notified")

                        self.present(alertVC, animated: true, completion: nil)
                        self.statusMessage()
                      
                     }
                    
                } else {
                    DispatchQueue.main.async {
                        let alertVC = alertify(title: "Error", message: "Your notification was not scheduled, please ensure you have notifications enabled for this app")

                        self.present(alertVC, animated: true, completion: nil)

                     }
                }
            }
        }
    }
}
