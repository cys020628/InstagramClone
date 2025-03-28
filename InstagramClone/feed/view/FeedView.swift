//
//  FeedView.swift
//  InstagramClone
//
//  Created by 영석 on 3/28/25.
//

import SwiftUI

struct FeedView: View {
    @State var viewModel = FeedViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        Image("instagramLogo2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 110)
                        
                        Spacer()
                        
                        Image(systemName: "heart")
                            .imageScale(.large)
                            .padding(.horizontal, 10)
                        
                        Image(systemName: "paperplane")
                            .imageScale(.large)
                    }
                    .padding(.horizontal)
                    
                    //                FeedCellView()
                    //                FeedCellView()
                    //                FeedCellView()
                    //                FeedCellView()
                    
                    LazyVStack {
                        ForEach(viewModel.posts) { post in
                            // let _ = print("post: \(post)")
                            FeedCellView(post: post)
                        }
                    }
                    
                    Spacer()
                }
            }
            // 위로 스와이프 하여 새로고침 할떄 데이터 로딩
            .refreshable {
                await viewModel.loadAllPosts()
            }
            // 화면이 그려질때마다 데이터 로딩
            .task {
                await viewModel.loadAllPosts()
            }
        }
    }
}

#Preview {
    FeedView()
}
