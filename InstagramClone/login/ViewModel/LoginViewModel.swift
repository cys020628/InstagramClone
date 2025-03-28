//
//  LoginViewModel.swift
//  InstagramClone
//
//  Created by 영석 on 3/26/25.
//

import SwiftUI


@Observable
class LoginViewModel {
    
    // 이메일
    var email = ""
    
    // 비밀번호
    var password = ""
    
    func signIn() async {
        await AuthManager.shared.signIn(email: email, password: password)
    }
    
}
