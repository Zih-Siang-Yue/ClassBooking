//
//  ClassTimeCollectionViewCell.swift
//  ClassBooking
//
//  Created by Zih-Siang Yue on 2021/5/16.
//

import UIKit

class ClassTimeCollectionViewCell: UICollectionViewCell {
    
    lazy var timeButton: UIButton = {
        let btn = UIButton.createButton(title: "") { [unowned self] in
            print("Do you wanna book the class at \(self.timeStr ?? "null")")
        }
        btn.titleLabel?.tintColor = .systemGreen // or gray
        return btn
    }()
    
    var timeStr: String? {
        willSet {
            self.timeButton.setTitle(newValue, for: .normal)
            self.timeButton.titleLabel?.tintColor = .darkGray
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutView() {
        self.addSubview(timeButton)
        timeButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        timeButton.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        timeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        timeButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
}
