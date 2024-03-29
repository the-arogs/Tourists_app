//
//  ViewModel.swift
//  Group12_Tourism
//
//  Created by Arogs on 2/15/24.
//

import Foundation

import UIKit

final class ViewModel: ObservableObject {
    let openURL: OpenURLProtocol
    init(openURL: OpenURLProtocol = UIApplication.shared) {
        self.openURL = openURL
    }
    func callNumber(phoneNumber:String) {
        guard let url = URL(string: "tel://\(phoneNumber)") else { return }
        openURL.open(url)
    }
}
