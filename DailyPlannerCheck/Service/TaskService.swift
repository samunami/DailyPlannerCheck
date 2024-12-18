//
//  TaskService.swift
//  DailyPlannerCheck
//
//  Created by Alexander on 13.12.2024.
//




import Foundation
import RealmSwift

class TaskService {
    static let shared = TaskService()
    private let realm = try! Realm()

    // Загрузка задач из JSON и сохранение в Realm
    func fetchTasksFromJSON() {
        guard let url = Bundle.main.url(forResource: "tasks", withExtension: "json") else {
            print("Не удалось найти tasks.json")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                try realm.write {
                    for json in jsonArray {
                        let task = TaskModel()
                        task.id = json["id"] as? Int ?? 0
                        task.dateStart = json["dateStart"] as? Double ?? 0
                        task.dateFinish = json["dateFinish"] as? Double ?? 0
                        task.name = json["name"] as? String ?? ""
                        task.taskDescription = json["description"] as? String ?? ""
                        realm.add(task, update: .modified)
                    }
                }
            }
        } catch {
            print("Ошибка при загрузке JSON: \(error)")
        }
    }

    // Получение задач
    func getTasks(for date: Date) -> [TaskModel] {
        let startOfDay = Calendar.current.startOfDay(for: date).timeIntervalSince1970
        let endOfDay = startOfDay + 86400

        let tasks = realm.objects(TaskModel.self)
            .filter("dateStart >= %@ AND dateStart < %@", startOfDay, endOfDay)
            .sorted(byKeyPath: "dateStart", ascending: true)

        return Array(tasks)
    }
}



