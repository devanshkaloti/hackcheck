//
//  Email.swift
//  Password
//
//  Created by Devansh Kaloti on 2020-07-21.
//  Copyright © 2020 Devansh Kaloti. All rights reserved.
//

import Foundation


struct Email: Decodable {
    
    var Name: String
    
    static func decode(_ data: Data) -> [Email]? {
        let decoder = JSONDecoder()
          do {
            let sites = try decoder.decode([Email].self, from: data)
              
            return sites
          } catch {
              print(error.localizedDescription)
              print(error)
          }
          return nil
        
    }
}
