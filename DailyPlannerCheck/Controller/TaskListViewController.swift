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
    
    private var tasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadTasks()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func loadTasks() {
        TaskService.shared.fetchTasks { [weak self] loadedTasks in
            DispatchQueue.main.async {
                if let loadedTasks = loadedTasks {
                    self?.tasks = loadedTasks
                    
                    // минимальная дата UIDatePicker
                    if let earliestTask = loadedTasks.min(by: { $0.dateStart < $1.dateStart }) {
                        let earliestDate = Date(timeIntervalSince1970: earliestTask.dateStart)
                        self?.datePicker.date = earliestDate
                    }
                    
                   
                    self?.filterTasks(by: self?.datePicker.date ?? Date())
                } else {
                    self?.showErrorAlert(message: "Не удалось загрузить задачи.")
                }
            }
        }
    }
    
    
    private func filterTasks(by date: Date) {
        let calendar = Calendar.current
        tasks = tasks.filter { task in
            let taskDate = Date(timeIntervalSince1970: task.dateStart)
            return calendar.isDate(taskDate, inSameDayAs: date)
        }
        tableView.reloadData()
    }
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        filterTasks(by: sender.date)
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTaskDetail",
           let indexPath = tableView.indexPathForSelectedRow,
           let detailVC = segue.destination as? TaskDetailViewController {
            detailVC.task = tasks[indexPath.row]
        }
    }
}

// MARK: - UITableViewDataSource
extension TaskListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        let task = tasks[indexPath.row]
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        
        let startTime = Date(timeIntervalSince1970: task.dateStart)
        let endTime = Date(timeIntervalSince1970: task.dateFinish)
        
        cell.textLabel?.text = task.name
        cell.detailTextLabel?.text = "\(formatter.string(from: startTime)) - \(formatter.string(from: endTime))"
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TaskListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showTaskDetail", sender: nil)
    }
}



