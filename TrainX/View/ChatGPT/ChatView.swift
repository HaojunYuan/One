//
//  ChatGPTView.swift
//  One
//
//  Created by Brian Yuan on 2/12/24.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var viewModel = ViewModel()
    var body: some View {
        ZStack {
            Image("ChatGPT Logo")
                .clipShape(Circle())
                .opacity(0.4)
            VStack {
                ScrollView {
                    ForEach(viewModel.messages.filter({$0.role != .system}), id: \.id) {message in
                        MessageView(message: message)
                    }
                }
                HStack {
                    TextField("Message ChatGPT...", text: $viewModel.inputMessage)
                    Button {
                        viewModel.sendMessage()
                    } label: {
                        Text("Send")
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    ChatView()
}
