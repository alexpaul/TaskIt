//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by Alex Paul on 5/11/15.
//  Copyright (c) 2015 Alex Paul. All rights reserved.
//

import UIKit
import CoreData

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func cancelButtonPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func addTaskButtonPressed(sender: UIButton) {
        println("add Task Button pressed")
        
        // Get an instance of the App Delegate
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        
        // Get the Managed Object Context 
        let managedObjectContext = appDelegate.managedObjectContext
        
        // Create an NSEntityDescription 
        let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: managedObjectContext!)
        
        // Create a TaskModel instance 
        let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
        
        // Update the Task Attributes 
        task.task = self.taskTextField.text
        task.subtask = self.subtaskTextField.text
        task.date = self.datePicker.date
        task.isCompleted = false
        
        // Save the changes to Core Data 
        appDelegate.saveContext()
        
        // Use a Fetch Request to view the items from Core Data
        var request = NSFetchRequest(entityName: "TaskModel")
        var error: NSError? = nil
        var results: NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
        for res in results {
            println(res)
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
