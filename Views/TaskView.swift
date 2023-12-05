//
//  TaskView.swift
//  TodoList
//
//  Created by Miguel Acosta Del Vecchio on 12/3/23.
//

import SwiftUI

struct TaskView: View {
    @EnvironmentObject var viewModel: TodoViewModel
    @Binding var isTaskViewPresented: Bool
    var theTask: ProjectTask
    @State var name : String
    @State var description : String
    @State var dueDate : Date
    @State var priority : TaskPriority

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
                    Text("Task Information")
                        .font(.system(size: 18))
                        .bold()
                        .padding(.top, 5)
                }

                ToolbarItem(placement: .topBarTrailing) {
                    if name.isEmpty {
                        Text("Done")
                            .padding(.top, 5)
                            .padding(.trailing, 10)
                    } else {
                        Button(action: {
                            viewModel.modifyTask(theTask: theTask, name: name, description: description, dueDate: dueDate, priority: priority)
                            isTaskViewPresented.toggle()
                        }, label: {
                            Text("Done")
                                .padding(.top, 5)
                                .padding(.trailing, 10)
                        })
                    }
                }

                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        isTaskViewPresented.toggle()
                    }, label: {
                        Text("Cancel")
                            .padding(.top, 5)
                            .padding(.leading, 10)
                    })
                }
            } // end of toolbar
        } // end of Navigation stack
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
}

#Preview {
    TaskView(isTaskViewPresented: .constant(true), theTask: ProjectTask(name: "Task 1", description: "This is my first task", dueDate: Date(), priority: TaskPriority.High, taskCompleted: false), name: "Task 1", description: "This is my first task", dueDate: Date(), priority: TaskPriority.High)
}
