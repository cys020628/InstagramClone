//
//  FeedCellView.swift
//  InstagramClone
//
//  Created by 영석 on 3/28/25.
//

import SwiftUI
import Kingfisher

struct FeedCellView: View {
    
    @State var viewModel: FeedCellViewModel
    
    
    init(post:Post) {
        self.viewModel = FeedCellViewModel(post: post)
    }
    
    var body: some View {
        //let _ = print("image loading completed")
        VStack {
            KFImage(URL(string:viewModel.post.imageUrl))
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .overlay(alignment:.top) {
                    HStack {
                        NavigationLink {
                            if let user = viewModel.post.user {
                                ProfileView(viewModel: ProfileViewModel(user: user))
                            }
                        
                        } label: {
                            KFImage(URL(string:viewModel.post.user?.profileImageUrl ?? ""))
                                .resizable()
                                .frame(width: 35, height: 35)
                                .clipShape(Circle())
                                .overlay {
                                    Circle()
                                        .stroke(Color(red: 191/255.0, green: 11/255.0, blue: 180/255.0), lineWidth: 2)
                                }
                            Text(viewModel.post.user?.userName ?? "")
                                .foregroundStyle(.white)
                                .bold()
                            
                            Spacer()
                            Image(systemName: "line.3.horizontal")
                                .foregroundStyle(.white)
                                .imageScale(.large)
                        }
                    }
                    .padding(10)
                }
            
            HStack {
                
                Image(systemName: "heart")
                Image(systemName: "bubble.right")
                Image(systemName: "paperplane")
                Spacer()
                Image(systemName: "bookmark")
            }
            .imageScale(.large)
            .padding(.horizontal)
            
            Text("좋아요 \(viewModel.post.like)개")
                .font(.footnote)
                .frame(maxWidth:.infinity,alignment: .leading)
                .padding(.horizontal)
            
            Text("\(viewModel.post.user?.userName ?? "") \(viewModel.post.caption)")
                .font(.footnote)
                .frame(maxWidth:.infinity,alignment: .leading)
                .padding(.horizontal)
            
            Text("댓글 25개 더보기")
                .foregroundStyle(.gray)
                .font(.footnote)
                .frame(maxWidth:.infinity,alignment: .leading)
                .padding(.horizontal)
            
            Text("\(viewModel.post.date.relativeTimeString())")
                .foregroundStyle(.gray)
                .font(.footnote)
                .frame(maxWidth:.infinity,alignment: .leading)
                .padding(.horizontal)
        }
    }
}

#Preview {
    FeedCellView(
        post: Post(id: "g6LoUmh0CoWJDFM7vNbt", caption: "테스트 설명", like: 20, imageUrl: "https://firebasestorage.googleapis.com:443/v0/b/instagramclone-996e3.firebasestorage.app/o/images%2FF6EA1660-29D2-4567-9023-54692102D3B0?alt=media&token=29fd3309-b0ce-413c-8004-77127b3c445d", date: Date(), userId: "jZmK6eDNxffLETUs1n7RFjcok9u2")
    )
}
