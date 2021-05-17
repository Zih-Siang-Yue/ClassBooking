//
//  ClassBookingViewController.swift
//  ClassBooking
//
//  Created by Zih-Siang Yue on 2021/5/16.
//

import UIKit

struct BookingData {
    let date: String
    let times: [String]
}

class ClassBookingViewController: UIViewController {

    
    /*
     2. abstract the instance (SYDateAgent)
     3. DI
     */
    
    
//    typealias BookingData = [String: [String]]
//    var mockDate: BookingData = ["2021/5/1": ["09:00", "09:30", "10:00", "10:30"]]
    
    /** 先參考zoe 寫法
        1. 將日期格式作轉換，切分為(1) 日期 (2) 時間 (時間都將切分為每半小時為一格)
        2. 時間另外做個資料格式 Time
     
     */
    
    var mockData: [BookingData] = [BookingData(date: "2021-5-1", times: ["09:00", "09:30", "10:00", "10:30"]),
                                   BookingData(date: "2021-5-2", times: ["09:00", "09:30", "10:00", "10:30"]),
                                   BookingData(date: "2021-5-3", times: ["09:00", "09:30", "10:00", "10:30", "11:00", "11:30", "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "09:00", "09:30", "10:00", "10:30", "11:00", "11:30", "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00"]),
                                   BookingData(date: "2021-5-4", times: ["09:00", "09:30", "10:00", "10:30", "11:00", "11:30"]),
                                   BookingData(date: "2021-5-5", times: ["09:00", "09:30", "10:00", "10:30", "11:00", "11:30", "12:00", "13:00", "13:30", "14:00", "14:30"]),
                                   BookingData(date: "2021-5-6", times: ["09:00", "09:30", "10:00", "10:30", "11:00", "11:30", "12:00", "12:30"]),
                                   BookingData(date: "2021-5-7", times: ["09:00", "09:30", "10:00", "10:30", "11:00", "11:30", "12:00", "12:30", "13:00", "13:30", "14:00"])]
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "AVAILABLE_TIMES".localized()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var weekView: WeekView = {
        let wView = WeekView()
        wView.delegate = self
        wView.translatesAutoresizingMaskIntoConstraints = false
        return wView
    }()

    lazy var collectionView: UICollectionView = {
        let cView = UICollectionView(frame: .zero, collectionViewLayout: FlexibleLayout())
        cView.delegate = self
        cView.dataSource = self
        cView.backgroundColor = .clear
        cView.register(cellTypes: ClassTimeCollectionViewCell.self)
        cView.register(reusableViewType: WeekDayCollectionReusableView.self)
        cView.translatesAutoresizingMaskIntoConstraints = false
        return cView
    }()
    
    var networkManager: NetworkManager!

    //MARK: - Init
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutViews()
        let thisWeek = Date.today().week
        fetchData(start: thisWeek.first, end: thisWeek.last)
    }
    
    func layoutViews() {
        layoutTitleLabel()
        layoutWeekView()
        layoutCollectionView()
    }
    
    func layoutTitleLabel() {
        self.view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
    }
    
    func layoutWeekView() {
        self.view.addSubview(weekView)
        weekView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor).isActive = true
        weekView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        weekView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        weekView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func layoutCollectionView() {
        self.view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: weekView.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.reloadData()
    }
    
    private func fetchData(start: Date?, end: Date?) {
        guard let start = start, let end = end else { return }
        self.networkManager.getSchedule(start: start, end: end) { (scheduleModel, err) in
            if let error = err {
                print("fetch data error: \(error)")
            }
            
            //TODO:(Sean) 1.convert scheduleModel to BookingData
            print("schedule model: \(String(describing: scheduleModel))")
        }

    }
}

extension ClassBookingViewController: WeekViewDelegate {
    func weekDidChanged(_ week: [Date]) {
        print("week changed: \(week)")
        fetchData(start: week.first, end: week.last)
        collectionView.reloadData()
    }
}

extension ClassBookingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return mockData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mockData[section].times.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: ClassTimeCollectionViewCell.self, for: indexPath)
        cell.timeStr = mockData[indexPath.section].times[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableView(with: WeekDayCollectionReusableView.self, for: indexPath)
            //TODO:(Sean) 資料型態改變就不用date.date!
            headerView.setupWeekDay(date: mockData[indexPath.section].date.date ?? Date())
            return headerView

        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
