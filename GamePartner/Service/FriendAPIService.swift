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
    
    func getIndexData(userId:String!) -> Observable<[FriendInfoSection]>{
        return Observable.create { (observer) -> Disposable in
            AF.request(self.indexUrl + userId, method: .get).responseData {
                response in
                switch response.result {
                case .success(let json):
                    let model = JSON(json)
                    
                    let friendList = JSON(model["data"]["friendList"])
                    let parseFriendList =
                        friendList["friendList"].arrayValue.map{
                            FriendModel(name:$0["nickName"].stringValue,sex:$0["sex"].stringValue,introduce: $0["introduce"].stringValue
                                        ,favoritGame: $0["favoritGame"].stringValue,imgUrl: $0["imgPath"].stringValue)
                            }
                    let sectionFriendList = FriendInfoSection(header: "친구리스트", items: parseFriendList)
                    
                    let wantedToList = JSON(model["data"]["wantedToList"])
                    let parseWantedToList = wantedToList.arrayValue.map{
                        FriendModel(name:$0["to"]["nickName"].stringValue,sex: $0["to"]["sex"].stringValue,
                                    introduce: $0["to"]["introduce"].stringValue,favoritGame: $0["to"]["favoritGame"].stringValue,
                                    imgUrl: $0["to"]["imgPath"].stringValue)
                    }
                    let sectionWantedToList = FriendInfoSection(header:"친구 요청한 리스트",items: parseWantedToList)
                    
                    let wantedFromList = JSON(model["data"]["wantedFromList"])
                    let parseWantedFromList = wantedFromList.arrayValue.map{
                        FriendModel(name:$0["from"]["nickName"].stringValue,sex: $0["from"]["sex"].stringValue,
                                    introduce:$0["from"]["introduce"].stringValue,favoritGame:$0["from"]["favoritGame"].stringValue,
                                    imgUrl: $0["from"]["imgPath"].stringValue)
                    }
                    let sectionWantedFromList = FriendInfoSection(header: "친구 요청받은 리스트", items: parseWantedFromList)
                    
                    let sectionData = [sectionWantedFromList,sectionWantedToList,sectionFriendList]
                    
                    observer.onNext(sectionData)
                    observer.onCompleted()
                    
                case .failure(let error):
                    observer.onError(error)
                }
                
            }

            return Disposables.create()
        }
    }
}
