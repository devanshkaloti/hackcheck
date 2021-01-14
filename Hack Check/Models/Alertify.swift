//
//  Alertify.swift
//  Password
//
//  Created by Devansh Kaloti on 2020-07-26.
//  Copyright © 2020 Devansh Kaloti. All rights reserved.
//

import Foundation
import PMAlertController

func alertify(title: String, message: String ) -> PMAlertController {
    let alertVC = PMAlertController(title: title, description: message, image: nil, style: .alert)

    alertVC.addAction(PMAlertAction(title: "Ok", style: .cancel, action: { () -> Void in
                // action on cancel
    }))
    return alertVC
}
