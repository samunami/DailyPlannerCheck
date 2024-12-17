//
//  TaskDetailViewController.swift
//  DailyPlannerCheck
//
//  Created by Alexander on 13.12.2024.
//

import UIKit

class TaskDetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    var task: Task?

    override func viewDidLoad() {
        super.viewDidLoad()
        displayTaskDetails()
    }

    private func displayTaskDetails() {
        guard let task = task else { return }

        let formatter = DateFormatter()
        formatter.timeStyle = .short

        let startDate = Date(timeIntervalSince1970: task.dateStart)
        let endDate = Date(timeIntervalSince1970: task.dateFinish)

        nameLabel.text = task.name
        timeLabel.text = "\(formatter.string(from: startDate)) - \(formatter.string(from: endDate))"
        descriptionLabel.text = task.taskDescription
    }
}


