//
//  TimpDelegates.swift
//  TimpsCalendar
//
//  Created by airtel on 07/05/22.
//

import Foundation


public protocol TimpsCalendarDelegate {
    func selectedDate(date: Date)
}

protocol TimpsDatePickerDelegate {
    func selectedDate(date: Date)
}

protocol TimpsDatePickerViewDelegate {
    func selectedDate(date: Date)
}

protocol TimpsNormalDatePickerDelegate {
    func showDateSelection()
    func showTimeSelection()
    func selectedDate(date: Date)
}

protocol TimpsQuickDatePickerDelegate {
    func selectedDate(date: Date)
}


