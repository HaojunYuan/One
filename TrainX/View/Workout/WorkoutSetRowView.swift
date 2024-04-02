//
//  WorkoutSetRowView.swift
//  One
//
//  Created by Brian Yuan on 2/19/24.
//

import SwiftUI

struct WorkoutSetRowView: View {
    @Binding var set: WorkoutSet
    var unit: Unit
    var deleteSet: (WorkoutSet) -> Void
    
    var body: some View {
        HStack(alignment: .center) {
            WorkoutSetInputView(value: $set.weight, title: "Weight")
            Text(unit.rawValue)
                .padding(.top)
            WorkoutSetInputView(value: $set.repetitions, title: "Repetitions")
            Button(action: { deleteSet(set) }) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
    }
}


#Preview {
    WorkoutSetRowView(set: .constant(WorkoutSet(weight: 45, repetitions: 8)), unit:.lb, deleteSet: {_ in })
}
