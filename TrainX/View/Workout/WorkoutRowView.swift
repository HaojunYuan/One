//
//  WorkoutRowView.swift
//  One
//
//  Created by Brian Yuan on 2/20/24.
//

import SwiftUI

struct WorkoutRowView: View {
    @Binding var workout: Workout
    let expanded: Bool
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center) {
                Text(workout.name)
                Spacer()
                VStack(alignment: .trailing) {
                    Text("\(workout.sets.count) Sets")
                }
            }.padding(.top, 12)
            Spacer()
            
            if expanded {
                ScrollView {
                    VStack {
                        ForEach($workout.sets, id: \.id) { setBinding in
                            WorkoutSetRowView(set: setBinding, unit: workout.unit, deleteSet: deleteSet)
                        }
                    }
                }
                Button("Add new set") {
                    workout.sets.append(WorkoutSet())
                }
                .padding(.bottom, 12)
            }
        }
        .padding()
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(.systemGray), style: StrokeStyle(lineWidth: 4))
            }
        )
        .padding(.horizontal)
    }
    
    private func deleteSet(set: WorkoutSet) {
        if let index = workout.sets.firstIndex(where: { $0.id == set.id }) {
            workout.sets.remove(at: index)
        }
    }
}

#Preview {
    WorkoutRowView(workout: .constant(Workout(name: "Bench Press", workoutType: .chest, sets: [WorkoutSet(weight: 45, repetitions: 12)], unit: .lb)), expanded: false)
}
