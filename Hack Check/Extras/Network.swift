//
//  Networking.swift
//  The Target App
//
//  Created by Devansh Kaloti on 2020-06-15.
//  Copyright © 2020 Devansh Kaloti. All rights reserved.
//

import Foundation
import SwiftyJSON


    //Informational responses (100–199),
    //Successful responses (200–299),
    //Redirects (300–399),
    //Client errors (400–499),
    //and Server errors (500–599).


    func get(url: String, completion: @escaping (Data) -> ()) {


        let url = URL(string: url)!
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = [
           "hibp-api-key": "NEEDKEYHERE", // NEED API THIS FROM HAVEIBEENPWNED.COM
           "Content-Type": "application/json"
        ]
        
        let session = URLSession.shared
        session.dataTask(with: urlRequest) { (data, response, error) in

            // Check if no error
            if error == nil && data != nil {
                completion(data!)
                
            } else {
                print("ERROR")
            }
        }.resume()
}

