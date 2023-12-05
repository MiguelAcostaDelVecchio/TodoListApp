//
//  HomeView.swift
//  TodoList
//
//  Created by Miguel Acosta Del Vecchio on 11/8/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: TodoViewModel
    let appColors = AppColorThemes()
    @State private var addNewProject = false
    let topBarNavigationTitle = "Projects"
    
    var body: some View {
        NavigationStack{
            ZStack {
                VStack {
                    
                    HomeNavigationBarView(title: topBarNavigationTitle)
                    
                    Form {
                        Section(header: Text("Default Projects")) {
                            ForEach(viewModel.defaultProjects, id: \.self) {
                                project in
                                NavigationLink(destination: ProjectView(project: project).environmentObject(viewModel), label: {Text(project.name)})
                            }
                        } // end of Section
                        
                        Section(header: Text("My Projects")) {
                            ForEach(viewModel.userProjects, id: \.self) {
                                project in
                                NavigationLink(destination: ProjectView(project: project).environmentObject(viewModel), label: {Text(project.name)})
                            }
                        } // end of Section
                    } // end of Form
                } // end of VStack
                .background(appColors.blueIshGray)
                .navigationBarBackButtonHidden()
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            addNewProject.toggle()
                        }, label: {Image(systemName: "plus.circle.fill").foregroundColor(appColors.blueIshGray).font(.system(size: 50, weight: .light))})
                            .padding(.trailing, 28)
                            .padding(.bottom, 20)
                    } // end of HStack
                } // end of VStack
            } // end of ZStack
            .sheet(isPresented: $addNewProject, content: {
                AddNewProjectView(addNewProject: $addNewProject).environmentObject(viewModel)
            })
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
    } // end of body
} // end of struct
