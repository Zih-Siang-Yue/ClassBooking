//
//  BaseView.swift
//  ClassBooking
//
//  Created by Zih-Siang Yue on 2021/5/16.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }
    
    func setupSubviews() {
        // Can be override by subclass
    }
}
