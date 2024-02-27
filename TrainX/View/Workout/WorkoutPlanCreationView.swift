//
//  CreateTemplateView.swift
//  One
//
//  Created by Brian Yuan on 2/19/24.
//

import SwiftUI

struct WorkoutPlanCreationView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var name: String = ""
    @State private var workouts: [Workout] = [Workout(name: "Bench Press", workoutType: .chest, sets: [Set(weight: 45, repetitions: 12)], unit: .lb), Workout(name: "Let Press", workoutType: .legs, sets: [Set(weight: 135, repetitions: 5)], unit: .lb)]
    @Environment(\.presentationMode) var presentationMode
    @State var expandingIndex: Int?
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: 12) {
                Text("Workout Plan Name")
                    .foregroundColor(Color(.darkGray))
                    .fontWeight(.semibold)
                    .font(.headline)
            
                TextField("Enter plan name", text: $name)
                        .font(.system(size: 16))
            }
            .padding()
            ScrollView {
                ForEach(workouts.indices, id: \.self) { index in
                    WorkoutRowView(workout: $workouts[index], expanded: self.expandingIndex == index)
                        .onTapGesture {
                            withAnimation(.spring(response: 0.55,  blendDuration: 0)){
                                if self.expandingIndex != index {
                                    self.expandingIndex = index
                                }
                            }
                        }
                }
            }
            .scrollClipDisabled()
        }
//        .padding()
        NavigationLink(destination: WorkoutCreationView(workouts: $workouts)) {
            VStack {
                Image(systemName: "plus.circle.fill")
                    .foregroundStyle(.green)
                    .font(.system(size: 40))
                Text("Add workout")
            }
        }
        .navigationBarTitle(Text("Edit Template"), displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // TODO: Create new template in Firebase
                    Task {
                        try await viewModel.createWorkoutPlan(name: name, workouts: workouts)
                    }
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Save")
                }
            }
        }
    }
}



#Preview {
    WorkoutPlanCreationView()
}
