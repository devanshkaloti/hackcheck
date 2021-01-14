//
//  Model.swift
//  Password
//
//  Created by Devansh Kaloti on 2020-07-26.
//  Copyright © 2020 Devansh Kaloti. All rights reserved.
//

import Foundation
import RealmSwift


class mHistory: Object {
    @objc dynamic var email = ""
    @objc dynamic var date = ""
    @objc dynamic var title = ""
    @objc dynamic var message = ""
    @objc dynamic var didRun = false
    
}

