//
//  CoolTaskRowView.swift
//  TodoList
//
//  Created by Miguel Acosta Del Vecchio on 11/10/23.
//

import SwiftUI

// Inside CoolTaskRowView

struct CoolTaskRowView: View {
    @EnvironmentObject var viewModel: TodoViewModel
    var task: ProjectTask
    @State private var isHidden = false
    @State private var isTaskViewPresented = false
    let appColor = AppColorThemes()

    var body: some View {
        // Wrap the row in a Button to make it tappable
        Button(action: {
            // Present the TaskView sheet when the row is tapped
            isTaskViewPresented.toggle()
        }) {
            HStack {
                Button(action: {
                    withAnimation {
                        viewModel.deleteTask(theTask: task)
                        
                        // Set a delay to hide the row after 0.5 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            isHidden = true
                        }
                    }
                }) {
                    // Circle image with checkmark
                    Image(systemName: "circle")
                        .foregroundColor(.black)
                        .frame(width: 30, height: 30) // Adjust size as needed
                }
                .buttonStyle(PlainButtonStyle()) // Remove the button style
                
                VStack(alignment: .leading) {
                    Text(task.name)
                        .foregroundColor(.primary)
                        .font(.headline)
                    HStack {
                        switch task.priority {
                        case .High:
                            Text("High Priority")
                                .font(.caption)
                                .foregroundColor(appColor.darkRed)
                                .padding(.trailing, 4)
                        case .Medium:
                            Text("Medium Priority")
                                .font(.caption)
                                .foregroundColor(appColor.darkYellow)
                                .padding(.trailing, 4)
                        case .Low:
                            Text("Low Priority")
                                .font(.caption)
                                .foregroundColor(appColor.normalGray)
                                .padding(.trailing, 4)
                        }
                        
                        Text("Due: \(formattedDueDate)")
                            .font(.caption)
                            .foregroundColor(dueDateColor)
                    }
                }

                Spacer()
            }
            .padding(.vertical, 8)
            .opacity(isHidden ? 0 : 1)
            .animation(.linear(duration: 0.5))
        }
        .sheet(isPresented: $isTaskViewPresented) {
            TaskView(isTaskViewPresented: $isTaskViewPresented, theTask: task, name: task.name, description: task.description, dueDate: task.dueDate, priority: task.priority).environmentObject(viewModel)
        }
    }

    private var formattedDueDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: task.dueDate)
    }

    private var dueDateColor: Color {
        if Calendar.current.isDateInToday(task.dueDate) {
            return appColor.darkGreen
        } else if Calendar.current.isDateInTomorrow(task.dueDate) {
            return appColor.darkGreen
        } else if Calendar.current.isDateInYesterday(task.dueDate) {
            return appColor.darkRed
        } else {
            return task.dueDate < Date() ? appColor.darkRed : appColor.darkGreen
        }
    }

}


/*
struct CoolTaskRowView: View {
    @EnvironmentObject var viewModel: TodoViewModel
    var task: ProjectTask
    @State private var isHidden = false
    let appColor = AppColorThemes()

    var body: some View {
        
        HStack {
            // Button covering the entire row
            Button(action: {
                withAnimation {
                    viewModel.deleteTask(theTask: task)
                    
                    // Set a delay to hide the row after 0.5 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isHidden = true
                    }
                }
            }) {
                // Circle image with checkmark
                Image(systemName: "circle")
                    .foregroundColor(.black)
                    .frame(width: 30, height: 30) // Adjust size as needed
            }
            .buttonStyle(PlainButtonStyle()) // Remove the button style
            
            VStack(alignment: .leading) {
                Text(task.name)
                    .foregroundColor(.primary)
                    .font(.headline)
                HStack {
                    switch task.priority {
                    case .High:
                        Text("High Priority")
                            .font(.caption)
                            .foregroundColor(appColor.darkRed)
                            .padding(.trailing, 4)
                    case .Medium:
                        Text("Medium Priority")
                            .font(.caption)
                            .foregroundColor(appColor.darkYellow)
                            .padding(.trailing, 4)
                    case .Low:
                        Text("Low Priority")
                            .font(.caption)
                            .foregroundColor(appColor.normalGray)
                            .padding(.trailing, 4)
                    }
                    
                    Text("Due: \(formattedDueDate)")
                        .font(.caption)
                        .foregroundColor(dueDateColor)
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
        .opacity(isHidden ? 0 : 1) // Apply opacity based on the isHidden state
        .animation(.linear(duration: 0.5)) // Add fade-out animation
    }

    private var formattedDueDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: task.dueDate)
    }

    private var dueDateColor: Color {
        if Calendar.current.isDateInToday(task.dueDate) {
            return appColor.darkGreen
        } else if Calendar.current.isDateInTomorrow(task.dueDate) {
            return appColor.darkGreen
        } else if Calendar.current.isDateInYesterday(task.dueDate) {
            return appColor.darkRed
        } else {
            return task.dueDate < Date() ? appColor.darkRed : appColor.darkGreen
        }
    }
}
*/
