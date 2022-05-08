//
//  KalaPlainTimeMover.swift
//  KalaCalendar
//
//  Created by airtel on 06/05/22.
//

import Foundation
import UIKit

class TimpsNormalDatePicker: UICollectionReusableView {

    static let headerID = "TimpsNormalDatePicker"

    let dateDisplayButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    let timeDisplayButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("6:47 AM", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let calendarButton: UIButton = {
        let button = UIButton(type: .custom)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()


    var delegate: TimpsNormalDatePickerDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func addSubViews() {
        self.addSubview(calendarButton)
        self.addSubview(dateDisplayButton)
        //self.addSubview(timeDisplayButton)
        setupConstraints()
        addActions()

        let bundle = Bundle(for: TimpsCalendar.self)
        let calendarImg = UIImage(named: "calendar", in: bundle, compatibleWith: .none)
        calendarButton.setImage(calendarImg, for: .normal)
    }

    func updateNewDate(date: Date, cellType: CellType) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM, yyyy"
        let newdate = dateFormatter.string(from: date)
        self.dateDisplayButton.setTitle(newdate, for: .normal)
        if cellType == .calendar {
            self.dateDisplayButton.setTitleColor(.black, for: .normal)
        } else {
            self.dateDisplayButton.setTitleColor(TimpsConstants.themeColor, for: .normal)
        }
    }

    func setupConstraints() {
        calendarButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        calendarButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        calendarButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        calendarButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 25).isActive = true

        dateDisplayButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 60).isActive = true
        dateDisplayButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        dateDisplayButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        dateDisplayButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
    }

    func addActions() {
        calendarButton.addTarget(self, action: #selector(showTodayDateAndTime), for: .touchUpInside)
        dateDisplayButton.addTarget(self, action: #selector(showDateSelectionView), for: .touchUpInside)
        timeDisplayButton.addTarget(self, action: #selector(showTimeSelectionView), for: .touchUpInside)
    }

    @objc func showTodayDateAndTime() {
        self.delegate?.selectedDate(date: Date().startDay())
    }
    @objc func showDateSelectionView() {
        self.delegate?.showDateSelection()

    }
    @objc func showTimeSelectionView() {
        self.delegate?.showTimeSelection()
    }
    
}
