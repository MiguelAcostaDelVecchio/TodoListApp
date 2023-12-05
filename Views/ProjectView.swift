//
//  testView.swift
//  TodoList
//
//  Created by Miguel Acosta Del Vecchio on 11/8/23.
//

import SwiftUI

struct ProjectView: View {
    @EnvironmentObject var viewModel : TodoViewModel
    @Environment(\.presentationMode) var presentationMode
    let appColors = AppColorThemes()
    var project: ProjectData
    @State private var addNewTask = false
    
    var body: some View {
        NavigationStack{
            ZStack {
                VStack {
                    TopNavigationBarTaskView(projectName: project.name).environmentObject(viewModel)
                    
                    Form {
                        // Find project user selected and display the purpose of the project as a section
                        ForEach(viewModel.defaultProjects, id: \.self) { p in
                            if p.name == project.name {
                                Section (header: Text("The purpose of this project is \(project.projectPurpose)")){
                                }
                            }
                        }
                        
                        // Find project user selected and display the purpose of the project as a section
                        ForEach(viewModel.userProjects, id: \.self) { p in
                            if p.name == project.name {
                                Section (header: Text("The purpose of this project is \(project.projectPurpose)")){
                                }
                            }
                        }
                        
                        // Display all the tasks of the selected project
                        Section(header: Text("Tasks")) {
                            ForEach(viewModel.defaultProjects, id: \.self) { p in
                                if p.name == project.name {
                                    ForEach(viewModel.defaultProjects, id: \.self) { p in
                                        if p.name == project.name {
                                            ForEach(p.tasks.sorted(by: sortingFunction), id: \.self) { task in
                                                CoolTaskRowView(task: task).environmentObject(viewModel)
                                            }
                                        }
                                    }
                                }
                            }

                            ForEach(viewModel.userProjects, id: \.self) { p in
                                if p.name == project.name {
                                    ForEach(p.tasks.sorted(by: sortingFunction), id: \.self) { task in
                                        CoolTaskRowView(task: task).environmentObject(viewModel)
                                    }
                                }
                            }
                        }
                    }
                    .background(Color(UIColor.systemGroupedBackground))
                } // end of VStack
                .background(appColors.blueIshGray)
                .navigationBarBackButtonHidden()
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            addNewTask.toggle()
                        }, label: {Image(systemName: "plus.circle.fill").foregroundColor(appColors.blueIshGray).font(.system(size: 50, weight: .light))})
                            .padding(.trailing, 28)
                            .padding(.bottom, 20)
                    } // end of HStack
                } // end of VStack
            } // end of ZStack
            .sheet(isPresented: $addNewTask ,content: {
                AddNewTaskView(addNewTask: $addNewTask, projectName: project.name).environmentObject(viewModel)})
        }
        .onAppear {
          try! viewModel.load()
        }
        .onChange(of: viewModel.defaultProjects) { _ in
          try! viewModel.save()
        }
        .onChange(of: viewModel.userProjects) { _ in
          try! viewModel.save()
        }
    }
    
    func sortingFunction(_ task1: ProjectTask, _ task2: ProjectTask) -> Bool {
        switch viewModel.sortOrder {
        case .byPriority(let ascending):
            let order = ascending ? 1 : -1
            return task1.priority.rawValue * order > task2.priority.rawValue * order

        case .byDueDate(let ascending):
            if ascending {
                // Sorting from oldest due date (further in the past) to newest due date (further in the future)
                return task1.dueDate < task2.dueDate
            } else {
                // Sorting from newest due date (further in the future) to oldest due date (further in the past)
                return task1.dueDate > task2.dueDate
            }
        }
    }
    
}
