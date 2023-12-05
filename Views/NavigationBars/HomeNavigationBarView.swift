//
//  HomeNavigationBarView.swift
//  TodoList
//
//  Created by Miguel Acosta Del Vecchio on 11/12/23.
//

import SwiftUI

struct HomeNavigationBarView: View {
    let title: String
    @EnvironmentObject var viewModel: TodoViewModel
    @State private var deleteProject = false

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
            .padding(.trailing, 28)
            .foregroundColor(.white)
             */
            
            // Minus Circle Button
            Button(action: {
                deleteProject.toggle()
            }, label: {
                Image(systemName: "minus.circle").imageScale(.large)
            })
            .padding(.top, 5)
            .padding(.bottom, 5)
            .padding(.trailing, 28)
            .foregroundColor(.white)
        }
        .sheet(isPresented: $deleteProject, content: {
            DeleteProjectView(deleteProject: $deleteProject).environmentObject(viewModel)
        })
    }
}

