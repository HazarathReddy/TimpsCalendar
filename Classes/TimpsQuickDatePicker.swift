//
//  KalaTimeMover.swift
//  KalaCalendar
//
//  Created by airtel on 04/05/22.
//

import Foundation

class TimpsQuickDatePicker: UICollectionReusableView {

    static let headerID = "TimpsQuickDatePicker"

    var datePicker: TimpsDatePicker!
    public var delegate: TimpsQuickDatePickerDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubViews() {
        self.backgroundColor = .white
        datePicker = TimpsDatePicker(frame: self.bounds)
        datePicker.timpsDelegate = self
        self.addSubview(datePicker)
        setupConstraint()

    }

    func setupConstraint() {
        datePicker.topAnchor.constraint(equalTo: topAnchor).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        datePicker.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        datePicker.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }

    func updateSelectedDate(date: Date) {
        datePicker.updateSelectedDate(date: date)
    }
}

extension TimpsQuickDatePicker: TimpsDatePickerDelegate {
    func selectedDate(date: Date) {
        delegate?.selectedDate(date: date)
    }
}
