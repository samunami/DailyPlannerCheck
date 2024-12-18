//
//  File.swift
//  DailyPlannerCheckTests
//
//  Created by Alexander on 19.12.2024.
//

import XCTest
@testable import DailyPlannerCheck

final class TaskServiceTests: XCTestCase {
    var taskService: TaskService!

    override func setUp() {
        super.setUp()
        taskService = TaskService.shared
        taskService.addSampleTasks() // Добавим пример задач, если есть метод для этого
    }

    override func tearDown() {
        taskService = nil
        super.tearDown()
    }

    func testFetchTasksForSpecificDate() {
        let date = Date(timeIntervalSince1970: 147600000) // Дата из JSON
        let tasks = taskService.getTasks(for: date)
        XCTAssertFalse(tasks.isEmpty, "Список задач для выбранной даты должен быть непустым")
    }

    func testAddTask() {
        let task = Task()
        task.id = 100
        task.name = "Test Task"
        task.dateStart = 147620000
        task.dateFinish = 147630000
        task.taskDescription = "Описание тестовой задачи"
        
        taskService.saveTask(task)
        let fetchedTasks = taskService.getTasks(for: Date(timeIntervalSince1970: 147620000))
        XCTAssertTrue(fetchedTasks.contains(where: { $0.id == 100 }), "Задача должна быть добавлена и найдена в списке")
    }
}
