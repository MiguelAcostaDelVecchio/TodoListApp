//
//  TodoViewModel.swift
//  TodoList
//
//  Created by Miguel Acosta Del Vecchio on 11/9/23.
//

import Foundation
import SwiftUI

class TodoViewModel: ObservableObject {
    // Published properties
    @Published private var appData = AppData()
    @Published var sortOrder: SortOrder = .byPriority(ascending: true)
    
    // Internal properties
    var defaultProjects: [ProjectData] {
        appData.defaultProjects
    }
    
    var userProjects: [ProjectData] {
        appData.userProjects
    }
    
    private var documentDirectory: URL {
      try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }
    
    private var defaultProjectsFile: URL {
      return documentDirectory
        .appendingPathComponent("defaultProjectsData")
        .appendingPathExtension(for: .json)
    }
    
    private var userProjectsFile: URL {
      return documentDirectory
        .appendingPathComponent("userProjectsData")
        .appendingPathExtension(for: .json)
    }
    
    func makeNewProject (projectName name: String, projectPurpose purpose: String) {
        appData.newProject(name: name, purpose: purpose)
    }
    
    func makeNewTask (projectName: String, name: String, description: String, dueDate: Date, priority: TaskPriority, taskCompleted: Bool) {
        appData.newTask(projectName: projectName, name: name, description: description, dueDate: dueDate, priority: priority, taskCompleted: taskCompleted)
    }
    
    func toggleTaskCompletionStatus (theTask: ProjectTask) {
        appData.toggleTaskCompletionStatus(specificTask: theTask)
    }
    
    func deleteProject (theProject: ProjectData) {
        appData.deleteProject(specificProject: theProject)
    }
    
    func deleteTask (theTask: ProjectTask) {
        appData.deleteTask(specificTask: theTask)
    }
    
    func modifyTask (theTask: ProjectTask, name: String, description: String, dueDate: Date, priority: TaskPriority) {
        appData.modifyTask(specificTask: theTask, name: name, description: description, dueDate: dueDate, priority: priority)
    }
    
    func checkDuplicateProjectName (projectName: String) -> Bool {
        for projectIndex in 0..<defaultProjects.count {
            if defaultProjects[projectIndex].name == projectName {
                return true
            }
        }
        for projectIndex in 0..<userProjects.count {
            if userProjects[projectIndex].name == projectName {
                return true
            }
        }
        return false
    }

    func checkDuplicateTaskName (taskName: String) -> Bool {
        for defaultProject in appData.defaultProjects {
            for task in defaultProject.tasks {
                if task.name == taskName {
                    return true
                }
            }
        }
        for userProject in appData.userProjects {
            for task in userProject.tasks {
                if task.name == taskName {
                    return true
                }
            }
        }
        return false
    }

    
    func toggleSortOrder() {
        switch sortOrder {
        case .byPriority(let ascending):
            sortOrder = .byPriority(ascending: !ascending)
        case .byDueDate(let ascending):
            sortOrder = .byDueDate(ascending: !ascending)
        }
    }
    
    func setSortOrder(_ sortOrder: SortOrder) {
        self.sortOrder = sortOrder
    }
    
    //  Persistence
    func load() throws {
      guard FileManager.default.isReadableFile(atPath: defaultProjectsFile.path) else { return }
      guard FileManager.default.isReadableFile(atPath: userProjectsFile.path) else { return }
        
      let defaultProjectData = try Data(contentsOf: defaultProjectsFile)
      let userProjectData = try Data(contentsOf: userProjectsFile)
        
      appData.defaultProjects = try JSONDecoder().decode([ProjectData].self, from: defaultProjectData)
      appData.userProjects = try JSONDecoder().decode([ProjectData].self, from: userProjectData)
    }
    
    func save() throws {
        // This function will do the following
        // 1. Encode the data
        // 2. Write the data to the corresponding file in the file manager
        let defaultProjectData = try JSONEncoder().encode(defaultProjects)
        let userProjectData = try JSONEncoder().encode(userProjects)
        
        try defaultProjectData.write(to: defaultProjectsFile)
        try userProjectData.write(to: userProjectsFile)
    }
}
