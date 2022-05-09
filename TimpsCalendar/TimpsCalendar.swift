//
//  TimpsCalendar.swift
//  TimpsCalendar
//
//  Created by Hazarath on 03/05/22.
//

import Foundation
import UIKit

public class TimpsCalendar: UIView {

    // Private variables
    private var calendarCollection: UICollectionView?

    private var collectionItemSize: CGSize = .zero

    private var headerHeight: CGFloat = 80

    private var currentDate: Date!

    private var daysCount : Int = 0

    private var currentSelectedDate: Date = Date()

    private var lastSelectedDate: Date?

    private var celltype: CellType = .calendar

    private var startDayOfMonth : Date?

    // Public variables
    public var calendarType: CalendarType = .normal {
        didSet {
            self.reloadCalender()
        }
    }

    public var delegate: TimpsCalendarDelegate?

    private var monthFormatter: DateFormatter {
        let f = DateFormatter()
        f.dateFormat = "MMM YYYY"
        return f
    }

    private var weekdayFormatter: DateFormatter {
        let f = DateFormatter()
        f.dateFormat = "EEEEE"
        return f
    }

   public override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit() {
        currentDate = Date()
        let firstWeekday = currentDate.firstDayOfTheMonth.weekday
        startDayOfMonth = Calendar.current.date(byAdding: .day, value: -firstWeekday + 1, to: currentDate.firstDayOfTheMonth)!
        self.headerHeight = (calendarType == .normal) ? 60 : 80
        self.backgroundColor = .white
        setupCalendarView()
        registerCalendarViews()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        getDaysCount()
    }

    private func setupCalendarView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        calendarCollection = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        self.addSubview(calendarCollection!)
    }

    private func registerCalendarViews() {
        self.calendarCollection?.dataSource = self
        self.calendarCollection?.delegate = self
        self.calendarCollection?.register(TimpsDateViewer.self, forCellWithReuseIdentifier: TimpsDateViewer.cellID)
        self.calendarCollection?.register(TimpsDatePickerView.self, forCellWithReuseIdentifier: TimpsDatePickerView.cellID)
        self.calendarCollection?.register(TimpsQuickDatePicker.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader , withReuseIdentifier: TimpsQuickDatePicker.headerID)
        self.calendarCollection?.register(TimpsNormalDatePicker.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader , withReuseIdentifier: TimpsNormalDatePicker.headerID)
    }

    private func reloadCalender() {
        self.headerHeight = (calendarType == .normal) ? 60 : 80
        if celltype == .calendar {
            let firstWeekday = currentDate.firstDayOfTheMonth.weekday
            startDayOfMonth = Calendar.current.date(byAdding: .day, value: -firstWeekday + 1, to: currentDate.firstDayOfTheMonth)!
            getDaysCount()
        }
        self.calendarCollection?.reloadData()
    }

    private func getDaysCount() {
        daysCount = 0
        for i in 1...42 {
            let newdate = Calendar.current.date(byAdding: .day, value: i, to: startDayOfMonth!)!
            if newdate.startDay().get(.year) > currentDate.startDay().get(.year) {
                // Next year
            } else if newdate.startDay().get(.month) > currentDate.startDay().get(.month) {
                if newdate.startDay().get(.year) < currentDate.startDay().get(.year) {
                    daysCount += 1
                }
            } else {
                daysCount += 1
            }
        }
        getCollectionSize()
    }

    private func getCollectionSize() {
        let customWidth = self.bounds.size.width * 0.9
        let customHeight = (self.bounds.size.height - headerHeight) * 0.9
        let dateRowsCount = (Float(daysCount + 7)/Float(7.0)).rounded(.up)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionItemSize =  CGSize(width: customWidth/7, height: customHeight/CGFloat(dateRowsCount))
        self.calendarCollection?.reloadData()
    }
}


extension TimpsCalendar: UICollectionViewDataSource {

    public  func numberOfSections(in collectionView: UICollectionView) -> Int {
        if celltype == .calendar {
            return 2
        } else {
            return 1
        }
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if celltype == .calendar {
            if section == 0 {
                return 7
            } else {
                return daysCount
            }
        } else {
            return 1
        }
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if celltype == .calendar {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimpsDateViewer.cellID, for: indexPath) as! TimpsDateViewer
            if indexPath.section == 0 {
                let weekdayDate = Calendar.current.date(byAdding: .day, value: indexPath.item, to: startDayOfMonth!)!
                cell.configureWeekString(weekStr: weekdayFormatter.string(from: weekdayDate))
            } else {
                let newdate = Calendar.current.date(byAdding: .day, value: indexPath.item, to: startDayOfMonth!)!
                cell.configureDayDetails(currentDate: currentDate, cellDate: newdate.localDate(), currentSelectedDate: lastSelectedDate)
            }
            return cell
        } else  {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimpsDatePickerView.cellID, for: indexPath) as! TimpsDatePickerView
            cell.delegate = self
            cell.setupViews(cellType: celltype, currentDate: currentSelectedDate)
            return cell
        }
    }

    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0, kind == UICollectionElementKindSectionHeader {
            if calendarType == .quick {
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TimpsQuickDatePicker.headerID, for: indexPath) as! TimpsQuickDatePicker
                view.delegate = self
                view.updateSelectedDate(date: currentSelectedDate)
                return view
            } else {
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TimpsNormalDatePicker.headerID, for: indexPath) as! TimpsNormalDatePicker
                view.delegate = self
                view.updateNewDate(date: currentSelectedDate, cellType: self.celltype)
                return view
            }
        } else {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TimpsNormalDatePicker.headerID, for: indexPath)
            return view
        }
    }
}

extension TimpsCalendar: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if celltype == .calendar {
            return collectionItemSize
        } else {
            return CGSize(width: self.bounds.width, height: self.bounds.height - headerHeight)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: self.bounds.width, height: headerHeight)
        } else {
            return .zero
        }
    }

}


extension TimpsCalendar: UICollectionViewDelegate {

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedDate = Calendar.current.date(byAdding: .day, value: indexPath.item, to: startDayOfMonth!) {
            lastSelectedDate = selectedDate.localDate()
            self.delegate?.selectedDate(date: lastSelectedDate!)
            self.calendarCollection?.reloadData()
        }
    }

}


extension TimpsCalendar: TimpsQuickDatePickerDelegate, TimpsDatePickerViewDelegate {
    func selectedDate(date: Date) {
        currentDate = date
        currentSelectedDate = date
        reloadCalender()
    }
}


extension TimpsCalendar: TimpsNormalDatePickerDelegate {

    func showDateSelection() {
        self.celltype = (self.celltype == .datePicker) ? .calendar : .datePicker
        self.reloadCalender()
    }

    func showTimeSelection() {
        self.celltype = (self.celltype == .timePicker) ? .calendar : .timePicker
        self.reloadCalender()
    }

}
