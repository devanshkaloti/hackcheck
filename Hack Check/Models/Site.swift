//
//  Site.swift
//  Password
//
//  Created by Devansh Kaloti on 2020-07-21.
//  Copyright © 2020 Devansh Kaloti. All rights reserved.
//

import Foundation

struct Site: Decodable {
    
    var Name: String
    var Title: String
    var Domain: String
    var BreachDate: String
    var AddedDate: String
    var ModifiedDate: String
    var PwnCount: Int
    var Description: String
    var LogoPath: String
    var DataClasses: [String]
    var IsVerified: Bool
    var IsFabricated: Bool
    var IsSensitive: Bool
    var IsRetired: Bool
    var IsSpamList: Bool
    
    
    static func decode(_ data: Data) -> Site? {
        let decoder = JSONDecoder()
          do {
            let sites = try decoder.decode(Site.self, from: data)
              return sites
          } catch {
              print(error.localizedDescription)
              print(error)
          }
          return nil
        
    }
    
    static func decodeAll(_ data: Data) -> [Site]? {
        let decoder = JSONDecoder()
          do {
            let sites = try decoder.decode([Site].self, from: data)
              return sites
          } catch {
              print(error.localizedDescription)
              print(error)
          }
          return nil
        
    }
    
    
//
//    "Name": "Apollo",
//    "Title": "Apollo",
//    "Domain": "apollo.io",
//    "BreachDate": "2018-07-23",
//    "AddedDate": "2018-10-05T19:14:11Z",
//    "ModifiedDate": "2018-10-23T04:01:48Z",
//    "PwnCount": 125929660,
//    "Description": "In July 2018, the sales engagement startup <a href=\"https://www.wired.com/story/apollo-breach-linkedin-salesforce-data/\" target=\"_blank\" rel=\"noopener\">Apollo left a database containing billions of data points publicly exposed without a password</a>. The data was discovered by security researcher <a href=\"http://www.vinnytroia.com/\" target=\"_blank\" rel=\"noopener\">Vinny Troia</a> who subsequently sent a subset of the data containing 126 million unique email addresses to Have I Been Pwned. The data left exposed by Apollo was used in their &quot;revenue acceleration platform&quot; and included personal information such as names and email addresses as well as professional information including places of employment, the roles people hold and where they're located. Apollo stressed that the exposed data did not include sensitive information such as passwords, social security numbers or financial data. <a href=\"https://www.apollo.io/contact\" target=\"_blank\" rel=\"noopener\">The Apollo website has a contact form</a> for those looking to get in touch with the organisation.",
//    "LogoPath": "https://haveibeenpwned.com/Content/Images/PwnedLogos/Apollo.png",
//    "DataClasses": [
//        "Email addresses",
//        "Employers",
//        "Geographic locations",
//        "Job titles",
//        "Names",
//        "Phone numbers",
//        "Salutations",
//        "Social media profiles"
//    ],
//    "IsVerified": true,
//    "IsFabricated": false,
//    "IsSensitive": false,
//    "IsRetired": false,
//    "IsSpamList": false
//
    
}
