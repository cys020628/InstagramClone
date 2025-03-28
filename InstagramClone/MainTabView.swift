//
//  MainTabView.swift
//  InstagramClone
//
//  Created by 영석 on 3/22/25.
//

import SwiftUI

struct MainTabView: View {
    
    @State var tabIndex = 0
    
    var body: some View {
        TabView(selection: $tabIndex) {
            FeedView()
                .tabItem {
                    Image(systemName:"house")
                }
                .tag(0)
            
            Text("Search")
                .tabItem {
                    Image(systemName:"magnifyingglass")
                }
                .tag(1)
            
            NewPostView(tabIndex: $tabIndex)
                .tabItem {
                    Image(systemName:"plus.square")
                }
                .tag(2)
            
            VStack {
                Text("Reels")
                Button {
                    AuthManager.shared.signOut()
                } label: {
                    Text("로그아웃")
                }
            }
                .tabItem {
                    Image(systemName:"movieclapper")
                }
                .tag(3)
            
            ProfileView()
                .tabItem {
                    Image(systemName:"person.circle")
                }
                .tag(4)
        }
        .tint(.black)
    }
}

#Preview {
    MainTabView()
}
