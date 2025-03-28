//
//  ProfileView.swift
//  InstagramClone
//
//  Created by 영석 on 3/26/25.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    @State var viewModel = ProfileViewModel()
    
    let columns: [GridItem] = [
        GridItem(.flexible(),spacing: 2),
        GridItem(.flexible(),spacing: 2),
        GridItem(.flexible(),spacing: 2),
    ]
    
    // 프로필 편집뷰 다 만들어고 하단 gridVerticalView를 통해 게시물들 표시하는 부분 만들어야됌
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack {
                    Text(("\(viewModel.userName)"))
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    HStack {
                        // 선택한 이미지가 있는지
                        if let profileImage = viewModel.profileImage {
                            profileImage
                                .resizable()
                                .frame(width: 75, height: 75)
                                .clipShape(Circle())
                                .padding(.bottom,10)
                            // 서버에 이미지가 올라가 있는지
                        }else if let imageUrl = viewModel.user?.profileImageUrl{
                            let url = URL(string: imageUrl)
                            KFImage(url)
                                .resizable()
                                .frame(width: 75, height: 75)
                                .clipShape(Circle())
                                .padding(.bottom,10)
                        } else {
                            // 아무것도 없을 경우 기본 이미지
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 75, height: 75)
                                .foregroundStyle(.gray).opacity(0.5)
                                .clipShape(Circle())
                                .padding(.bottom,10)
                        }
                        
                        VStack {
                            Text("124")
                                .fontWeight(.semibold)
                            Text("게시물")
                        }
                        .frame(maxWidth: .infinity)
                        
                        VStack {
                            Text("999")
                                .fontWeight(.semibold)
                            Text("팔로워")
                        }
                        .frame(maxWidth: .infinity)
                        
                        VStack {
                            Text("1403")
                                .fontWeight(.semibold)
                            Text("팔로잉")
                        }
                        .frame(maxWidth: .infinity)
                        
                    }
                    .padding(.horizontal)
                    
                    Text(("\(viewModel.name)"))
                        .font(.callout)
                        .frame(maxWidth:.infinity,alignment: .leading)
                        .padding(.horizontal)
                    
                    Text(("\(viewModel.bio)"))
                        .font(.callout)
                        .frame(maxWidth:.infinity,alignment: .leading)
                        .padding(.horizontal)
                    
                    NavigationLink {
                        ProfileEditingView(viewModel: viewModel)
                    } label: {
                        Text("프로필 편집")
                            .bold()
                            .foregroundStyle(.black)
                            .frame(maxWidth: .infinity)
                            .frame(height: 35)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.horizontal)
                            .padding(.top, 10)
                    }
                    
                    Divider()
                        .padding()
                    
                    LazyVGrid(columns: columns,spacing: 2) {
                        
                        //                        ForEach(0..<10) { _ in
                        //                            Image("image_lion")
                        //                                .resizable()
                        //                                .scaledToFit()
                        //
                        //                            Image("image_dog")
                        //                                .resizable()
                        //                                .scaledToFit()
                        //
                        //                            Image("image_dragon2")
                        //                                .resizable()
                        //                                .scaledToFit()
                        //                        }
                        ForEach(viewModel.posts) { post in
                            let url = URL(string: post.imageUrl)
                            KFImage(url)
                                .resizable()
                                .aspectRatio(1,contentMode: .fill)
                        }
                    }
                    .task {
                        await viewModel.loadUserPosts()
                    }
                    
                    Spacer()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                }label : {
                    Image(systemName: "arrow.backward")
                        .tint(.black)
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
