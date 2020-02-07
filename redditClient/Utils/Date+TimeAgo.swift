//
//  Date+TimeAgo.swift
//  redditClient
//
//  Created by Mauro Gonzalez on 24/01/2020.
//  Copyright © 2020 mgonzalez. All rights reserved.
//

import Foundation

extension Date {
    func timeAgo() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute, .second]
        formatter.zeroFormattingBehavior = .dropAll
        formatter.maximumUnitCount = 1
        return String(format: formatter.string(from: self, to: Date()) ?? "", locale: .current) + " ago"
    }
}