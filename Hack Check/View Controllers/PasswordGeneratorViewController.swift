//
//  PasswordGeneratorViewController.swift
//  Hack Check
//
//  Created by Devansh Kaloti on 2020-12-02.
//  Copyright © 2020 Devansh Kaloti. All rights reserved.
//

import UIKit
import PMAlertController
import FirebaseAnalytics
import Flurry_iOS_SDK
import SwiftKeychainWrapper

class PasswordGeneratorViewController: UIViewController {

    @IBOutlet weak var numberCharacters: UISlider!
    @IBOutlet weak var uppercaseSwitch: UISwitch!
    @IBOutlet weak var lowercaseSwitch: UISwitch!
    @IBOutlet weak var numbersSwitch: UISwitch!
    @IBOutlet weak var symbolsSwitch: UISwitch!
    @IBOutlet weak var suggestedPassword: UILabel!
    @IBOutlet weak var numCharactersShow: UILabel!
    @IBOutlet weak var makeMemorable: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
        
        numberCharacters.value = defaults.object(forKey: "le") as? Float ?? 10
        uppercaseSwitch.isOn = defaults.object(forKey: "u") as? Bool ?? true
        lowercaseSwitch.isOn = defaults.object(forKey: "l") as? Bool ?? true
        numbersSwitch.isOn = defaults.object(forKey: "n") as? Bool ?? true
        symbolsSwitch.isOn = defaults.object(forKey: "s") as? Bool ?? false
        makeMemorable.isOn = defaults.object(forKey: "m") as? Bool ?? false
        
        numberCharacters.value = 6
        numCharactersShow.text = "\(Int(numberCharacters.value))"
    }
    
    @IBAction func generatePassword(_ sender: Any) {
        let defaults = UserDefaults.standard
        
        var i = 0
        var possibleCharacters = [String]()
        let uppercase =
            ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        let lowercase = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
        let numbers = ["0","1","2","3","4","5","6","7","8","9"]
        let symbols = ["!","@","#","*"]
        
        suggestedPassword.text = ""
        var strength = 0

        
        defaults.set(numberCharacters.value, forKey: "le")
        
        
        if uppercaseSwitch.isOn {
            possibleCharacters.append(contentsOf: uppercase)
            
            defaults.set(true, forKey: "u")
            strength += 1
        } else {
            defaults.set(false, forKey: "u")
        }
        
        if lowercaseSwitch.isOn {
            possibleCharacters.append(contentsOf: lowercase)
            
            defaults.set(true, forKey: "l")
            strength += 1
        } else {
            defaults.set(false, forKey: "l")
        }
        if numbersSwitch.isOn {
            possibleCharacters.append(contentsOf: numbers)
            
            defaults.set(true, forKey: "n")
            strength += 1
        } else {
            
            defaults.set(false, forKey: "n")
        }
        if symbolsSwitch.isOn {
            possibleCharacters.append(contentsOf: symbols)
            
            defaults.set(true, forKey: "s")
            strength += 1
        } else {
            defaults.set(true, forKey: "s")
        }
        
        var randomWord = ""
        if makeMemorable.isOn {
            defaults.set(true, forKey: "m")
            
            let words = commonWords.filter{$0.count <= Int(numberCharacters.value) - 3 && $0.count >= 3}
            randomWord = words.randomElement() ?? "warm"
            suggestedPassword.text = randomWord

        } else {
            defaults.set(false, forKey: "m")
        }
        
        
        if strength == 0 {
            let alertVC = PMAlertController(title: "Error", description: "Please select at least one group of characters to include in your password", image: nil, style: .alert)
                   alertVC.addAction(PMAlertAction(title: "OK", style: .cancel, action: { () in
                       print("Capture action OK")
                   }))
                   self.present(alertVC, animated: true, completion: nil)
            return 
        }
        
        
        
        var numberSymbolsUsed = 0
        while (i < (Int(numberCharacters.value) - randomWord.count)) {
            let word = possibleCharacters.randomElement()!
            
            suggestedPassword.text = suggestedPassword.text! + word
            
            i += 1
        }
        
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemName: "Password Generated",
        ])
        
        Flurry.logEvent("Password Generated");
        
        
        
    }
    
    
    @IBAction func numberCharcters(_ sender: Any) {
        numCharactersShow.text = "\(Int(numberCharacters.value))"
    }
    
    @IBAction func savePassword(_ sender: Any) {
        var current: String? = KeychainWrapper.standard.string(forKey: "pwds")
        if let c = current {
            current = "\(c), \(suggestedPassword.text!)"
        } else {
            current = "\(suggestedPassword.text!)"
        }

        let result: Bool = KeychainWrapper.standard.set(current ?? "error", forKey: "pwds")

        if (result) {
            let alertVC = PMAlertController(title: "Success", description: "Your password has been saved", image: nil, style: .alert)
                   alertVC.addAction(PMAlertAction(title: "OK", style: .cancel, action: { () in
                       print("Capture action OK")
                   }))
                   self.present(alertVC, animated: true, completion: nil)
            
            Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
                      AnalyticsParameterItemName: "Password Saved to List",
                  ])
                  
                  Flurry.logEvent("Password Saved to List");
                  
            
            
        } else {
            let alertVC = PMAlertController(title: "Error", description: "Something went wrong and your password was not saved. Please contact app support.", image: nil, style: .alert)
                   alertVC.addAction(PMAlertAction(title: "OK", style: .cancel, action: { () in
                       print("Capture action OK")
                   }))
                   self.present(alertVC, animated: true, completion: nil)
        }
       
    }
    
    @IBAction func viewSavedPasswords(_ sender: Any) {
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
              AnalyticsParameterItemName: "Opened Password List",
          ])
          
          Flurry.logEvent("Opened Password List");
    }
    
    
}
