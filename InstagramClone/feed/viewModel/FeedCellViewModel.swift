//
//  FeedCellViewModel.swift
//  InstagramClone
//
//  Created by 영석 on 3/28/25.
//

import Foundation


@Observable
class FeedCellViewModel {
    var post: Post
    
    init(post:Post) {
        self.post = post
        
        Task {
            await loadUserData()
        }
    }
    
    func loadUserData() async {
        let userId = post.userId
        guard let user = await AuthManager.shared.loadUserData(userId: userId) else { return }
        post.user = user
    }
}
