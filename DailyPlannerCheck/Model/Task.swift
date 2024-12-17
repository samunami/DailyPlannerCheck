//
//  Task.swift
//  DailyPlannerCheck
//
//  Created by Alexander on 13.12.2024.
//

import Foundation
import RealmSwift

class Task: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var dateStart: Double = 0
    @objc dynamic var dateFinish: Double = 0
    @objc dynamic var name: String = ""
    @objc dynamic var taskDescription: String = ""

    override static func primaryKey() -> String? {
        return "id"
    }
}


