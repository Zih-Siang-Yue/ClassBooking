//
//  String+Localizable.swift
//  ClassBooking
//
//  Created by Zih-Siang Yue on 2021/5/16.
//

import Foundation

extension String {
    func localized() -> String {
        let str = NSLocalizedString(self, comment: "")
        return str.count > 0 ? str : self
    }
}
