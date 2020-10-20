//
//  FriendAPIService.swift
//  GamePartner
//
//  Created by 민창경 on 2020/10/20.
//

import Foundation
import Alamofire
import SwiftyJSON
import RxSwift
import RxCocoa

class FriendAPIService : NSObject{
    static let shared = FriendAPIService()
    
    private var indexUrl = Util.mainUrl + Util.getIndexPageUrl
    
    func getIndexData(userId:String!) -> Observable<[String:Any]>{
        return Observable<[String:Any]>.create { (observer) -> Disposable in
            AF.request(self.indexUrl + userId, method: .get)
                    .validate()
                    .responseJSON { response in
                        switch response.result {
                        case .success(let json):
                            guard let json = json  as? [String: Any] else {
                                return observer.onError(AFError.responseValidationFailed(reason: .dataFileNil))
                            }
                            observer.onNext(json)
                            observer.onCompleted()
                        case .failure(let error):
                            observer.onError(error)
                        }
                   }
            return Disposables.create()
        }
    }
}
