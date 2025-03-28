//
//  NewPostViewModel.swift
//  InstagramClone
//
//  Created by 영석 on 3/24/25.
//

import PhotosUI
import SwiftUI
import FirebaseStorage
import FirebaseFirestore


@Observable
class NewPostViewModel {
    // 문구 작성 상태 변수
    var caption = ""
    
    // 선택된 사진의 상태변수
    var selectedItem:PhotosPickerItem?
    
    // 변환된 사진 값을 저장하는 상태 변수ㅎ
    var postImage: Image?
    
    // convertImage 함수에서 고른 사진의 uiImage 값을 저장하기 위한 변수
    var uiImage:UIImage?
    

    func convertImage(item:PhotosPickerItem?) async {
        print("adadasdadasdasdasda")
        print("item: \(item ?? nil)")
        guard let imageSelection = await ImageManager.convertImage(item: item) else { return }
        print("imageSelection: \(imageSelection)")
        self.postImage = imageSelection.image
        self.uiImage = imageSelection.uiImage
    }
    
    // 게시글 업로드
    func uploadPost() async{
        print("Start!!!!!")
        guard let uiImage else { return }
        print("asd,\(uiImage)")
        
        // 이미지 업로드
        // uiImage: uploadImage 함수에 전달하디위해 사용
        // guard let imageUrl = await uploadImage(uiImage: uiImage) else { return }
        guard let imageUrl = await ImageManager.uploadImage(uiImage: uiImage, path: ImagePath.post) else { return }
        
        // 게시글 업로드
        // FirebaseStore의 posts Document에 접근
        let postReference = Firestore.firestore().collection("posts").document()
        // 유저 아이디
        guard let userId = AuthManager.shared.currentAuthUser?.uid else { return }
        // 서버에 저장될 데이터 생성
        let post = Post(id: postReference.documentID, caption: caption, like: 0, imageUrl: imageUrl, date: Date(), userId: userId)
        
        do {
            // 서버에 저장될 데이터를 인코딩으로 가공 처리
            let encodedData = try Firestore.Encoder().encode(post)
            // 가공된 데이터를 서버에 저장
            try await postReference.setData(encodedData)
        }catch {
            print("DEBUG: Failed to upload Post with Error : \(error)")
        }
        
    }

    func clearData() {
        caption = ""
        selectedItem = nil
        postImage = nil
        uiImage = nil
    }
    
}
