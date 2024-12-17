//
//  TaskService.swift
//  DailyPlannerCheck
//
//  Created by Alexander on 13.12.2024.
//





import Foundation

class TaskService {
    static let shared = TaskService()
    
    func fetchTasks(completion: @escaping ([Task]?) -> Void) {
        
        guard let url = Bundle.main.url(forResource: "tasks", withExtension: "json") else {
            print("Ошибка: файл tasks.json не найден")
            completion(nil)
            return
        }
        
        
        do {
            let data = try Data(contentsOf: url)
            let tasks = try JSONDecoder().decode([Task].self, from: data)
            completion(tasks)
        } catch {
            print("Ошибка при декодировании JSON: \(error.localizedDescription)")
            completion(nil)
        }
    }
}

