//
//  ViewController.swift
//  TimpsCalendar
//
//  Created by HazarathReddy on 05/07/2022.
//  Copyright (c) 2022 HazarathReddy. All rights reserved.
//

import UIKit
import TimpsCalendar

class ViewController: UIViewController, TimpsCalendarDelegate {
    func selectedDate(date: Date) {

        print("#34 get date \(date)")
    }


    @IBOutlet weak var calendar: TimpsCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        calendar.layer.cornerRadius = 10
        calendar.layer.borderWidth = 1.0
        calendar.layer.borderColor = UIColor.darkGray.cgColor
        calendar.layer.masksToBounds = true
        calendar.calendarType = .normal
        calendar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

