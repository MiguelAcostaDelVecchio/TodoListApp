//
//  HomeScreen.swift
//  TodoList
//
//  Created by Miguel Acosta Del Vecchio on 11/8/23.
//

import SwiftUI

struct InitialScreenView: View {
    @StateObject var viewModel = TodoViewModel()
    let appColors = AppColorThemes()
    var body: some View {
        TabView {
            HomeView().environmentObject(viewModel)
                .tabItem {
                    Label("Projects", systemImage: "house")
                }
            TodaysTaskView().environmentObject(viewModel)
                .tabItem {
                    Label("Today's Tasks", systemImage: "checklist")
                }
        }
    }
}

#Preview {
    InitialScreenView()
}
