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
    // MARK: - Services
    func checkImage(image:UIImage!,userId:String!,imageType:String!) -> Promise<[String:Any]>{
        return Promise { seal in
            AF.upload(multipartFormData: { multiformData in
                
                multiformData.append(image!.jpegData(compressionQuality: 0.5)!, withName: "image"
                                     , fileName: userId + imageType, mimeType: "image/" + imageType)
                
            },to: checkUrl,method: .post, headers: ["Authorization":"KakaoAK 42118d46bf58bbb4b7feb8740cd82af6"])
            .validate()
            .responseJSON{ response in
                debugPrint(response)
                switch response.result {
                case .success(let json):
                    guard let json = json  as? [String: Any] else {
                        
                        return seal.reject(AFError.responseValidationFailed(reason: .dataFileNil))
                    }
                    seal.fulfill(json)
                case .failure(let error):
                    if response.response?.statusCode == 400{
                        seal.fulfill(["Status":400])
                    }else{
                        seal.reject(error)
                    }
                   
                }
            }
        }
    }
    
    /*private func alert(_ title: String, message: String){
        let alert = UIAlertController(title: title, message: message
                                      ,preferredStyle:UIAlertController.Style.alert)
        let action = UIAlertAction(title:"OK", style: UIAlertAction.Style.default,handler: nil)
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }*/
}

