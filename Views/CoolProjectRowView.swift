//
//  CoolProjectRowView.swift
//  TodoList
//
//  Created by Miguel Acosta Del Vecchio on 12/2/23.
//

import SwiftUI

struct CoolProjectRowView: View {
    @EnvironmentObject var viewModel : TodoViewModel
    @State private var isHidden = false
    let appColor = AppColorThemes()
    var project : ProjectData
    
    var body: some View {
        
        HStack {
            // Button covering the entire row
            Button(action: {
                withAnimation {
                    viewModel.deleteProject(theProject: project)
                    
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
                Text(project.name)
                    .foregroundColor(.primary)
                    .font(.headline)
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
        .opacity(isHidden ? 0 : 1) // Apply opacity based on the isHidden state
        .animation(.linear(duration: 0.5)) // Add fade-out animation
    }
}
