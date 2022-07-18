//
//  DateExtension.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

extension Date {
    
    // MARK:- DATE FORMAT ENUM
    //==========================
    enum DateFormat : String {
        
        // case yyyy_MM_dd = "yyyy-MM-dd"
        case EMMDYYHHMMSS       = "E MMM d yyyy HH:mm:ss"
        case dMMMyyyyhma = "d MMM, yyyy, hh:mm a"
        case yyyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss"
        case yyyyMMddTHHmmssz = "yyyy-MM-dd'T'HH:mm:ssZ"
        case yyyyMMddTHHmmssssZZZZZ = "yyyy-MM-dd'T'HH:mm:ss.ssZZZZZ"
        case yyyyMMddTHHmmssSSSXXXXX = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        case yyyyMMdd = "yyyy/MM/dd"
        case dMMMyyyy = "d MMM, yyyy"
        case ddMMMyyyy = "dd MMM, yyyy"
        case ddMMMyyy = "dd MMM yyyy"
        case dddMMMYYYY = "MM-dd-yyyy"
        case MMMdyyyy = "MMM d, yyyy"
        case hmmazzz = "h:mm a zzz"
        case hhmm   = "hh:mm a"
        case dd = "d"
        case ddMM = "d MMM"
        case hh = "hh"
        case hha = "hh a"
        case EE = "E"
        case EEEE = "EEE"
        case EEEEdMMM = "EEEE d MMM"
        case EEEEdMMMHA = "EEEE d MMM, hh:mm a"
        case MMMddYYYY = "MMMM d, yyyy"
        case MMddyyyy = "dd-MM-yyyy"
        case ddMMM = "MMM dd"
        case EEddMMMyyyy = "EE, dd MMM yyyy"
        case ddMMYYHHMMM = "dd MMM yyyy - hh:mm a"
        case EEdMMMHA = "EE d MMM, hh:mm a"
        case EMMDYYY = "E MMM d yyyy"
        case EdMMMHA = "EE, d MMM yyyy, hh:mm a"
        case yyyyMMddd = "yyyy-MM-dd"
    }
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    var startOfMonth: Date {
        let components = Calendar.current.dateComponents([.year, .month], from: startOfDay)
        return Calendar.current.date(from: components)!
    }
    
    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfMonth)!
    }
    
    var nanosecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(nonoseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(nonoseconds) / 1000)
    }
    
    var isToday:Bool{
        return Calendar.current.isDateInToday(self)
    }
    var isYesterday:Bool{
        return Calendar.current.isDateInYesterday(self)
    }
    var isTomorrow:Bool{
        return Calendar.current.isDateInTomorrow(self)
    }
    var isWeekend:Bool{
        return Calendar.current.isDateInWeekend(self)
    }
    var year:Int{
        return (Calendar.current as NSCalendar).components(.year, from: self).year!
    }
    var month:Int{
        return (Calendar.current as NSCalendar).components(.month, from: self).month!
    }
    var weekOfYear:Int{
        return (Calendar.current as NSCalendar).components(.weekOfYear, from: self).weekOfYear!
    }
    var weekday:Int{
        return (Calendar.current as NSCalendar).components(.weekday, from: self).weekday!
    }
    var weekdayOrdinal:Int{
        return (Calendar.current as NSCalendar).components(.weekdayOrdinal, from: self).weekdayOrdinal!
    }
    var weekOfMonth:Int{
        return (Calendar.current as NSCalendar).components(.weekOfMonth, from: self).weekOfMonth!
    }
    var day:Int{
        return (Calendar.current as NSCalendar).components(.day, from: self).day!
    }
    var hour:Int{
        return (Calendar.current as NSCalendar).components(.hour, from: self).hour!
    }
    var minute:Int{
        return (Calendar.current as NSCalendar).components(.minute, from: self).minute!
    }
    var second:Int{
        return (Calendar.current as NSCalendar).components(.second, from: self).second!
    }
    var numberOfWeeks:Int{
        let weekRange = (Calendar.current as NSCalendar).range(of: .weekOfYear, in: .month, for: Date())
        return weekRange.length
    }
    var unixTimestamp:Double {
        
        return self.timeIntervalSince1970
    }
    
    func toMillis() -> Double! {
        return Double(self.timeIntervalSince1970 * 1000)
    }
    
    func yearsFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.year, from: date, to: self, options: []).year!
    }
    func monthsFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.month, from: date, to: self, options: []).month!
    }
    func weeksFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.weekOfYear, from: date, to: self, options: []).weekOfYear!
    }
    func weekdayFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.weekday, from: date, to: self, options: []).weekday!
    }
    func weekdayOrdinalFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.weekdayOrdinal, from: date, to: self, options: []).weekdayOrdinal!
    }
    func weekOfMonthFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.weekOfMonth, from: date, to: self, options: []).weekOfMonth!
    }
    func daysFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.day, from: date, to: self, options: []).day!
    }
    func hoursFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.hour, from: date, to: self, options: []).hour!
    }
    func minutesFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.minute, from: date, to: self, options: []).minute!
    }
    func secondsFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.second, from: date, to: self, options: []).second!
    }
    func offsetFrom(_ date:Date) -> String {
        if yearsFrom(date)   > 0 { return "\(yearsFrom(date))y"   }
        if monthsFrom(date)  > 0 { return "\(monthsFrom(date))M"  }
        if weeksFrom(date)   > 0 { return "\(weeksFrom(date))w"   }
        if daysFrom(date)    > 0 { return "\(daysFrom(date))d"    }
        if hoursFrom(date)   > 0 { return "\(hoursFrom(date))h"   }
        if minutesFrom(date) > 0 { return "\(minutesFrom(date))m" }
        if secondsFrom(date) > 0 { return "\(secondsFrom(date))s" }
        return ""
    }
    
    ///Converts a given Date into String based on the date format and timezone provided
    func toString(dateFormat:String,timeZone:TimeZone = TimeZone.current)->String{
        
        let frmtr = DateFormatter()
        frmtr.locale = Locale(identifier: "en_US_POSIX")
        frmtr.dateFormat = dateFormat
        frmtr.timeZone = timeZone
        return frmtr.string(from: self)
    }
    
    static func getDates(forLastNDays nDays: Int) -> [Date] {
        let cal = NSCalendar.current
        let date = cal.startOfDay(for: Date())
        var currentDate = cal.date(byAdding: Calendar.Component.day, value: -1, to: date)
        var arrDates = [Date]()
        for _ in 1 ... nDays {
            currentDate = cal.date(byAdding: Calendar.Component.day, value: 1, to: currentDate ?? Date())!
            arrDates.append(currentDate!)
        }
        return arrDates
    }
    
    static func findDateDiff( _ Stime: String, _ Etime: String) -> String {
        let timeformatter = DateFormatter()
        timeformatter.dateFormat = "hh:mm a"
        guard let time1 = timeformatter.date(from: Stime),
              let time2 = timeformatter.date(from: Etime) else { return "" }
        let interval = time2.timeIntervalSince(time1)
        let Finalhour = interval / 3600;
        let Finalminute = interval.truncatingRemainder(dividingBy: 3600) / 60
        //let intervalInt = Int(interval)
        let IntHours = Int(Finalhour)
        let IntMinutes = Int(Finalminute)
        if IntHours == 0{
            return "\(Int(Finalminute)) Min"
        }else if IntMinutes == 0 {
            return "\(Int(Finalhour)) Hour"
        }else{
            return "\(Int(Finalhour)) Hour \(Int(Finalminute)) Min"
        }
        //  return "\(intervalInt < 0 ? "-" : "+") \(Int(hour)) Hours \(Int(minute)) Minutes"
    }
    
    mutating func changeDays(by days: Int) {
        self = Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
    
    func calculateAge() -> Int {
        
        let calendar : Calendar = Calendar.current
        let unitFlags : NSCalendar.Unit = [NSCalendar.Unit.year , NSCalendar.Unit.month , NSCalendar.Unit.day]
        let dateComponentNow : DateComponents = (calendar as NSCalendar).components(unitFlags, from: Date())
        let dateComponentBirth : DateComponents = (calendar as NSCalendar).components(unitFlags, from: self)
        
        if ( (dateComponentNow.month! < dateComponentBirth.month!) ||
                ((dateComponentNow.month! == dateComponentBirth.month!) && (dateComponentNow.day! < dateComponentBirth.day!))
        )
        {
            return dateComponentNow.year! - dateComponentBirth.year! - 1
        }
        else {
            return dateComponentNow.year! - dateComponentBirth.year!
        }
    }
    
    static func zero() -> Date {
        let dateComp = DateComponents(calendar: Calendar.current, timeZone: TimeZone.current, era: 0, year: 0, month: 0, day: 0, hour: 0, minute: 0, second: 0, nanosecond: 0, weekday: 0, weekdayOrdinal: 0, quarter: 0, weekOfMonth: 0, weekOfYear: 0, yearForWeekOfYear: 0)
        return dateComp.date!
    }
    
    func convertToString() -> String {
        // First, get a Date from the String
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.yyyyMMddTHHmmssz.rawValue
        
        // Now, get a new string from the Date in the proper format for the user's locale
        dateFormatter.dateFormat = nil
        dateFormatter.dateStyle = .long // set as desired
        dateFormatter.timeStyle = .medium // set as desired
        let local = dateFormatter.string(from: self)
        return local
    }
    
    func weekDay(from string: String, format: String = "yyyy-MM-dd")->String?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: string){
            let curDay = Calendar.current.component(.weekday, from: date)
            return dateFormatter.shortWeekdaySymbols[curDay - 1]
        }else{
            return nil
        }
    }
    
    func getMonthName(year: Int, month: Int)->String?{
        let dateFormatter = DateFormatter()
        let dateStr = "01-\(month)-\(year)"
        dateFormatter.dateFormat = "dd-MM-yyyy"
        guard let date = dateFormatter.date(from: dateStr) else {
            return nil
        }
        dateFormatter.dateFormat = "MMMM, yyyy"
        return dateFormatter.string(from: date)
    }
    
    var timeAgoSince : String {
        
        let calendar = Calendar.current
        let now = Date()
        let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
        let components = (calendar as NSCalendar).components(unitFlags, from: self, to: now, options: [])
        
        if let year = components.year, year >= 2 {
            return "\(year) years ago"
        }
        
        if let year = components.year, year >= 1 {
            return "Last year"
        }
        
        if let month = components.month, month >= 2 {
            return "\(month) months ago"
        }
        
        if let month = components.month, month >= 1 {
            return "Last month"
        }
        
        if let week = components.weekOfYear, week >= 2 {
            return "\(week) weeks ago"
        }
        
        if let week = components.weekOfYear, week >= 1 {
            return "Last week"
        }
        
        if let day = components.day, day >= 2 {
            return "\(day) days ago"
        }
        
        if let day = components.day, day >= 1 {
            return "Yesterday"
        }
        
        if let hour = components.hour, hour >= 2 {
            return "\(hour) hours ago"
        }
        
        if let hour = components.hour, hour >= 1 {
            return "1 hour ago"
        }
        
        if let minute = components.minute, minute >= 2 {
            return "\(minute) minutes ago"
        }
        
        if let minute = components.minute, minute >= 1 {
            return "1 minute ago"
        }
        
        if let second = components.second, second >= 3 {
            return "\(second) seconds ago"
        }
        
        return "Just now"
    }
    
}


