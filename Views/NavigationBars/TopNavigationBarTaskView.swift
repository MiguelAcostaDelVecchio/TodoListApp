//
//  TopNavigationBarTaskView.swift
//  TodoList
//
//  Created by Miguel Acosta Del Vecchio on 11/9/23.
//

import SwiftUI

struct TopNavigationBarTaskView: View {
    @EnvironmentObject var viewModel : TodoViewModel
    @Environment(\.presentationMode) var presentationMode
    let appColors = AppColorThemes()
    let projectName: String

    var body: some View {
        HStack {

            Button(action: {
            presentationMode.wrappedValue.dismiss()
            }, label: {
            Label(projectName, systemImage: "chevron.backward").font(.system(size: 20, weight: .semibold)).padding(.leading, 20).foregroundColor(.white)
            })

            Spacer()

            // ArrowUpArrowDown Button
            Menu {
                Button(action: {
                    viewModel.setSortOrder(.byPriority(ascending: true))
                }) {
                    Label("Priority (High to Low)", systemImage: "arrow.down")
                }

                Button(action: {
                    viewModel.setSortOrder(.byPriority(ascending: false))
                }) {
                    Label("Priority (Low to High)", systemImage: "arrow.up")
                }

                Button(action: {
                    viewModel.setSortOrder(.byDueDate(ascending: true))
                }) {
                    Label("Due Date (Oldest to Newest)", systemImage: "arrow.down")
                }

                Button(action: {
                    viewModel.setSortOrder(.byDueDate(ascending: false))
                }) {
                    Label("Due Date (Future to Past)", systemImage: "arrow.up")
                }
            } label: {
                Image(systemName: "arrow.up.arrow.down").imageScale(.large)
            }
            .padding(.top, 5)
            .padding(.bottom, 5)
            .padding(.trailing, 28)
            .foregroundColor(.white)
        }
    }
}
