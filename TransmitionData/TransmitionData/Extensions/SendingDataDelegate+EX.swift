//
//  SendingDataDelegate+EX.swift
//  TransmitionData
//
//  Created by Roman Kniukh on 16.03.21.
//

import Foundation

extension AuthViewController: SendingDataProtocol {
    func sendData(message: String) {
        switch message {
        case "confirmed":
            self.view.backgroundColor = .systemGreen
        default:
            self.view.backgroundColor = .red
        }
    }
}
