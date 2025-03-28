//
//  Date+relativaTimeStamp.swift
//  InstagramClone
//
//  Created by 영석 on 3/28/25.
//

import Foundation


extension Date {
    func relativeTimeString() -> String {
        let now = Date()
        let currentYear = Calendar.current.component(.year, from: now)
        let thisYearFirstDay = Calendar.current.date(from: DateComponents(year: currentYear, month: 1, day: 1))!
        let components = Calendar.current.dateComponents([.second,.minute,.hour,.day,.weekOfMonth,.month], from: self, to: now)
        
        if let month = components.month, month >= 1 {
            let dataFormatter = DateFormatter()
            
            
            // 이 날짜가 올해 1우러 1일 이전인지 하ㅗㄱ인
            if self < thisYearFirstDay {
                dataFormatter.dateFormat = "yyyy년 MM월 dd일"
            }else {
                dataFormatter.dateFormat = "MM월 dd일"
            }
            
            return dataFormatter.string(from: self)
        }else if let week = components.weekOfMonth, week >= 1 {
            return "\(week)주 전"
        }else if let day = components.day, day >= 1 {
            return "\(day)일 전"
        }else if let hour = components.hour, hour >= 1 {
            return "\(hour)시간 전"
        }else if let minute = components.minute, minute >= 1 {
            return "\(minute)분 전"
        }else if let second = components.second, second >= 1 {
            return "\(second)초 전"
        }else  {
            return "방금 전"
        }
    }
}
