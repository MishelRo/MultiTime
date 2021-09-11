//
//  UiAlertController.swift
//  MultiTimer2
//
//  Created by User on 11.09.2021.
//

enum alertType {
    case deleted
    case error
}

import UIKit
extension UIAlertController {
    func getAlert(type: alertType, title: String,
                  complesion: @escaping(UIAlertController)->(),
                  OkComplession: @escaping()->()) {
        switch type {
        case .deleted:
            let alert = UIAlertController(title: L10n.Item.completed,
                                          message: L10n.Item.deleted,
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default) { _ in  OkComplession() }
            alert.addAction(action)
            complesion(alert)
        case .error:
            let alert = UIAlertController(title: L10n.Error.error,
                                          message: L10n.Error.fail,
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default) { _ in OkComplession()  }
            alert.addAction(action)
            complesion(alert)
        }
    }
}
