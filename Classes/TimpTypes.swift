//
//  TimpTypes.swift
//  TimpsCalendar
//
//  Created by airtel on 07/05/22.
//

import Foundation

public enum CalendarType {
    case normal
    case quick
}

enum CellType {
    case calendar
    case datePicker
    case timePicker
}

enum DayType {
    case currentMonthDay
    case futureDay
    case lastMonthDay
    case today
}

enum DatePickerComponent : Int
{
    case month, year
}

enum DatePickerDayType : Int
{
    case today, selected
}
