//
//  TopNavigationBarView.swift
//  TodoList
//
//  Created by Miguel Acosta Del Vecchio on 11/8/23.
//

import SwiftUI

struct TodaysNavigationBarView: View {
    let title: String
    @EnvironmentObject var viewModel: TodoViewModel

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 20, weight: .bold))
                .padding(.leading, 25)
                .foregroundColor(.white)

            Spacer()

            /*
            // Bell Button
            Button(action: {
                print("Bell tapped")
            }, label: {
                Image(systemName: "bell").imageScale(.large)
            })
            .padding(.top, 5)
            .padding(.bottom, 5)
            .padding(.trailing, 20)
            .foregroundColor(.white)
             */

            // ArrowUpArrowDown Button with Menu
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
