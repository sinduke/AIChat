//
//  Date+EXT.swift
//  AIChat
//
//  Created by sinduke on 7/22/25.
//

import SwiftUI

/// Adds time interval using days/hours/minutes/seconds, does NOT conflict with native `addingTimeInterval(_:)`.
extension Date {
    /// 根据天、时、分、秒偏移，返回新的日期
    func addingTimeInterval(
        days: Int = 0,
        hours: Int = 0,
        minutes: Int = 0,
        seconds: Int = 0
    ) -> Date {
        let totalSeconds =
            seconds +
            (minutes * 60) +
            (hours * 3600) +
            (days * 86400)
        
        return self.addingTimeInterval(TimeInterval(totalSeconds))
    }
}
