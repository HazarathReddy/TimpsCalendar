//
//  TimpDates.swift
//  TimpsCalendar
//
//  Created by airtel on 07/05/22.
//

import Foundation

extension Date {
    var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }

    var firstDayOfTheMonth: Date! {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self))
    }

    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }

    func localDate() -> Date {
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: self))
        guard let localDate = Calendar.current.date(byAdding: .second,
                                                    value: Int(timeZoneOffset),
                                                    to: self
        ) else {return self}
        return localDate
    }

    func startDay() -> Date {
        var currentCalendar = Calendar.current
        currentCalendar.timeZone = TimeZone(secondsFromGMT: 0) ?? TimeZone.current
        return currentCalendar.startOfDay(for: self)
    }
}
