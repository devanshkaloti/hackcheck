//
//  ViewController.swift
//  Password
//
//  Created by Devansh Kaloti on 2020-07-21.
//  Copyright © 2020 Devansh Kaloti. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
//        get(url: "https://haveibeenpwned.com/api/v3/breachedaccount/amandeep%40sunrisemetals.com") { (data) in
//            let rows = Email.decode(data)
//            print(rows)
//        }
//https://haveibeenpwned.com/api/v3/breachedaccount/amandeep%40sunrisemetals.com
        get(url: "https://haveibeenpwned.com/api/v3/breach/Adobe") { (data) in
            let rows = Site.decode(data)
            print(rows)
        }
    }


}

