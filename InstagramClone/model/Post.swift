//
//  Post.swift
//  InstagramClone
//
//  Created by 영석 on 3/24/25.
//

import Foundation


// 기존 스위프트에서만 사용 가능했지만
// Encodable를 써줘서 밖으로 내보낼수 있거나
// Decodable를 사용하여 가져올수 있게 할수 있다
// 둘다를 지원하는 것은 Codable 이다.
struct Post: Codable, Identifiable {
    // 게시글 고유값
    let id:String
    // 내용(문구)
    let caption:String
    // 좋아요 수
    var like: Int
    // 이미지 경로
    let imageUrl:String
    // 시간
    let date:Date
    // 유저 UID
    let userId:String
    
    // 유저 이름
    var user: User? // 처음에는 검색하기전이라 nil 이므로 옵셔널로 설정
}
