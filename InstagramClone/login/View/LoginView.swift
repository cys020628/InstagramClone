//
//  LoginView.swift
//  InstagramClone
//
//  Created by 영석 on 3/24/25.
//

import Foundation
import SwiftUI


struct LoginView: View {
    @State var loginViewMNodel = LoginViewModel()
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                GradientBackgroundView()
                
                VStack {
                    Spacer()
                    Image("instagramLogo")
                        .resizable()
                        .frame(width: 57, height: 57)
                    
                    Spacer()
                    
                    VStack(spacing:20) {
                        
                        // 이메일
                        TextField( "이메일 주소", text: $loginViewMNodel.email)
                            .modifier(InstagramTextFieldModifier())
                        
                        
                        // 비밀번호
                        SecureField("비밀번호", text: $loginViewMNodel.password)
                            .modifier(InstagramTextFieldModifier())
                        
                        // 로그인
                        BlueButtonView {
                            Task {
                                await loginViewMNodel.signIn()
                            }
                         
                            print("로그인 되었습니다.")
                        } label: {
                            Text("로그인")
                        }
                        // 비밀번호 찾기
                        Text("비밀번호를 잊으셨나요?")
                    }
                    
                    Spacer()
                    
                    // 회원가입
                    NavigationLink {
                        //   print("회원가입")
                        EnterEmailView()
                    } label: {
                        Text("새 계정 만들기")
                            .frame(width:363,height:42)
                            .foregroundStyle(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .fontWeight(.bold)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.blue, lineWidth:1)
                            }
                    }
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
