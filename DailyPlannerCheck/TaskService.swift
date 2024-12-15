//
//  TaskService.swift
//  DailyPlannerCheck
//
//  Created by Alexander on 13.12.2024.
//

import Foundation

class TaskService {
    func getTasks(for date: Date) -> [Task] {
        let calendar = Calendar.current
        let task1 = Task(
            id: 1,
            dateStart: calendar.date(bySettingHour: 9, minute: 0, second: 0, of: date)!,
            dateFinish: calendar.date(bySettingHour: 10, minute: 0, second: 0, of: date)!,
            name: "Утренняя задача",
            description: "Описание утренней задачи"
        )
        let task2 = Task(
            id: 2,
            dateStart: calendar.date(bySettingHour: 14, minute: 0, second: 0, of: date)!,
            dateFinish: calendar.date(bySettingHour: 15, minute: 0, second: 0, of: date)!,
            name: "Дневная задача",
            description: "Описание дневной задачи"
        )
        return [task1, task2]
    }
}
