//
//  FeedViewModel.swift
//  InstagramClone
//
//  Created by 영석 on 3/28/25.
//

import Foundation
import FirebaseFirestore

@Observable
class FeedViewModel {
    
    // 서버에서 가져온 포스트들을 저장하는 변수
    var posts: [Post] = []
    
//    init() {
//        Task {
//            await loadAllPosts()
//        }
//    }
    
    
    func loadAllPosts() async {
        do {
            let documents = try await Firestore.firestore().collection("posts").order(by: "date",descending: true).getDocuments().documents
            // 방법 1
            //            var posts : [Post] = []
            //            for document in documents {
            //                let post = try document.data(as: Post.self)
            //                posts.append(post)
            //            }
            //            self.posts = posts
            
            // 방법 2
            //            self.posts = try documents.map({ document in
            //               return try document.data(as: Post.self)
            //            })
            
            // 방법 3
            self.posts = try documents.compactMap({ document in
                return try document.data(as: Post.self)
            })
        }catch {
            print("DEBUG : failed to load user posts with error : \(error.localizedDescription)")
        }
    }
}