public extension Date {
    
    func plus(seconds s: UInt) -> Date {
        return self.addComponentsToDate(seconds: Int(s), minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    func minus(seconds s: UInt) -> Date {
        return self.addComponentsToDate(seconds: -Int(s), minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    func plus(minutes m: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: Int(m), hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    func minus(minutes m: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: -Int(m), hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    func plus(hours h: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: Int(h), days: 0, weeks: 0, months: 0, years: 0)
    }
    
    func minus(hours h: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: -Int(h), days: 0, weeks: 0, months: 0, years: 0)
    }
    
    func plus(days d: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: Int(d), weeks: 0, months: 0, years: 0)
    }
    
    func minus(days d: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: -Int(d), weeks: 0, months: 0, years: 0)
    }
    
    func plus(weeks w: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: Int(w), months: 0, years: 0)
    }
    
    func minus(weeks w: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: -Int(w), months: 0, years: 0)
    }
    
    func plus(months m: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: Int(m), years: 0)
    }
    
    func minus(months m: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: -Int(m), years: 0)
    }
    
    func plus(years y: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: Int(y))
    }
    
    func minus(years y: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: -Int(y))
    }
    
    fileprivate func addComponentsToDate(seconds sec: Int, minutes min: Int, hours hrs: Int, days d: Int, weeks wks: Int, months mts: Int, years yrs: Int) -> Date {
        var dc = DateComponents()
        dc.second = sec
        dc.minute = min
        dc.hour = hrs
        dc.day = d
        dc.weekOfYear = wks
        dc.month = mts
        dc.year = yrs
        return Calendar.current.date(byAdding: dc, to: self)!
    }
    
    func midnightUTCDate() -> Date {
        var dc: DateComponents = Calendar.current.dateComponents([.year, .month, .day], from: self)
        dc.hour = 0
        dc.minute = 0
        dc.second = 0
        dc.nanosecond = 0
        dc.timeZone = TimeZone(secondsFromGMT: 0)
        return Calendar.current.date(from: dc)!
    }
    
    static func secondsBetween(date1 d1:Date, date2 d2:Date) -> Int {
        let dc = Calendar.current.dateComponents([.second], from: d1, to: d2)
        return dc.second!
    }
    
    static func minutesBetween(date1 d1: Date, date2 d2: Date) -> Int {
        let dc = Calendar.current.dateComponents([.minute], from: d1, to: d2)
        return dc.minute!
    }
    
    static func hoursBetween(date1 d1: Date, date2 d2: Date) -> Int {
        let dc = Calendar.current.dateComponents([.hour], from: d1, to: d2)
        return dc.hour!
    }
    
    static func daysBetween(date1 d1: Date, date2 d2: Date) -> Int {
        let dc = Calendar.current.dateComponents([.day], from: d1, to: d2)
        return dc.day!
    }
    
    static func weeksBetween(date1 d1: Date, date2 d2: Date) -> Int {
        let dc = Calendar.current.dateComponents([.weekOfYear], from: d1, to: d2)
        return dc.weekOfYear!
    }
    
    static func monthsBetween(date1 d1: Date, date2 d2: Date) -> Int {
        let dc = Calendar.current.dateComponents([.month], from: d1, to: d2)
        return dc.month!
    }
    
    static func yearsBetween(date1 d1: Date, date2 d2: Date) -> Int {
        let dc = Calendar.current.dateComponents([.year], from: d1, to: d2)
        return dc.year!
    }
    
    //MARK- Comparison Methods
    
    func isGreaterThan(_ date: Date) -> Bool {
        return (self.compare(date) == .orderedDescending)
    }
    
    func isLessThan(_ date: Date) -> Bool {
        return (self.compare(date) == .orderedAscending)
    }
}

