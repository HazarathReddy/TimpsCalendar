//
//  DatePicker.swift
//  KalaCalendar
//
//  Created by airtel on 04/05/22.
//

import Foundation
import UIKit

class TimpsDatePicker: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource
{
    private let componentsCount = 2
    var minYear = TimpsConstants.calendarMinYear
    var maxYear = TimpsConstants.calendarMaxYear
    var rowHeight : CGFloat = 30

    var monthFont = UIFont.boldSystemFont(ofSize: 17)
    var monthSelectedFont = UIFont.boldSystemFont(ofSize: 18)

    var yearFont = UIFont.boldSystemFont(ofSize: 17)
    var yearSelectedFont = UIFont.boldSystemFont(ofSize: 18)

    var monthTextColor = UIColor.black
    var monthSelectedTextColor = TimpsConstants.pickerColor

    var yearTextColor = UIColor.black
    var yearSelectedTextColor = TimpsConstants.pickerColor

    private let formatter = DateFormatter.init()
    public var timpsDelegate: TimpsDatePickerDelegate?

    var currentMonthName : String = ""
    var currentYearName : String = ""

    var selectedMonthName : String = ""
    var selectedYearName : String = ""

    private var rowLabel : UILabel
    {
        let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: componentWidth, height: rowHeight))
        label.textAlignment = .center
        label.backgroundColor = UIColor.clear
        return label
    }

    var months : Array<String>
    {
        return [NSLocalizedString("January", comment: ""), NSLocalizedString("February", comment: ""), NSLocalizedString("March", comment: ""), NSLocalizedString("April", comment: ""), NSLocalizedString("May", comment: ""), NSLocalizedString("June", comment: ""), NSLocalizedString("July", comment: ""), NSLocalizedString("August", comment: ""), NSLocalizedString("September", comment: ""), NSLocalizedString("October", comment: ""), NSLocalizedString("November", comment: ""), NSLocalizedString("December", comment: "")]
    }

    var years : Array<String>
    {
        let years = [Int](minYear...maxYear)
        var names = [String]()
        for year in years
        {
            names.append(String(year))
        }
        return names
    }

    private var bigRowMonthCount : Int
    {
        return months.count
    }

    private var bigRowYearCount : Int
    {
        return years.count
    }

    private var componentWidth : CGFloat
    {
        return self.bounds.size.width / CGFloat(componentsCount)
    }

    func getCurrentMonthFromDate(date: Date) -> String {
        formatter.locale = Locale.init(identifier: "en_US")
        formatter.dateFormat = "MMMM"
        let dateString = formatter.string(from: date)
        return NSLocalizedString(dateString, comment: "")
    }

    func getCurrentYearFromDate(date: Date) -> String {
        formatter.locale = Locale.init(identifier: "en_US")
        formatter.dateFormat = "yyyy"
        return formatter.string(from: date)
    }

    var date : Date
    {
        let month = months[selectedRow(inComponent: DatePickerComponent.month.rawValue) % months.count]
        let year = years[selectedRow(inComponent: DatePickerComponent.year.rawValue) % years.count]

        let formatter = DateFormatter.init()
        formatter.dateFormat = "MMMM:yyyy"
        let date = formatter.date(from: "\(month):\(year)")
        return date!
    }

    //MARK: - Override
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        loadDefaultsParameters()
    }

    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        loadDefaultsParameters()
    }

    override func awakeFromNib()
    {
        super.awakeFromNib()
        loadDefaultsParameters()
    }

    //MARK: - Open
    func selectToday()
    {
        selectRow(getIndexPathForDayType(dayType: .today).row, inComponent: DatePickerComponent.month.rawValue, animated: false)
        selectRow(getIndexPathForDayType(dayType: .today).section, inComponent: DatePickerComponent.year.rawValue, animated: false)
    }

    func updateSelectedDate(date: Date) {
        self.selectedMonthName = getCurrentMonthFromDate(date: date)
        self.selectedYearName = getCurrentYearFromDate(date: date)
        selectRow(getIndexPathForDayType(dayType: .selected).row, inComponent: DatePickerComponent.month.rawValue, animated: false)
        selectRow(getIndexPathForDayType(dayType: .selected).section, inComponent: DatePickerComponent.year.rawValue, animated: false)
    }

    func getIndexPathForDayType(dayType: DatePickerDayType) -> NSIndexPath {
        var row = 0
        var section = 0
        let currentMonthName = (dayType == .today) ?  self.currentMonthName : self.selectedMonthName
        let currentYearName = (dayType == .today) ? self.currentYearName : self.selectedYearName

        for month in months
        {
            if month == currentMonthName
            {
                row = months.firstIndex(of: month)!
                break;
            }
        }

        for year in years
        {
            if year == currentYearName
            {
                section = years.firstIndex(of: year)!
                break;
            }
        }
        return NSIndexPath(row: row, section: section)
    }

    //MARK: - UIPickerViewDelegate

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat
    {
        return componentWidth
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
    {
        let label : UILabel
        if view is UILabel
        {
            label = view as! UILabel
        }
        else
        {
            label = rowLabel
        }

        let selected = isSelectedRow(row, component: component)
        label.font = selected ? selectedFontForComponent(component) : fontForComponent(component)
        label.textColor = selected ? selectedColorForComponent(component) : colorForComponent(component)
        label.text = titleForRow(row, component: component)
        return label
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat
    {
        return rowHeight
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let monthRow = pickerView.selectedRow(inComponent: 0)
        let yearRow = pickerView.selectedRow(inComponent: 1)
        let string = "01 \(months[monthRow]) \(years[yearRow])"
        formatter.dateFormat = "dd MMM yyyy"
        if let selectedDate = formatter.date(from: string) {
            timpsDelegate?.selectedDate(date: selectedDate.localDate())
        }
    }


    //MARK: - UIPickerViewDataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return componentsCount
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if component == DatePickerComponent.month.rawValue
        {
            return bigRowMonthCount
        }
        return bigRowYearCount
    }

    //MARK: - Private

    private func loadDefaultsParameters()
    {
        self.currentMonthName = getCurrentMonthFromDate(date: Date())
        self.currentYearName = getCurrentYearFromDate(date: Date())
        delegate = self
        dataSource = self
    }

    private func isSelectedRow(_ row : Int, component : Int) -> Bool
    {
        var selected = false
        if component == DatePickerComponent.month.rawValue
        {
            let name = months[row % months.count]
            if name == currentMonthName
            {
                selected = true
            }
        }
        else
        {
            let name = years[row % years.count]
            if name == currentYearName
            {
                selected = true
            }
        }

        return selected
    }

    private func selectedColorForComponent(_ component : Int) -> UIColor
    {
        if component == DatePickerComponent.month.rawValue
        {
            return monthSelectedTextColor
        }
        return yearSelectedTextColor
    }

    private func colorForComponent(_ component : Int) -> UIColor
    {
        if component == DatePickerComponent.month.rawValue
        {
            return monthTextColor
        }
        return yearTextColor
    }

    private func selectedFontForComponent(_ component : Int) -> UIFont
    {
        if component == DatePickerComponent.month.rawValue
        {
            return monthSelectedFont
        }
        return yearSelectedFont
    }

    private func fontForComponent(_ component : Int) -> UIFont
    {
        if component == DatePickerComponent.month.rawValue
        {
            return monthFont
        }
        return yearFont
    }

    private func titleForRow(_ row : Int, component : Int) -> String
    {
        if component == DatePickerComponent.month.rawValue
        {
            return months[row % months.count]
        }
        return years[row % years.count]
    }
}
