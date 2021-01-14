//
//  Alert.swift
//  Password
//
//  Created by Devansh Kaloti on 2020-07-26.
//  Copyright © 2020 Devansh Kaloti. All rights reserved.
//

import Foundation
import RealmSwift

struct Alert {

    var email: String
    var date: String
    var title: String
    var message: String
    var didRun: Bool
    
    init(email: String, date: String, title: String, message: String, didRun: Bool) {
        self.email = ""
        self.date = ""
        self.title = ""
        self.message = ""
        self.didRun = false
    }
    
    static func getAll() -> [Alert] {
        var returnAlerts = [Alert]()
        
        let realm = try! Realm()
        
        realm.objects(mHistory.self).forEach { (i) in
            returnAlerts.append(Alert(email: i.email, date: i.date, title: i.title, message: i.message, didRun: i.didRun))
        }
        
        return returnAlerts
    }
    
    static func schedule() {
        
    }

    
    
    
    
}
