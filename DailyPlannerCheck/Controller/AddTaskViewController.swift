//
//  AddTaskViewController.swift
//  DailyPlannerCheck
//
//  Created by Alexander on 18.12.2024.
//
import UIKit
import RealmSwift

class AddTaskViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    

    
    private func setupUI() {
        descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.cornerRadius = 5
        saveButton.layer.cornerRadius = 8
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let taskName = nameTextField.text, !taskName.isEmpty else {
            showAlert(message: "Введите название задачи")
            return
        }
        
        let startTime = startDatePicker.date.timeIntervalSince1970
        let endTime = endDatePicker.date.timeIntervalSince1970
        
        if endTime <= startTime {
            showAlert(message: "Время окончания должно быть позже времени начала")
            return
        }
        
        let taskDescription = descriptionTextView.text ?? ""
        
        // Создание новой задачи
        let newTask = Task()
        newTask.id = UUID().hashValue
        newTask.name = taskName
        newTask.dateStart = startTime
        newTask.dateFinish = endTime
        newTask.taskDescription = taskDescription
        
        // Сохранение задачи в Realm
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(newTask)
            }
            
            // Возврат на главный экран
            if let navigationController = navigationController {
                navigationController.popViewController(animated: true)
            } else {
                dismiss(animated: true, completion: nil)
            }
        } catch {
            showAlert(message: "Ошибка сохранения задачи: \(error.localizedDescription)")
        }
    }

    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

