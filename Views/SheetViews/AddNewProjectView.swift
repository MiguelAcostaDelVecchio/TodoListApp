//
//  AddNewProjectView.swift
//  TodoList
//
//  Created by Miguel Acosta Del Vecchio on 11/9/23.
//

import SwiftUI

struct AddNewProjectView: View {
    @EnvironmentObject var viewModel : TodoViewModel
    let appColors = AppColorThemes()
    @State var projectName = ""
    @State var projectPurpose = ""
    @Binding var addNewProject: Bool
    
    var body: some View {
        
        NavigationStack {
            Form {
                TextField("Name your project", text: $projectName)
                TextField("The prupose of this project is ... ", text: $projectPurpose)

            }
            .toolbar{
                ToolbarItem(placement: .principal) {
                    Text("New Project")
                        .font(.system(size: 18))
                        .bold()
                        .padding(.top, 5)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    if projectName.isEmpty || viewModel.checkDuplicateProjectName(projectName: projectName){
                        Text("Done")
                            .padding(.top, 5)
                            .padding(.trailing, 10)
                    } else {
                        Button(action: {
                            viewModel.makeNewProject(projectName: projectName, projectPurpose: projectPurpose)
                            //print(viewModel.userProjects)
                            addNewProject.toggle()
                        }, label: {Text("Done")
                                .padding(.top, 5)
                                .padding(.trailing, 10)
                        })
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        addNewProject.toggle()
                    }, label: {
                        Text("Cancel")
                            .padding(.top, 5)
                            .padding(.leading, 10)
                    })
                }
            } // end of toolbar
        } // end of Navigation stack
    } // end of body
} // end of struct

#Preview {
    AddNewProjectView(addNewProject: .constant(true))
}
