//
//  ViewController.swift
//  TaskIt
//
//  Created by Alex Paul on 5/4/15.
//  Copyright (c) 2015 Alex Paul. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    // Get the Managed Object Context from the App Delegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    
    // Fetch Results Controller 
    var fetchedResultsController: NSFetchedResultsController = NSFetchedResultsController()

    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the Fetched Results Controller 
        getFetchedResultsController()
        
        // Set the Fetched Results Controller Delegate to self 
        self.fetchedResultsController.delegate = self
        
        // Perform Fetch 
        self.fetchedResultsController.performFetch(nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
    }
    
    // MARK: Prepare For Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showTaskDetail" {
            let detailVC = segue.destinationViewController as TaskDetailViewController // a TaskDetailViewController instance
            let indexPath = self.tableView.indexPathForSelectedRow()                   // get the indexPath of the selected row
            let thisTask = self.fetchedResultsController.objectAtIndexPath(indexPath!) as TaskModel
            detailVC.detailTaskModel = thisTask                                        // set the detailVC detailTaskModel parameter
        }
        else if segue.identifier == "showAddTask" {
            let addTaskVC = segue.destinationViewController as AddTaskViewController
        }
    }
    
    @IBAction func addTaskButtonPressed(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showAddTask", sender: self)
    }
    
    
    // MARK: UITableViewDataSource 
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchedResultsController.sections![section].numberOfObjects
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var thisTask = self.fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
        var cell = self.tableView.dequeueReusableCellWithIdentifier("myCell") as TaskTableViewCell
        
        cell.taskLabel.text = thisTask.task  // subscript dictionary to get vale from key
        cell.descriptionLabel.text = thisTask.subtask
        cell.dateLabel.text = Date.toString(date: thisTask.date)
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let thisTask = self.fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
        
        // Toggle between "Completed" and "To Do" when cell is swipied
        if thisTask.isCompleted == false{
            thisTask.isCompleted = true
        }else{
            thisTask.isCompleted = false
        }
        
        // Save the Context
        (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.fetchedResultsController.sections?.count == 1 {
            let task = self.fetchedResultsController.fetchedObjects![0] as TaskModel
            return task.isCompleted.boolValue ? "Completed" : "To Do"
        }
        return (section == 0) ? "To Do" : "Completed"
    }
    
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        println(indexPath.row)
        
        performSegueWithIdentifier("showTaskDetail", sender: self)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String! {
        var titleString = (indexPath.section == 0) ? "Completed" : "To Do"
        return titleString
    }
    
    // MARK: NSFetchedResultsControllerDelegate
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.reloadData()
    }
    
    // MARK: Helper Methods
    
    // Create a FetchRequest 
    func taskFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "TaskModel")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        let completedDescriptor = NSSortDescriptor(key: "isCompleted", ascending: true)
        fetchRequest.sortDescriptors = [completedDescriptor, sortDescriptor]
        
        return fetchRequest
    }
    
    // Get the Fetched Results Controller 
    func getFetchedResultsController() -> NSFetchedResultsController {
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: self.managedObjectContext, sectionNameKeyPath: "isCompleted", cacheName: nil)
        
        return self.fetchedResultsController
    }


}

