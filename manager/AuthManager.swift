//
//  AuthManager.swift
//  InstagramClone
//
//  Created by 영석 on 3/25/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Firebase


// AuthManager 클래스는 사용자 인증 관련 작업을 관리하는 싱글톤 클래스
@Observable
class AuthManager {
    // 싱글톤 인스턴스를 생성하여 앱 전반에서 동일한 인스턴스를 사용
    static let shared = AuthManager()
    
    // 현재 사용자의 세션 정보를 저장하는 변수
    var currentAuthUser: FirebaseAuth.User?
    
    // 사용자의 데이터
    var currentUser:User?
    
    // currentUserSession 값이 Manager가 생성될떄 nil로 초기화 되는데
    // 이걸 init 을 통해 사용자의 정보를 넣어준다.
    init() {
        currentAuthUser = Auth.auth().currentUser
        // 로그인한 객체가 있을 때 사용자 데이터를 가져와야 하기 때문에 처리
        Task {
            await loadCurrentUserData()
        }
    }
    
    // 사용자를 생성하는 메서드입니다.
    // 이메일, 비밀번호, 이름, 사용자 이름을 받아서 사용자 계정을 생성
    func createUser(
        email: String,  // 사용자의 이메일
        password: String,  // 사용자의 비밀번호
        name: String,  // 사용자의 이름
        userName: String  // 사용자의 사용자 이름
    ) async {
        // 입력된 값을 콘솔에 출력하여 디버깅할 수 있습니다.
        print("이메일 \(email)")
        print("비밀번호 \(password)")
        print("이름 \(name)")
        print("사용자 이름 \(userName)")
        
        do {
            // FirebaseAuth를 통해 이메일과 비밀번호로 사용자를 생성합니다.
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            
            // 사용자가 성공적으로 생성되면, 생성된 사용자의 세션을 currentUserSession에 저장합니다.
            currentAuthUser = result.user
            
            // 사용자 고유 UID
            guard let userId = currentAuthUser?.uid else { return }
            
            // 사용자 정보 저장
            await uploadUserData(userId: userId, emial: email, userName: userName, name: name)
        } catch {
            // 사용자가 생성되지 않으면, 오류 메시지를 출력합니다.
            print("DEBUG: Failed to create userwith error \(error.localizedDescription)")
        }
    }
    
    // 유저 정보 저장
    func uploadUserData(
        userId:String,
        emial:String,
        userName:String,
        name:String
    ) async {
        let user = User(id: userId, email: emial, userName: userName, name: name)
        self.currentUser = user
        
        do {
            let encodedUser = try Firestore.Encoder().encode(user)
            //
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
        }catch {
            print("DEBUG: Failed to upload data with error : \(error)")
        }
        
    }
    
    // 유저 로그인
    func signIn (
        email:String,
        password:String
    ) async {
        do {
            // 로그인 진행 
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            // 로그인 성공 시 유저 정보 저장
            currentAuthUser = result.user
            
            // 유저 데이터 가져오기
            await loadCurrentUserData()
            
        }catch {
            print("DEBUG: Failed to login user with error \(error.localizedDescription)")
        }
        
    }
    
    // 유저 데이터 가져오기
    func loadCurrentUserData() async {
        guard let userId = self.currentAuthUser?.uid else { return }
        print("userId : \(userId)")
        do {
            self.currentUser = try await Firestore.firestore().collection("users").document(userId).getDocument(as: User.self)
        } catch {
            print("DEBUG: Failed to load user data with errorsd \(error.localizedDescription)")
        }
    }
    
    // 피드에 있는 전체 유저의 이름 가져오기
    func loadUserData(userId:String) async -> User? {
        do {
            let user =  try await Firestore.firestore().collection("users").document(userId).getDocument(as: User.self)
            return user
        }catch {
            print("DEBUG: Failed to load user data with error \(error.localizedDescription)")
            return nil
        }
    }
    
    // 사용자 로그아웃을 처리하는 메서드입니다.
    func signOut() {
        do {
            // FirebaseAuth에서 signOut을 호출하여 사용자를 로그아웃합니다.
            try Auth.auth().signOut()
            
            // 로그아웃 후 currentUserSession을 nil로 설정하여 세션을 초기화합니다.
            currentAuthUser = nil
            currentUser = nil
        } catch {
            // 로그아웃에 실패하면 오류 메시지를 출력합니다.
            print("DEBUG: Failed to sign out user with error \(error.localizedDescription)")
        }
    }
}
