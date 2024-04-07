//
//  HealthView.swift
//  TrainX
//
//  Created by Brian Yuan on 3/31/24.
//

import SwiftUI

struct HealthView: View {
    @EnvironmentObject var healthViewModel: HealthViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Today's Activities")
                .font(.largeTitle)
                .padding()
            
            LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)) {
                ForEach(healthViewModel.activities.sorted(by: {$0.key < $1.key}), id: \.key) {item in
                    ActivityCard(activity: item.value)
                }
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    HealthView()
}
