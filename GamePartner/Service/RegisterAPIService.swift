//
//  RegisterAPIService.swift
//  GamePartner
//
//  Created by 민창경 on 2020/09/01.
//

import Foundation
import Alamofire
import PromiseKit
import SwiftyJSON

class RegisterAPIService : NSObject{
    // MARK: - Singleton
    static let shared = RegisterAPIService()
    
    // MARK: - URL
    private var checkUrl = "https://dapi.kakao.com/v2/vision/adult/detect"
    private var uploadUrl = "https://gamepartner.storage.googleapis.com"
    private var insertUserUrl = Util.mainUrl + Util.insertUserUrl
    private var getUserIdUrl = Util.mainUrl + Util.getUserIdUrl
    // MARK: - Services
    func checkImage(image:UIImage!,userId:String!,imageType:String!) -> Promise<[String:Any]>{
        return Promise { seal in
            AF.upload(multipartFormData: { multiformData in
                
                multiformData.append(image!.jpegData(compressionQuality: 0.5)!, withName: "image"
                                     , fileName: userId + imageType, mimeType: "image/" + imageType)
                
            },to: checkUrl,method: .post, headers: ["Authorization":"KakaoAK 42118d46bf58bbb4b7feb8740cd82af6"])
            .validate()
            .responseJSON{ response in
                
                switch response.result {
                case .success(let json):
                    guard let json = json  as? [String: Any] else {
                        return seal.reject(AFError.responseValidationFailed(reason: .dataFileNil))
                    }
                    seal.fulfill(json)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    func checkUserId(userId:String!) -> Promise<[String:Any]>{
        return Promise{ seal in
            AF.request(getUserIdUrl + userId, method: .get)
                .validate()
                .responseJSON{ response in
                    switch response.result {
                    case .success(let json):
                        guard let json = json as? [String: Any] else {
                            return seal.reject(AFError.responseValidationFailed(reason: .dataFileNil))
                        }
                        seal.fulfill(json)
                    case .failure(let error):
                        seal.reject(error)
                    }
            }
        }
    }
    
    func insertImage(image:UIImage!,userId:String!,imageType:String!) -> Promise<String>{
        return Promise{ seal in
            AF.upload( multipartFormData: { multiformData in
                
                multiformData.append(image!.jpegData(compressionQuality: 0.5)!, withName: "file"
                                    ,fileName: userId + "." + imageType, mimeType: "image/" + imageType)
                multiformData.append(userId.data(using: .utf8)!, withName: "key")
            },to:uploadUrl,method: .post)
            .validate()
            .responseJSON{ response in
                switch response.result {
                case .success( _):
                    //print(json)
//                    guard let json = json  as? [String: Any] else {
//                        return seal.reject(AFError.responseValidationFailed(reason: .dataFileNil))
//                    }
                    seal.fulfill(userId)
                case .failure(let error):
                    //print(error)
                    seal.reject(error)
                }
            }
        }
    }
    
    func insertUser(userId:String, pw:String, sex:String, age:Int,
                    birthDay:String, favoritGame:String, introduce: String
                    ,nickName:String, imgPath:String) -> Promise<[String:Any]>{
        
        let params = [
            "userId":userId,
            "pw":pw,
            "sex":sex,
            "age":age,
            "birthDay":birthDay,
            "favoritGame":favoritGame,
            "introduce":introduce,
            "nickName":nickName,
            "imgPath":imgPath
        ] as [String : Any]

        return Promise{ seal in
            
        AF.request(insertUserUrl, method: .post, parameters: params)
            .validate()
            .responseJSON{ response in
                switch response.result{
                case .success(let json):
                    guard let json = json  as? [String: Any] else {
                        return seal.reject(AFError.responseValidationFailed(reason: .dataFileNil))
                    }
                    seal.fulfill(json)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
}

