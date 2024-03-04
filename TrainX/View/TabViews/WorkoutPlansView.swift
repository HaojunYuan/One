//
//  WorkoutsView.swift
//  One
//
//  Created by Brian Yuan on 2/12/24.
//

import SwiftUI

struct WorkoutPlansView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if let user = viewModel.currentUser {
            NavigationStack {
                VStack {
                    // TODO: Populate templates view with templates from viewmodel.user
                    ScrollView {
                        if user.workoutPlans.count > 0 {
                            let columns = [GridItem(),
                                           GridItem()]
                            LazyVGrid(columns: columns) {
                                ForEach(user.workoutPlans.indices, id: \.self) { index in
                                    WorkoutPlanGridItemView(workoutPlan: user.workoutPlans[index], index: index)
                                }
                            }
                        }
                    }
                    //                .scrollClipDisabled()
                    // Button to create new workout plan
                    NavigationLink(destination: CreateWorkoutPlanView()) {
                        VStack {
                            Image(systemName: "plus.circle.fill")
                                .foregroundStyle(.green)
                                .font(.system(size: 40))
                            Text("New workout plan")
                                .padding(.bottom)
                        }
                    }
                }
                .navigationBarTitle("My Workout Plans", displayMode: .automatic)
            }
            .padding(15)
        } else {
            Text("Loading workout plans...")
        }
    }
}

//#Preview {
//    WorkoutPlansView()
//}
