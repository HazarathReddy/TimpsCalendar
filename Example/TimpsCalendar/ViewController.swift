//
//  ViewController.swift
//  TimpsCalendar
//
//  Created by HazarathReddy on 05/07/2022.
//  Copyright (c) 2022 HazarathReddy. All rights reserved.
//

import UIKit
import TimpsCalendar

class ViewController: UIViewController {

    @IBOutlet weak var calendar: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let timpsCalendar = TimpsCalendar(frame: calendar.bounds)
        timpsCalendar.calendarType = .normal
        timpsCalendar.delegate = self
        self.calendar.addSubview(timpsCalendar)

//        calendar.layer.cornerRadius = 10
//        calendar.layer.borderWidth = 1.0
//        calendar.layer.borderColor = UIColor.darkGray.withAlphaComponent(0.3).cgColor
//        calendar.layer.masksToBounds = true
//        calendar.calendarType = .quick
//        calendar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: TimpsCalendarDelegate {
    func selectedDate(date: Date) {
        debugPrint("Selected date: \(date)")
    }
}

