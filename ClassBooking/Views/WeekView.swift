//
//  WeekView.swift
//  ClassBooking
//
//  Created by Zih-Siang Yue on 2021/5/16.
//

import UIKit

protocol WeekViewDelegate: AnyObject {
    func weekDidChanged(_ week: [Date])
}

class WeekView: BaseView {
    
    //MARK: - Properties
    private lazy var weekDescLabel: UILabel = {
        let label = UILabel()
        label.text = self.currentDate.weekStr//  self.dateAgent.weekStr(of: self.currentDate)
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var leftBtn: UIButton = {
        let btn = UIButton.createButton(title: "<") { [weak self] in
            guard let self = self else { return }
            self.resetCurrentDate(direction: .backward)
        }
        return btn
    }()
    
    private lazy var rightBtn: UIButton = {
        let btn = UIButton.createButton(title: ">") { [weak self] in
            guard let self = self else { return }
            self.resetCurrentDate(direction: .forward)
        }
        return btn
    }()
    
    weak var delegate: WeekViewDelegate?
//    private var dateAgent: SYDateAgent
    private var currentDate: Date {
        willSet {
            self.weekDescLabel.text = newValue.weekStr// self.dateAgent.weekStr(of: newValue)
        }
    }
    
    //MARK: - Initializer
    init() {
//        self.dateAgent = dateAgent
        self.currentDate = Date.today()
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration
    override func setupSubviews() {
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(leftBtn)
        addSubview(rightBtn)
        addSubview(weekDescLabel)
        setupConstraint()
    }
    
    private func setupConstraint() {
        leftBtn.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        leftBtn.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        leftBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        rightBtn.leftAnchor.constraint(equalTo: self.leftBtn.rightAnchor).isActive = true
        rightBtn.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        rightBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        weekDescLabel.leftAnchor.constraint(equalTo: self.rightBtn.rightAnchor).isActive = true
        weekDescLabel.rightAnchor.constraint(greaterThanOrEqualTo: self.rightAnchor).isActive = true
        weekDescLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        weekDescLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    //MARK: - Private
    private func resetCurrentDate(direction: Calendar.SearchDirection) {
        currentDate = direction == .forward ? currentDate.nextWeek : currentDate.lastWeek
        self.delegate?.weekDidChanged(currentDate.week)

    }
}