extension Double{
    // returns the date formatted.
    var dateFormatted : String? {
        let date = Date(timeIntervalSince1970: TimeInterval(self/1000.0))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.short //Set date style
        return dateFormatter.string(from: date)
    }
    
    // returns the date formatted according to the format string provided.
    func dateFormatted(withFormat format : String) -> String {
        if Int(self) == 0 {
            return ""
        }
        let date = Date(timeIntervalSince1970: TimeInterval(self/1000.0))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    func calculateTime(style: DateComponentsFormatter.UnitsStyle? = nil) -> String {
        let formatter = DateComponentsFormatter()
        if let style = style {
            formatter.allowedUnits = [.day, .hour, .minute, .second, .nanosecond]
            formatter.unitsStyle = style
            guard let formattedString = formatter.string(from: self) else { return "" }
            return formattedString
        } else {
            formatter.unitsStyle = .brief
            if self > 86400 {
                formatter.allowedUnits = [.day]
            } else if self > 3600 {
                formatter.allowedUnits = [.hour]
            } else if self > 60 {
                formatter.allowedUnits = [.minute]
            } else {
                formatter.allowedUnits = [.second]
            }
            guard let formattedString = formatter.string(from: self) else { return "" }
            return formattedString
        }
    }
}

extension Date {
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 0, to: sunday)
    }
    
    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 6, to: sunday)
    }
    
    var prevStartWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: -7, to: sunday)
        
    }
    
    var prevEndWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: -1, to: sunday)
    }
    
    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {
        let currentCalendar = Calendar.current
        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }
        return end - start
    }
    
    func datesrange(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate
        
        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
}

extension DateComponentsFormatter {
    func difference(from fromDate: Date, to toDate: Date) -> String {
        self.allowedUnits = [.day]
        self.maximumUnitCount = 1
        self.unitsStyle = .full
        let totalDay = self.string(from: fromDate, to: toDate) ?? ""
        return totalDay.components(separatedBy: " ").first ?? ""
    }
}

extension Date {
    static func dateFromCustomString(customString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM-dd-yyyy"
        return dateFormatter.date(from: customString) ?? Date()
    }
    
    func reduceToMonthDayYear(date:Date) -> Date {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: self)
        let day = calendar.component(.day, from: self)
        let year = calendar.component(.year, from: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM-dd-yyyy"
        return dateFormatter.date(from: "\(month)-\(day)-\(year)") ?? date//Date()
    }
}
