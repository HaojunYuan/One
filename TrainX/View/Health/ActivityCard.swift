//
//  ActivityCard.swift
//  TrainX
//
//  Created by Brian Yuan on 3/31/24.
//

import SwiftUI

struct ActivityCard: View {
    @State var activity: Activity
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .cornerRadius(15)
            
            VStack(spacing: 20) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(activity.title)
                        
                        Text(activity.subtitle)
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                    }
                    
                    Spacer()
                    
                    Image(systemName: activity.image)
                        .foregroundColor(.green)
                }
                
                Text(activity.amount)
                    .font(.system(size: 24))
            }
            .padding()
        }
    }
}

#Preview {
    ActivityCard(
        activity: Activity(id: 0, title: "Daily Steps", subtitle: "Goal: 10000", image: "figure.walk", amount: "6000")
    )
}