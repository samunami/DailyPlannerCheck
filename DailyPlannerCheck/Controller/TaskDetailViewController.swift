//
//  TaskDetailViewController.swift
//  DailyPlannerCheck
//
//  Created by Alexander on 13.12.2024.
//

//
//  TaskDetailViewController.swift
//  DailyPlannerCheck
//

import UIKit

class TaskDetailViewController: UIViewController {

        @IBOutlet weak var nameLabel: UILabel!
        @IBOutlet weak var timeLabel: UILabel!
        @IBOutlet weak var descriptionLabel: UILabel!

    var task: TaskModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        displayTaskDetails()
        setupBackButton()
    }

    private func setupBackButton() {
        let backButton = UIButton(type: .system)
        backButton.setTitle("Назад", for: .normal)
        backButton.setTitleColor(.systemBlue, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)

        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }

    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
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


