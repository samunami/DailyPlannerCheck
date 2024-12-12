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
    
    var tasks: [(hour: String, task: String?)] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTaskDetail",
           let detailVC = segue.destination as? TaskDetailViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            
            let task = tasks[indexPath.row]
            
            
            detailVC.task = (name: task.task ?? "No Name",
                             date: task.hour,
                             description: "Описание задачи")
        }
    }
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        print("Дата изменена: \(sender.date)")
        loadTasks(for: sender.date)
    }
    
    private func generateEmptySchedule() {
        tasks = (0..<24).map { hour in
            let formattedHour = String(format: "%02d:00 - %02d:00", hour, hour + 1)
            return (hour: formattedHour, task: nil)
        }
        tableView.reloadData()
    }
    
    private func loadTasks(for date: Date) {
       
        generateEmptySchedule()
    }
}

extension TaskListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "TaskCell")
        let item = tasks[indexPath.row]
        cell.textLabel?.text = item.hour
        cell.detailTextLabel?.text = item.task ?? "No task"
        return cell
    }
}

extension TaskListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Выбран час: \(tasks[indexPath.row].hour)")
    }
}


