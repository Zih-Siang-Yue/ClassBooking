//
//  WeekDayCollectionReusableView.swift
//  ClassBooking
//
//  Created by Zih-Siang Yue on 2021/5/16.
//

import UIKit

class WeekDayCollectionReusableView: UICollectionReusableView {
    
    //MARK: - Properties
    private lazy var enableView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let weekDayLabel: UILabel = {
        let label = UILabel()
        label.text = "Wed"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "3"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var isAvailable: Bool {
        willSet {
            self.enableView.backgroundColor = newValue ? .green : .lightGray
            self.weekDayLabel.textColor = newValue ? .darkGray: .lightGray
            self.dateLabel.textColor = newValue ? .darkGray: .lightGray
        }
    }
    
    //MARK: - Initializer
    override init(frame: CGRect) {
        self.isAvailable = false
        super.init(frame: frame)
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutViews() {
        layoutEnableView()
        layoutWeekDayLabel()
        layoutDateLabel()
    }
    
    private func layoutEnableView() {
        self.addSubview(enableView)
        enableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        enableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        enableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        enableView.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    private func layoutWeekDayLabel() {
        self.addSubview(weekDayLabel)
        weekDayLabel.topAnchor.constraint(equalTo: self.enableView.bottomAnchor).isActive = true
        weekDayLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        weekDayLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    private func layoutDateLabel() {
        self.addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: self.weekDayLabel.bottomAnchor).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func setupWeekDay(date: Date) {
        self.isAvailable = date > Date.today()
        self.weekDayLabel.text = date.weekDayStr
        self.dateLabel.text = date.dateStr
    }
}
