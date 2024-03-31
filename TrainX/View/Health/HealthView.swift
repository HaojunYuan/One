//
//  HealthView.swift
//  TrainX
//
//  Created by Brian Yuan on 3/31/24.
//

import SwiftUI

struct HealthView: View {
    @EnvironmentObject var healthViewModel: HealthViewModel
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if let user = viewModel.currentUser {
            VStack {
                LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)) {
                    ForEach(healthViewModel.activities.sorted(by: {$0.value.id < $1.value.id}), id: \.key) {item in
                        ActivityCard(activity: item.value)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    HealthView()
}
