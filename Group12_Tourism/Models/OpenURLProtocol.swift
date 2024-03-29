//
//  OpenURLProtocol.swift
//  Group12_Tourism
//
//  Created by Arogs on 2/15/24.
//

import Foundation
import UIKit

protocol OpenURLProtocol {
    func open(_ url: URL)
}

extension UIApplication: OpenURLProtocol {
    func open(_ url: URL) {
        open(url, options: [:], completionHandler: nil)
    }
}
