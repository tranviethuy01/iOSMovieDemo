//
//  Date.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//

import Foundation
import UIKit

extension Date {
    var ldiso8601: String {
        return DateFormatter.iso8601.string(from: self)
    }
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        return startOfDay.addingTimeInterval(86399)
    }
    var startOfMonth: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
    }
    var endOfMonth: Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!.endOfDay
    }
    
    var startOfWeek: Date {
        let calendar = Calendar.init(identifier: .iso8601)
        return calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!.startOfDay
    }
    var endOfWeek: Date {
        return startOfWeek.startOfDay.addingTimeInterval(86400*7 - 1)
    }
    
    // change phone numer
    struct VietnamDateFormatter {
        
        static var vietnamTimeZone = TimeZone(abbreviation: "ICT")! //Set default timeZone that you want
        
        static func dateFormatter(withFormat format: String) -> DateFormatter {
            let formatter = DateFormatter()
            formatter.timeZone = VietnamDateFormatter.vietnamTimeZone
            formatter.dateFormat = format
            formatter.locale = Locale.init(identifier: "vi_VN")
            return formatter
        }
    }
    
    func convertToHourCreatedAt() -> String? {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        return timeFormatter.string(from: self)
    }
    
    var millisecondsSince1970:Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
        
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval.init(milliseconds) / 1000)
    }
}
