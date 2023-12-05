//
//  TodaysTaskView.swift
//  TodoList
//
//  Created by Miguel Acosta Del Vecchio on 11/12/23.
//

import SwiftUI

struct TodaysTaskView: View {
    @EnvironmentObject var viewModel: TodoViewModel
    let appColors = AppColorThemes()
    let todaysNavigationBarTitle = "Today's Tasks"

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    TodaysNavigationBarView(title: todaysNavigationBarTitle).environmentObject(viewModel)

                    Form {
                        Section(header: Text("Tasks")) {
                            ForEach(filteredTodayTasks(), id: \.self) { task in
                                CoolTaskRowView(task: task).environmentObject(viewModel)
                            }
                        }
                    } // end of Form
                } // end of VStack
                .background(appColors.blueIshGray)
                .navigationBarBackButtonHidden()
            } // end of ZStack
        } // end of Navigation Stack
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

    private func filteredTodayTasks() -> [ProjectTask] {
        let todayTasks = viewModel.defaultProjects.flatMap(\.tasks) + viewModel.userProjects.flatMap(\.tasks)
        
        let filteredTasks = todayTasks.filter { task in
            Calendar.current.isDateInToday(task.dueDate)
        }

        switch viewModel.sortOrder {
        case .byPriority(let ascending):
            return filteredTasks.sorted { task1, task2 in
                let order = ascending ? 1 : -1
                return task1.priority.rawValue * order > task2.priority.rawValue * order
            }

        case .byDueDate(let ascending):
            return filteredTasks.sorted { task1, task2 in
                if ascending {
                    return task1.dueDate < task2.dueDate
                } else {
                    return task1.dueDate > task2.dueDate
                }
            }
        }
    }
}

