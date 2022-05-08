//
//  KalaCell.swift
//  KalaCalendar
//
//  Created by airtel on 03/05/22.
//

import Foundation



class TimpsDateViewer: UICollectionViewCell {

    static let cellID : String = "TimpsDateViewer"

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
        addSubViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubViews() {
        self.addSubview(dateBg)
        self.addSubview(dateLabel)
        setupConstraint()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        dateBg.layer.cornerRadius = min(dateBg.frame.size.height, dateBg.frame.size.width)/2
        dateBg.layer.masksToBounds = true
    }

    func setupConstraint() {
        // Date background view constraints
        dateBg.widthAnchor.constraint(equalToConstant: min(self.bounds.width, self.bounds.height)).isActive = true
        dateBg.heightAnchor.constraint(equalToConstant: min(self.bounds.width, self.bounds.height)).isActive = true
        dateBg.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dateBg.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        // Date viewer constraints
        dateLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }

    func configureWeekString(weekStr : String) {
        dateBg.layer.shadowColor = UIColor.clear.cgColor
        dateBg.isHidden = false
        dateBg.backgroundColor = UIColor.clear
        dateLabel.text = weekStr
        dateLabel.textColor = UIColor.darkGray
        dateLabel.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        dateLabel.contentMode = .scaleAspectFit
    }

    func configureDayDetails(currentDate : Date, cellDate : Date, currentSelectedDate: Date?) {
        dateBg.backgroundColor = UIColor.clear
        dateLabel.textColor = UIColor.darkGray.withAlphaComponent(0.8)
        dateLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        dateLabel.text = "\(Calendar.current.dateComponents([.day], from: cellDate).day ?? 0)"
        if Calendar.current.isDate(cellDate, equalTo: currentDate, toGranularity: .month) {
            if Calendar.current.isDate(cellDate, inSameDayAs: Date()) {
                handleDays(day: .today)
            } else {

                if cellDate > Date() {
                    handleDays(day: .futureDay)
                } else {
                    handleDays(day: .currentMonthDay)
                }
            }
            if cellDate.startDay() == currentSelectedDate {
                dateBg.backgroundColor = UIColor.lightGray
                dateLabel.textColor = UIColor.black
            }
        } else {
            handleDays(day: .lastMonthDay)
        }
    }

    func handleDays(day : DayType) {
        switch day {
        case .today:
            // dateLabel.text = "Today"
            dateBg.isHidden = false
            dateBg.backgroundColor = TimpsConstants.themeColor
            dateLabel.textColor = UIColor.white
            break
        case .currentMonthDay:
            dateBg.isHidden = false
            dateLabel.isHidden = false
            break
        case .futureDay:
            dateBg.isHidden = false
            dateLabel.isHidden = false
            break
        case .lastMonthDay:
            dateLabel.isHidden = false
            dateLabel.text = ""
            break
        }
    }
}
