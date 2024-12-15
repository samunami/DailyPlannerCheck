//
//  TaskListViewController.swift
//  DailyPlannerCheck
//
//  Created by Alexander on 13.12.2024.
//

import UIKit

class TaskListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    
    var tasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Загрузка задач
        loadTasks(for: datePicker.date)
    }
    
    private let taskService = TaskService()
    
    private func loadTasks(for date: Date) {
        tasks = taskService.getTasks(for: date)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTaskDetail",
           let detailVC = segue.destination as? TaskDetailViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            
            
            let task = tasks[indexPath.row]
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            
            
            detailVC.task = (
                name: task.name,
                date: "\(formatter.string(from: task.dateStart)) - \(formatter.string(from: task.dateFinish))",
                description: task.description
                
            )
        }
    }
    
    // Обработка изменения даты
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        print("Дата изменена: \(sender.date)")
        loadTasks(for: sender.date)
    }
}

extension TaskListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "TaskCell")
        
        let task = tasks[indexPath.row]
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        
        let startTime = formatter.string(from: task.dateStart)
        let endTime = formatter.string(from: task.dateFinish)
        
        cell.textLabel?.text = task.name
        cell.detailTextLabel?.text = "\(startTime) - \(endTime)"
        
        return cell
    }
}
// Переход на экран
extension TaskListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Выбрана задача: \(tasks[indexPath.row].name)")
        performSegue(withIdentifier: "showTaskDetail", sender: nil)
    }
    
}

