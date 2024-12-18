//
//  TaskListViewController.swift
//  DailyPlannerCheck
//
//  Created by Alexander on 13.12.2024.
//



//
//  TaskListViewController.swift
//  DailyPlannerCheck
//




import UIKit

class TaskListViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func addTaskButtonTapped(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let addTaskVC = storyboard.instantiateViewController(withIdentifier: "AddTaskViewController") as? AddTaskViewController {
            present(addTaskVC, animated: true, completion: nil)
        }
    }


    private var tasks: [Task] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self


        TaskService.shared.fetchTasksFromJSON()
        loadTasks(for: datePicker.date)
    }

    @IBAction func dateChanged(_ sender: UIDatePicker) {
        loadTasks(for: sender.date)
    }

    private func loadTasks(for date: Date) {
        tasks = TaskService.shared.getTasks(for: date)
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTaskDetail" {
            if let destinationVC = segue.destination as? TaskDetailViewController,
               let indexPath = tableView.indexPathForSelectedRow {
                let selectedTask = tasks[indexPath.row]
                destinationVC.task = selectedTask
            }
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

        let startTime = formatter.string(from: Date(timeIntervalSince1970: task.dateStart))
        let endTime = formatter.string(from: Date(timeIntervalSince1970: task.dateFinish))

        cell.textLabel?.text = task.name
        cell.detailTextLabel?.text = "\(startTime) - \(endTime)"

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




