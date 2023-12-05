//
//  AppData.swift
//  TodoList
//
//  Created by Miguel Acosta Del Vecchio on 11/9/23.
//

import Foundation
import SwiftUI

struct AppData {
    
    // Default projects
    var defaultProjects: [ProjectData] = [ProjectData(name: "🔥 One-Off Tasks", projectPurpose: "to take care of small daily tasks that are easy to forget!"),
                                          ProjectData(name: "🧹 Chores", projectPurpose: "to keep my house clean!"),
                                          ProjectData(name: "📝 Short Term Goals", projectPurpose: "to know what I am currently working towards!"),
                                          ProjectData(name: "🪣 Bucket List", projectPurpose: "know what my dreams are!")]
    
    // User Projects
    var userProjects: [ProjectData] = []
    
    mutating func newProject (name: String, purpose: String) {
        // Adding a new project to the UserProjects array
        userProjects.append(ProjectData(name: name, projectPurpose: purpose))
    } // end of mutating func
    
    mutating func newTask(projectName: String, name: String, description: String, dueDate: Date, priority: TaskPriority, taskCompleted: Bool) {
        // Find project that user wants to create a new task. And then add the task to that specific project along with
        // the corresponding information
        for index in 0..<defaultProjects.count {
            var project = defaultProjects[index]
            if project.name == projectName {
                project.tasks.append(ProjectTask(name: name, description: description, dueDate: dueDate, priority: priority, taskCompleted: taskCompleted))
                defaultProjects[index] = project // Assign the modified project back to the array
                //print(defaultProjects)
                break // Break out of the loop since the project is found
            }
        }
        for index in 0..<userProjects.count {
            var project = userProjects[index]
            if project.name == projectName {
                project.tasks.append(ProjectTask(name: name, description: description, dueDate: dueDate, priority: priority, taskCompleted: taskCompleted))
                userProjects[index] = project // Assign the modified project back to the array
                break // Break out of the loop since the project is found
            }
        }
    } // end of mutating func
    
    mutating func toggleTaskCompletionStatus (specificTask: ProjectTask) {
        for i in 0..<defaultProjects.count {
            var project = defaultProjects[i]
            for j in 0..<project.tasks.count {
                if project.tasks[j].name == specificTask.name {
                    project.tasks[j].taskCompleted.toggle()
                    //print(project.tasks[j])
                    defaultProjects[i].tasks[j] = project.tasks[j]
                    //print(defaultProjects[i].tasks[j])
                    //print("")
                }
            }
        }
        for i in 0..<userProjects.count {
            var project = userProjects[i]
            for j in 0..<project.tasks.count {
                if project.tasks[j].name == specificTask.name {
                    project.tasks[j].taskCompleted.toggle()
                    //print(userProjects)
                }
            }
        }
    }
    
    mutating func deleteTask (specificTask: ProjectTask) {
        for projectIndex in 0..<defaultProjects.count {
            var project = defaultProjects[projectIndex]
            for taskIndex in 0..<project.tasks.count {
                if project.tasks[taskIndex].name == specificTask.name {
                    defaultProjects[projectIndex].tasks.remove(at: taskIndex)
                    break
                }
            }
        }
        for projectIndex in 0..<userProjects.count {
            var project = userProjects[projectIndex]
            for taskIndex in 0..<project.tasks.count {
                if project.tasks[taskIndex].name == specificTask.name {
                    userProjects[projectIndex].tasks.remove(at: taskIndex)
                    break
                }
            }
        }
    }
    
    mutating func deleteProject (specificProject: ProjectData) {
        for projectIndex in 0..<userProjects.count {
            var project = userProjects[projectIndex]
            if project.name == specificProject.name {
                userProjects.remove(at: projectIndex)
                break
            }
        }
    }
    
    mutating func modifyTask (specificTask: ProjectTask, name: String, description: String, dueDate: Date, priority: TaskPriority) {
        for projectIndex in 0..<defaultProjects.count {
            var project = defaultProjects[projectIndex]
            for taskIndex in 0..<project.tasks.count {
                if project.tasks[taskIndex].name == specificTask.name {
                    defaultProjects[projectIndex].tasks[taskIndex].name = name
                    defaultProjects[projectIndex].tasks[taskIndex].description = description
                    defaultProjects[projectIndex].tasks[taskIndex].dueDate = dueDate
                    defaultProjects[projectIndex].tasks[taskIndex].priority = priority
                    break
                }
            }
        }
        for projectIndex in 0..<userProjects.count {
            var project = userProjects[projectIndex]
            for taskIndex in 0..<project.tasks.count {
                if project.tasks[taskIndex].name == specificTask.name {
                    userProjects[projectIndex].tasks[taskIndex].name = name
                    userProjects[projectIndex].tasks[taskIndex].description = description
                    userProjects[projectIndex].tasks[taskIndex].dueDate = dueDate
                    userProjects[projectIndex].tasks[taskIndex].priority = priority
                    break
                }
            }
        }
    }

}

struct ProjectData : Hashable , Codable {
    var name: String
    var projectPurpose: String = ""
    var tasks: [ProjectTask] = []
}

struct ProjectTask: Hashable , Codable {
    var name: String
    var description: String
    var dueDate: Date
    var priority: TaskPriority
    var taskCompleted: Bool
    var hidden: Bool {
        if taskCompleted == true {
            return true
        } else {
            return false
        }
    }
}

enum TaskPriority: Int, CaseIterable, Codable {
    case High = 2, Medium = 1, Low = 0
}

enum SortOrder {
    case byPriority(ascending: Bool)
    case byDueDate(ascending: Bool)
}

