//
//  ImageManager.swift
//  InstagramClone
//
//  Created by 영석 on 3/28/25.
//

import Foundation
import SwiftUI
import PhotosUI
import FirebaseStorage

// 공통 모델 생성
struct ImageSelection {
    let image: Image
    let uiImage: UIImage
}

enum ImagePath {
    case post
    case profile
}

class ImageManager {
    
    // PhotosPicker를 이미지로 변환해주는 함수
    // [변환 순서]
    // PhotosPicker = item
    // -> Data(컴퓨터가 읽을수 있는 0,1로 된 데이터 형식 = data
    // -> UIImage(UIKit에서 사용하는 이미지 형식) = uiImage
    // Image(SwiftUI에서 사용하는 이미지 형식 = Image
    static func convertImage(item:PhotosPickerItem?) async -> ImageSelection? {
        guard let item = item else { return nil }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return nil}
        guard let uiImage = UIImage(data:data) else { return nil}
        let image = Image(uiImage: uiImage)
        let imageSelection = ImageSelection(image: image, uiImage: uiImage)
        return imageSelection
    }
    
    // 이미지 업로드 함수 정의
    // UIImage를 받아서 Firebase Storage에 업로드하고, 업로드된 이미지의 URL을 String으로 반환 (옵셔널)
    static func uploadImage(uiImage: UIImage,path:ImagePath) async -> String? {
        
        // 1. UIImage를 JPEG 포맷으로 압축 (품질: 0.5)
        // 실패 시 (즉, imageData가 nil이면) 함수 종료하고 nil 반환
        guard let imageData = uiImage.jpegData(compressionQuality: 0.5) else { return nil }
        
        // 2. UUID를 사용해 고유한 파일명을 생성 (충돌 방지 목적)
        let fileName = UUID().uuidString
        print("fileName : \(fileName)")
        
        var imagePath:String = ""
        
        // 3. Firebase Storage 내 저장 경로 설정
        // 예: /images/1A2B3C4D-... 형식의 경로에 이미지 저장 예정
        switch(path){
        case .post: 
            imagePath = "images"
            break
        case .profile:
            imagePath = "profiles"
            break
        }
        
        //        if path == ImagePath.post {
        //            imagePath = "images"
        //        }else {
        //            imagePath = "profiles"
        //        }
        
        let reference = Storage.storage().reference(withPath: "/\(imagePath)/\(fileName)")
        
        // 4. 실제 업로드 및 다운로드 URL 획득을 위한 비동기 처리 시작
        do {
            // 4-1. Firebase Storage에 데이터를 업로드
            // reference.putDataAsync는 Firebase Storage에 비동기로 데이터 업로드하는 함수
            // 이 작업은 실패할 수도 있으므로 try 키워드 사용 (오류 발생 가능성 있음)
            // await 키워드는 비동기 작업이 완료될 때까지 기다리기 위해 사용
            let metaData = try await reference.putDataAsync(imageData)
            
            // 4-2. 업로드 완료 후, 해당 이미지의 다운로드 URL을 가져옴
            // 역시 네트워크 작업이므로 try await 필요
            let url = try await reference.downloadURL()
            
            // 4-3. URL을 문자열로 변환하여 반환
            return url.absoluteString
            
        } catch {
            // 5. 업로드 과정에서 오류 발생 시 catch 블럭에서 에러 처리
            print("DEBUG: Faild to upload Image with Error : \(error)")
            
            // 실패했을 경우 nil 반환
            return nil
        }
    }
}


