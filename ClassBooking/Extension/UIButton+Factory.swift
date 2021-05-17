//
//  UIButton+Factory.swift
//  ClassBooking
//
//  Created by Zih-Siang Yue on 2021/5/16.
//

import UIKit

extension UIButton {
    static func createButton(title: String, titleColor: UIColor = .darkGray, bgColor: UIColor = .clear, action: @escaping () -> ()) -> UIButton {
        let btn = UIButton(type: .custom)
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.setTitleColor(titleColor, for: .normal)
        btn.backgroundColor = bgColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addAction(for: .touchUpInside, action)
        return btn
    }
}
