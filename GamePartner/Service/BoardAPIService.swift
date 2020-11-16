//
//  BoardAPIService.swift
//  GamePartner
//
//  Created by 민창경 on 2020/11/12.
//
import Foundation
import Alamofire
import SwiftyJSON
import RxSwift
import RxCocoa

class BoardAPIService : NSObject{
    static let shared = BoardAPIService()
        
    private var getBoardListUrl = Util.mainUrl + Util.getBoardList
    private var insertBoardUrl = Util.mainUrl + Util.insertBoard
    
    func getBoardListData() -> Observable<[BoardModel]>{
        return Observable.create { (observer) -> Disposable in
            AF.request(self.getBoardListUrl, method: .get).responseData {
                response in
                switch response.result {
                case .success(let json):
                    let model = JSON(json)
                    let boardList = model["data"].arrayValue.map{
                        BoardModel(imgPath: $0["register"]["imgPath"].stringValue,
                                   userId: $0["register"]["userId"].stringValue, favoritGame:$0["register"]["favoritGame"].stringValue,
                                   nickName: $0["register"]["nickName"].stringValue, age: $0["register"]["age"].intValue
                                   , date: $0["registerDate"].stringValue, boardOid: $0["_id"].stringValue,title: $0["title"].stringValue
                                   ,sex: $0["register"]["sex"].stringValue)
                    }
                    
                    //print(boardList)
                    
                    observer.onNext(boardList)
                    observer.onCompleted()
                    
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func insertBoard(title:String, userId:String, sex:String,
                     favoritGame:String, nickName:String, imgPath:String, regsterDate:String, age:String) -> Observable<Void>{
        let params = [
            "title":title,
            "userId":userId,
            "sex":sex,
            "favoritGame":favoritGame,
            "nickName":nickName,
            "imgPath":imgPath,
            "registerDate":regsterDate,
            "age":age
        ]
        return Observable.create{ (observer) -> Disposable in
            AF.request(self.insertBoardUrl, method: .post,parameters: params).responseData{
                response in
                switch response.result{
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
        }
    }
}
