//
//  String.swift
//  Password
//
//  Created by Devansh Kaloti on 2020-07-24.
//  Copyright © 2020 Devansh Kaloti. All rights reserved.
//

import Foundation

extension String {

    func stripOutHtml() -> String? {
        do {
            guard let data = self.data(using: .unicode) else {
                return nil
            }
            let attributed = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            return attributed.string
        } catch {
            return nil
        }
    }
    
    func stringReplaceFirst(
               target: String, withString replaceString: String) -> String
       {
           if let range = self.range(of: target) {
               return self.replacingCharacters(in: range, with: replaceString)
           }
           return self
       }
}


