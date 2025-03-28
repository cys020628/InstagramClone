//
//  EnterUserNameView.swift
//  InstagramClone
//
//  Created by 영석 on 3/24/25.
//

import SwiftUI

struct EnterUserNameView: View {
    @Environment(\.dismiss) var dismiss
    
    @Environment(SignupViewModel.self) var signupViewModel
    
    var body: some View {
        
        @Bindable var signupViewModel = signupViewModel
        
        SignupBackgroundView {
            VStack {
                Text("사용자 이름 만들기")
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                
                Text("사용자 이름을 직접 추가하거나 추처 이름을 사용하세요.언제든지 변경할 수 있습니다.")
                    .font(.callout)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                
                // 사용자 이름
                TextField( "사용자 이름", text: $signupViewModel.userName )
                    .modifier(InstagramTextFieldModifier())
                
                // 다음 버튼
                NavigationLink {
                    CompleteSignUpView()
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
    EnterUserNameView()
}
