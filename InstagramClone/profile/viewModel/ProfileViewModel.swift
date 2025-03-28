//
//  ProfileViewModel.swift
//  InstagramClone
//
//  Created by 영석 on 3/27/25.
//

import Firebase
import PhotosUI
import SwiftUI
import FirebaseStorage

@Observable
class ProfileViewModel {
    
    var user: User?
    
    var name: String
    var userName: String
    var bio: String
    
    var posts: [Post] = []
    
    var selectedItem:PhotosPickerItem?
    var profileImage: Image?
    var uiImage:UIImage?
    
    init() {
        let tempUser = AuthManager.shared.currentUser
        
        self.user = tempUser
        self.name = tempUser?.name ?? ""
        self.userName = tempUser?.userName ?? ""
        self.bio = tempUser?.bio ?? ""
    }
    
    init(user: User) {
        self.user = user
        self.name = user.name
        self.userName = user.userName
        self.bio = user.bio ?? ""
        
    }
    
    // 사진 변경
    func convertImage(item:PhotosPickerItem?) async {
        guard let imageSelection = await ImageManager.convertImage(item: item) else { return }
        self.profileImage = imageSelection.image
        self.uiImage = imageSelection.uiImage
    }
    
    // 정보 수정
    func updateUser() async{
        do {
            try await updateUserRemote()
            
            updateUserLocal()
        }catch {
            print("DEBUG failed to update user data with error: \(error.localizedDescription)")
        }
    }
    
    // 내부 데이터 수정
    func updateUserLocal() {
        if name != "", name != user?.name {
            user?.name = name
        }
        
        if !userName.isEmpty, userName != user?.name {
            user?.userName = userName
        }
        
        if !bio.isEmpty, bio != user?.bio {
            user?.bio = bio
        }
    }
    
    // 서버 데이터 수정
    func updateUserRemote( )async throws {
        var editedData: [String : Any] = [:]
        
        if name != "", name != user?.name {
            editedData["name"] = name
        }
        
        if !userName.isEmpty, userName != user?.name {
            editedData["userName"] = userName
        }
        
        if !bio.isEmpty, bio != user?.bio {
            editedData["bio"] = bio
        }
        
        if let uiimage = self.uiImage {
           // let imageUrl = await uploadImage(uiImage: uiimage)!
            guard let imageUrl = await ImageManager.uploadImage(uiImage: uiimage, path: .profile) else { return }
            editedData["profileImageUrl"] = imageUrl
        }
        
        if !editedData.isEmpty, let userId = user?.id {
            try await Firestore.firestore().collection("users").document(userId).updateData(editedData)
        }
    }
    
     // 포스트 데이터를 가져오는 함수
    func loadUserPosts() async{
        do {
            let documents = try await Firestore.firestore().collection("posts").order(by: "date",descending: true) .whereField("userId",isEqualTo: user?.id ?? "").getDocuments().documents
            
            var posts : [Post] = []
            for document in documents {
                let post = try document.data(as: Post.self)
                posts.append(post)
            }
            self.posts = posts
        }catch {
            print("DEBUG : failed to load user posts with error : \(error.localizedDescription)")
        }

    }
}
