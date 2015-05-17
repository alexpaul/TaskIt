//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by Alex Paul on 5/9/15.
//  Copyright (c) 2015 Alex Paul. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    var detailTaskModel: TaskModel!
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup UI from Previous ViewController 
        self.taskTextField.text = detailTaskModel.task
        self.subtaskTextField.text = detailTaskModel.subtask
        self.datePicker.date = detailTaskModel.date
    }
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func doneBarButtonItemPressed(sender: UIBarButtonItem) {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.detailTaskModel.task = self.taskTextField.text
        self.detailTaskModel.subtask = self.subtaskTextField.text
        self.detailTaskModel.date = self.datePicker.date
        self.detailTaskModel.isCompleted = self.detailTaskModel.isCompleted
        appDelegate.saveContext() // saving the context will update the task/object in Core Data
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    

}
