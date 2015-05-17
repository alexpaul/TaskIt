//
//  Date.swift
//  TaskIt
//
//  Created by Alex Paul on 5/10/15.
//  Copyright (c) 2015 Alex Paul. All rights reserved.
//

import Foundation


class Date {
    class func from (#year: Int, month: Int, day: Int) -> NSDate{
    
        var components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        var gregorianCalendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        var date = gregorianCalendar?.dateFromComponents(components)
        
        return date!
    }
    
    class func toString (#date: NSDate) -> String{
        let dateStringFormatter = NSDateFormatter()                 // NSDateFormatter instance
        dateStringFormatter.dateFormat = "yyyy-MM-dd"               // date format string
        let dateString = dateStringFormatter.stringFromDate(date)
        
        return dateString
    }
}