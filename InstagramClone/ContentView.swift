//
//  ContentView.swift
//  InstagramClone
//
//  Created by 영석 on 3/22/25.
//

import SwiftUI
import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State var signupViewModel = SignupViewModel()
    
    var body: some View {
        if AuthManager.shared.currentUser == nil {
            LoginView()
                .environment(signupViewModel)
        } else {
            MainTabView()
        }
    }
}

#Preview {
    ContentView()
}

