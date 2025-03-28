//
//  CompleteSignUpView.swift
//  InstagramClone
//
//  Created by 영석 on 3/24/25.
//

import SwiftUI

struct CompleteSignUpView: View {
    @Environment(\.dismiss) var dismiss
    
    @Environment(SignupViewModel.self) var signupViewModel
    
    var body: some View {
        
        @Bindable var signupViewModel = signupViewModel
        
        
        SignupBackgroundView {
            VStack {
                Image("instagramLogo2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120)
                
                Spacer()
                
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width:172,height:172)
                    .foregroundStyle(.gray)
                    .opacity(0.5)
                    .overlay {
                        Circle()
                            .stroke(.gray,
                                    lineWidth: 2)
                            .frame(width:185,height:185)
                            .opacity(0.5)
                    }
                
                Text("\(signupViewModel.name)님, Instagram에 오신 것을 환영합니다.")
                    .font(.title)
                    .padding(.top, 30)
                    .padding(.horizontal)
                
                Spacer()
                
                BlueButtonView {
                    Task {
                        await signupViewModel.createUser()
                    }
                   
                } label: {
                    Text("완료")
                }
                
                Spacer()
            }
        }
    }
}


#Preview {
    CompleteSignUpView()
}
