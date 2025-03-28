//
//  signUpViewModel.swift
//  InstagramClone
//
//  Created by 영석 on 3/25/25.
//

import Foundation
import FirebaseAuth

@Observable
class SignupViewModel {
    
    // 이메일
    var email = ""
    // 비밀번호
    var password = ""
    // 이름
    var name = ""
    // 사용자 이름
    var userName = ""
    
    // 회원가입 진행
    func createUser() async{
        await AuthManager.shared.createUser(email: email, password: password, name: name, userName: userName)
        // 기존 데이터 초기화
        email = ""
        password = ""
        name = ""
        userName = ""
    }
}
