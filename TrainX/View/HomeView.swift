//
//  MainView.swift
//  One
//
//  Created by Brian Yuan on 2/17/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @StateObject var healthViewModel = HealthViewModel()

    var body: some View {
        TabView {
            WorkoutPlansView()
                .environmentObject(viewModel)
                .tabItem {
                    Label("Workouts", systemImage: "list.bullet.rectangle")
                }

            HealthView()
                .environmentObject(healthViewModel)
                .tabItem {
                    Label("Health", systemImage: "heart")
                }

            ChatView()
                .tabItem {
                    Label("Ask AI", systemImage: "message")
                }
            
            FeedView()
                .tabItem {
                    Label("Community", systemImage: "person.2")
                }

            ProfileView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

#Preview {
    HomeView()
}
