//
//  MessageView.swift
//  TrainX
//
//  Created by Brian Yuan on 3/10/24.
//

import SwiftUI

struct MessageView: View {
    let message: Message
    
    var body: some View {
        HStack(alignment: .top) {
            if message.role == .user {
                Spacer()
                MessageBubble(message: message)
                    .padding(.horizontal, 8)
                Text("Me")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(Color(.systemGray3))
                    .clipShape(Circle())
            } 
            
            if message.role == .assistant {
                Image("ChatGPT Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                MessageBubble(message: message)
                    .padding(.horizontal, 8)
                Spacer()
            }
        }
        .padding()
    }
}

struct MessageBubble: View {
    let message: Message
    
    var body: some View {
        Text(message.content)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(message.role == .user ? Color.green : Color.teal)
            .cornerRadius(10.0)
    }
}

#Preview {
    MessageView(message: Message(id: UUID(), role: .assistant, content: "Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello", createAt: Date()))
}
