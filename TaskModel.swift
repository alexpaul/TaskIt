//
//  TaskModel.swift
//  TaskIt
//
//  Created by Alex Paul on 5/13/15.
//  Copyright (c) 2015 Alex Paul. All rights reserved.
//

import Foundation
import CoreData
@objc(TaskModel) // Creates an Objective-C Bridge 
class TaskModel: NSManagedObject {

    @NSManaged var task: String
    @NSManaged var subtask: String
    @NSManaged var date: NSDate
    @NSManaged var isCompleted: NSNumber

}
