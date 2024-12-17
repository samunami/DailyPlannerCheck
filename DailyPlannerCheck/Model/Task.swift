//
//  Task.swift
//  DailyPlannerCheck
//
//  Created by Alexander on 13.12.2024.
//

import Foundation

struct Task: Codable {
    let id: Int
    let name: String
    let dateStart: TimeInterval
    let dateFinish: TimeInterval
    let description: String
}

