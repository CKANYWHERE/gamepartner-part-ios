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
    private var postInsertUrl = Util.mainUrl + Util.insertFrined
    private var postWantedUrl = Util.mainUrl + Util.insertWanted
    
    func getIndexData(userId:String!) -> Observable<[FriendInfoSection]>{
        return Observable.create { (observer) -> Disposable in
            AF.request(self.indexUrl + userId, method: .get).responseData {
                response in
                switch response.result {
                case .success(let json):
                    let model = JSON(json)
                    //친구목록, 요청받은 리스트 요청한 리스트들이 없을때 처리해야 하는 테이블뷰 필요!
                    let friendList = JSON(model["data"]["friendList"])
                    var parseFriendList =
                        friendList["friendList"].arrayValue.map{
                            FriendModel(name:$0["nickName"].stringValue,sex:$0["sex"].stringValue,introduce: $0["introduce"].stringValue
                                        ,favoritGame: $0["favoritGame"].stringValue,imgUrl: $0["imgPath"].stringValue, friendType: "friend"
                                        ,age:$0["age"].stringValue + "세", userId: $0["userId"].stringValue)
                            
                            }
                    if parseFriendList.isEmpty{
                        parseFriendList = [FriendModel(name:"아직 친구가 없어요 :(",sex: "M",
                                    introduce:"",favoritGame:"친구찾기 탭에서 새로운 친구를 만나보아요!",
                                    imgUrl: "nofriend",friendType: "friend"
                                    ,age:"",userId:"")]
                    }
                    let sectionFriendList = FriendInfoSection(header: "친구리스트", items: parseFriendList)
                    
                    let wantedToList = JSON(model["data"]["wantedToList"])
                    var parseWantedToList = wantedToList.arrayValue.map{
                        FriendModel(name:$0["to"]["nickName"].stringValue,sex: $0["to"]["sex"].stringValue,
                                    introduce: $0["to"]["introduce"].stringValue,favoritGame: $0["to"]["favoritGame"].stringValue,
                                    imgUrl: $0["to"]["imgPath"].stringValue,friendType: "wantedTo"
                                    ,age:$0["to"]["age"].stringValue + "세",userId: $0["to"]["userId"].stringValue)
                    }
                    if parseWantedToList.isEmpty{
                        parseWantedToList = [FriendModel(name:"아직 친구가 없어요 :(",sex: "M",
                                    introduce:"",favoritGame:"친구찾기 탭에서 새로운 친구를 만나보아요!",
                                    imgUrl: "nofriend",friendType: "friend"
                                    ,age:"",userId:"")]
                    }
                    let sectionWantedToList = FriendInfoSection(header:"친구 요청한 리스트",items: parseWantedToList)
                    
                    let wantedFromList = JSON(model["data"]["wantedFromList"])
                    var parseWantedFromList = wantedFromList.arrayValue.map{
                        FriendModel(name:$0["from"]["nickName"].stringValue,sex: $0["from"]["sex"].stringValue,
                                    introduce:$0["from"]["introduce"].stringValue,favoritGame:$0["from"]["favoritGame"].stringValue,
                                    imgUrl: $0["from"]["imgPath"].stringValue,friendType: "wantedFrom"
                                    ,age:$0["from"]["age"].stringValue + "세",userId: $0["from"]["userId"].stringValue)
                    }
                    if parseWantedFromList.isEmpty {
                        parseWantedFromList = [FriendModel(name:"새롭게 요청받은 친구가 없어요 :(",sex: "M",
                                    introduce:"",favoritGame:"친구찾기 탭에서 새로운 친구를 만나보아요!",
                                    imgUrl: "nofriend",friendType: "wantedFrom"
                                    ,age:"",userId:"")]
                    }
                    
                    let sectionWantedFromList = FriendInfoSection(header: "친구 요청받은 리스트", items: parseWantedFromList)
                        
                    let sectionData = [sectionWantedFromList,sectionWantedToList,sectionFriendList]

                    observer.onNext(sectionData)
                    observer.onCompleted()
                    
                    //print(model)
                    
                case .failure(let error):
                    observer.onError(error)
                }
                
            }

            return Disposables.create()
        }
    }
    
    func postInsertData(toUser: String!, fromUser:String!) ->  Observable<Void>{
        return Observable.create({(observer) -> Disposable in
            let params = [
                "toUser":toUser,
                "fromUser":fromUser
            ]
            
            AF.request(self.postInsertUrl, method: .post, parameters: params)
                .responseData{ response in
                    switch response.result {
                    case .success(let json):
                        let model = JSON(json)
                        let postStats = model["message"].stringValue
                        //print(model)
                        if postStats == "insert_complete"{
                            //observer.onNext(postStats)
                            observer.onCompleted()
                        }else{
                            observer.onError(AFError.responseValidationFailed(reason: .dataFileNil))
                        }
                        
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            
            return Disposables.create()
        })
    }
    
    func postWanted(toUser: String!, fromUser:String!) ->  Observable<Void>{
        return Observable.create({(observer) -> Disposable in
            let params = [
                "to":toUser,
                "from":fromUser
            ]
            
            AF.request(self.postWantedUrl, method: .post, parameters: params)
                .responseData{ response in
                    switch response.result {
                    case .success(let json):
                        let model = JSON(json)
                        print(model)
                        let postStats = model["message"].stringValue
                        //print(model)
                        if postStats == "insert_complete"{
                            //observer.onNext(postStats)
                            observer.onCompleted()
                        }else{
                            observer.onError(AFError.responseValidationFailed(reason: .dataFileNil))
                        }
                        
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            
            return Disposables.create()
        })
    }
}
