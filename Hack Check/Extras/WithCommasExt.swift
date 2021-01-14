//
//  Int.swift
//  Password
//
//  Created by Devansh Kaloti on 2020-07-22.
//  Copyright © 2020 Devansh Kaloti. All rights reserved.
//

import Foundation

extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}

