//
//  EnterEmailView.swift
//  InstagramClone
//
//  Created by 영석 on 3/24/25.
//

import SwiftUI

struct EnterEmailView: View {
    
    @Environment(SignupViewModel.self) var signupViewModel
    
    var body: some View {
        
        @Bindable var signupViewModel = signupViewModel
        
        SignupBackgroundView {
            VStack {
                Text("이메일 주소 입력")
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                
                Text("회원님에게 연락할 수 있는 이메일 주소를 입력하세요. 이 이메일 주소는 프로필에서 다른 사람에게 공개되지 않습니다.")
                    .font(.callout)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                
                // 이메일
                TextField( "이메일 주소", text: $signupViewModel.email )
                    .modifier(InstagramTextFieldModifier())
                
                
                // 다음 버튼
                NavigationLink {
                    EnterPasswordView()
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
    EnterEmailView()
}
