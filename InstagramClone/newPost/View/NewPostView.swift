//
//  NewPostView.swift
//  InstagramClone
//
//  Created by 영석 on 3/22/25.
//

import SwiftUI
import PhotosUI

struct NewPostView: View {
    
    // 화면의 탭을 받아 넘기는 바인딩 변수
    @Binding var tabIndex:Int
    
    @State var viewModel = NewPostViewModel()
    
    var body: some View {
        VStack {
            
            HStack {
                Button {
                    print("뒤로가기")
                    tabIndex = 0
                } label: {
                    Image(systemName: "chevron.left")
                        .tint(.black)
                }
                Spacer()
                Text("새 게시물")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                
            }
            .padding(.horizontal)
            
            PhotosPicker(selection: $viewModel.selectedItem) {
                // Image("image_lion")
                // self.postImage가 nil이 아닐떄
                if let image = self.viewModel.postImage {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity,maxHeight: 400)
                        .clipped()
                    
                }else {
                    // self.postImage가 nil 일때
                    // 기본 사진 적용
                    Image(systemName: "photo.on.rectangle")
                        .resizable()
                    // .aspectRatio(1,contentMode: .fit)
                        .padding()
                        .tint(.black)
                        .scaledToFit()
                        .frame(width:200,height:200)
                }
            }
            // of를 통해 selectedItem이 바뀌었을때 실행
            .onChange(of: viewModel.selectedItem) { oldValue, newValue in
                Task {
                    await viewModel.convertImage(item: newValue)
                }
            }
            
            TextField("문구를 작성하거나 설문을 추가하세요...",
                      text: $viewModel.caption)
            .padding()
            
            Spacer()
            
            Button {
                print("사진 공유")
                Task {
                    await viewModel.uploadPost()
                    viewModel.clearData()
                    tabIndex = 0
                }
            } label: {
                Text("공유")
                    .frame(width: 363, height: 42)
                    .foregroundStyle(.white)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .padding()
        }
    }
}

#Preview {
    NewPostView(tabIndex: .constant(0))
}
