//
//  OneApp.swift
//  One
//
//  Created by Brian Yuan on 2/3/24.
//

import SwiftUI
import Firebase

@main
struct TrainXApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
