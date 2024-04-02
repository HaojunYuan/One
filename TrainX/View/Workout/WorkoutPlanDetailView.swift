//
//  WorkoutDetailView.swift
//  TrainX
//
//  Created by Brian Yuan on 3/5/24.
//

import SwiftUI

struct WorkoutPlanDetailView: View {
    @State private var checkedSets: [Bool] = []
    @State private var endWorkoutAlert = false
    
    let workoutPlan: WorkoutPlan
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(workoutPlan.workouts, id: \.id) { workout in
                VStack(alignment: .leading) {
                    Text(workout.name)
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ForEach(workout.sets, id: \.id) { set in
                        HStack {
                            Checkbox()
                            Text("\(set.weight ?? 0) \(workout.unit.rawValue) * \(set.repetitions ?? 0) reps")
                            Spacer()
                        }
                    }
                    
                }
                .padding(.bottom)
            }
            Spacer()
            //
            //            // End workout button
            //            Button("End Workout") {
            //                endWorkoutAlert = true
            //            }
            //            .padding()
            //            .alert(isPresented: $endWorkoutAlert) {
            //                Alert(title: Text("End Workout?"), message: Text("Are you sure you want to end the workout?"), primaryButton: .cancel(), secondaryButton: .default(Text("End")) {
            //                    // Clear all checked boxes
            //                    checkedSets = Array(repeating: false, count: checkedSets.count)
            //                })
            //            }
        }
        .padding()
        .navigationBarTitle(Text(workoutPlan.name), displayMode: .inline)
    }
}

struct Checkbox: View {
    @State var checked: Bool = false
    
    var body: some View {
        Button(action: { checked.toggle() }) {
            Image(systemName: checked ? "checkmark.circle.fill" : "circle")
        }
    }
}

//#Preview {
//    WorkoutPlanDetailView()
//}
