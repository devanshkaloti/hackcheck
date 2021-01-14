//
//  Settings.swift
//
//
//  Created by Devansh Kaloti
//  Copyright © 2020 Devansh Kaloti. All rights reserved.
//

import Foundation
import RealmSwift


/// Settings class, also contains MISC functions related to a setting
class Setting {
    
    
    /// The setting and value pair will be protected from changing
    /// As in future implementions, security logfiles may be implemented.
    private(set) var setting: String
    private(set) var value: String
    
    
    /// Initializer
    /// Get value automatically
    /// - Parameter setting: Setting name
    init(setting: String) {
        let realm = try! Realm()
        let results = realm.objects(settings.self).filter("setting = '\(setting)'")
        
        
        self.setting = setting
        self.value = results.first?.value ?? ""
    
    }
    
    
    /// Make new setting and add to DB automatically
    ///
    /// - Parameters:
    ///   - setting: Setting name
    ///   - value: Value
    init(setting: String, value: String) {
        self.setting = setting
        self.value = value
        
        updateSetting()
    }
    
    
    /// Add or update a setting
    func updateSetting() {
        let realm = try! Realm()
        
        let settingObject = settings()
        settingObject.setting = self.setting
        settingObject.value = self.value
        
        try! realm.write {
            realm.add(settingObject, update: .modified)
        }
    }
    
    
    
    /// Change the value of a setting
    /// Similar to updateSetting()
    /// - Parameter value: New value
    func setValue(value: String) {
        self.value = value
        self.updateSetting()
    }

}


class settings: Object {
    @objc dynamic var setting = ""
    @objc dynamic var value = ""
    
    override static func primaryKey() -> String? {
        return "setting"
    }
}
