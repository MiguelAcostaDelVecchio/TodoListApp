//
//  DeleteProjectView.swift
//  TodoList
//
//  Created by Miguel Acosta Del Vecchio on 12/2/23.
//

import SwiftUI

struct DeleteProjectView: View {
    @EnvironmentObject var viewModel : TodoViewModel
    @Binding var deleteProject : Bool
    
    var body: some View {
        
        NavigationStack {
            Form {
                Section(header: Text("My Projects")) {
                    // Display all user projects
                    ForEach(viewModel.userProjects, id: \.self) { p in
                        CoolProjectRowView(project: p).environmentObject(viewModel)
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .principal) {
                    Text("Delete Project")
                        .font(.system(size: 18))
                        .bold()
                        .padding(.top, 5)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        deleteProject.toggle()
                    }, label: {
                        Text("Done")
                            .padding(.top, 5)
                            .padding(.trailing, 10)
                    })
                }
            } // end of toolbar
        }
    }
}
