//
//  TaskDetailViewController.swift
//  DailyPlannerCheck
//
//  Created by Alexander on 13.12.2024.
//

import UIKit

class TaskDetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var task: (name: String, date: String, description: String)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let task = task {
            nameLabel.text = task.name
            dateLabel.text = task.date
            descriptionLabel.text = task.description
        }
    }
}
