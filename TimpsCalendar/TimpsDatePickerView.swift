//
//  KalaDatePickerCell.swift
//  KalaCalendar
//
//  Created by airtel on 06/05/22.
//

import Foundation
import UIKit

class TimpsDatePickerView: UICollectionViewCell {

    static let cellID : String = "TimpsDatePickerView"
    var datePicker: TimpsDatePicker?
    var timePicker: UIDatePicker!
    var delegate: TimpsDatePickerViewDelegate?
    let dateBg : UIView = {
        let bgView = UIView()
        bgView.translatesAutoresizingMaskIntoConstraints = false
        return bgView
    }()

    let dateLabel: UILabel = {
        let dateLbl = UILabel()
        dateLbl.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        dateLbl.textColor = .darkGray
        dateLbl.translatesAutoresizingMaskIntoConstraints = false
        dateLbl.textAlignment = .center
        return dateLbl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews(cellType: CellType, currentDate: Date) {
        if cellType == .datePicker {
            if datePicker != nil {
                datePicker?.removeFromSuperview()
                datePicker = nil
            }
            datePicker = TimpsDatePicker(frame: self.bounds)
            datePicker?.timpsDelegate = self
            datePicker?.updateSelectedDate(date: currentDate)
            self.addSubview(datePicker!)
            self.setupConstraintForDatePicker()
        }
    }

    func setupConstraintForDatePicker() {
        datePicker?.topAnchor.constraint(equalTo: topAnchor).isActive = true
        datePicker?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        datePicker?.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        datePicker?.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
}

extension TimpsDatePickerView: TimpsDatePickerDelegate {
    func selectedDate(date: Date) {
        self.delegate?.selectedDate(date: date)
    }
}
