//
//  AddNewTaskView.swift
//  TodoList
//
//  Created by Miguel Acosta Del Vecchio on 11/10/23.
//

import SwiftUI

struct AddNewTaskView: View {
    @EnvironmentObject var viewModel: TodoViewModel
    @Binding var addNewTask: Bool
    let projectName: String
    @State var name = ""
    @State var description = ""
    @State var dueDate = Date() // Updated state for due date
    @State var priority = TaskPriority.Low

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Task Name", text: $name)
                    TextField("Description", text: $description)
                }

                Section(header: Text("Due Date")) {
                    DatePicker("Select Due Date", selection: $dueDate, displayedComponents: .date)
                        .datePickerStyle(WheelDatePickerStyle())
                }

                Section(header: Text("Priority")) {
                    Picker("Select Priority", selection: $priority) {
                        Text("High").tag(TaskPriority.High)
                        Text("Medium").tag(TaskPriority.Medium)
                        Text("Low").tag(TaskPriority.Low)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("New Task")
                        .font(.system(size: 18))
                        .bold()
                        .padding(.top, 5)
                }

                ToolbarItem(placement: .topBarTrailing) {
                    if name.isEmpty || viewModel.checkDuplicateTaskName(taskName: name){
                        Text("Done")
                            .padding(.top, 5)
                            .padding(.trailing, 10)
                    } else {
                        Button(action: {
                            viewModel.makeNewTask(projectName: projectName, name: name, description: description, dueDate: dueDate, priority: priority, taskCompleted: false)
                            addNewTask.toggle()
                        }, label: {
                            Text("Done")
                                .padding(.top, 5)
                                .padding(.trailing, 10)
                        })
                    }
                }

                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        addNewTask.toggle()
                    }, label: {
                        Text("Cancel")
                            .padding(.top, 5)
                            .padding(.leading, 10)
                    })
                }
            } // end of toolbar
        } // end of Navigation stack
    }
}


#Preview {
    AddNewTaskView(addNewTask: .constant(true), projectName: "🎯 Habits")
}
