//
//  EnterNameView.swift
//  InstagramClone
//
//  Created by 영석 on 3/24/25.
//

import SwiftUI

struct EnterNameView: View {
    @Environment(\.dismiss) var dismiss
    
    @Environment(SignupViewModel.self) var signupViewModel
    
    var body: some View {
        
        @Bindable var signupViewModel = signupViewModel
        
        SignupBackgroundView {
            VStack {
                Text("이름 입력")
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                
                // 이름
                TextField("성명", text: $signupViewModel.name)
                    .modifier(InstagramTextFieldModifier())
                
                // 다음 버튼
                NavigationLink {
                    EnterUserNameView()
                } label: {
                    Text("다음")
                        .frame(width: 363, height: 42)
                        .foregroundStyle(.white)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                Spacer()
            }
        }
    }
}

#Preview {
    EnterNameView()
}
