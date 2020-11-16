//
//  BoardViewModel.swift
//  GamePartner
//
//  Created by 민창경 on 2020/11/10.
//

import Foundation
import RxCocoa
import RxSwift
import RealmSwift


protocol BoardViewModelType {
    var fetchBoardApi: AnyObserver<Void>{ get }
    var fetchBoardList: Observable<[BoardModel]> { get }
    var activated: Observable<Bool> { get }
    
    var titleTxt:BehaviorRelay<String> { get }
    
    var btnSendCliked:AnyObserver<Void> { get }
}


class BoardViewModel : BoardViewModelType {
    var disposeBag = DisposeBag()
    
    let fetchBoardApi: AnyObserver<Void>
    let fetchBoardList: Observable<[BoardModel]>
    let activated: Observable<Bool>
    
    let btnSendCliked: AnyObserver<Void>
    let titleTxt: BehaviorRelay<String>
    
    init(){
        let fetching = PublishSubject<Void>()
        let boards = BehaviorSubject<[BoardModel]>(value:[])
        let loading = BehaviorRelay<Bool>(value: false)
        let sendBoard = PublishSubject<Void>()
        
        titleTxt = BehaviorRelay(value: "안녕하세요")
        
        btnSendCliked = sendBoard.asObserver()
        
        fetching
            .do(onNext:{_ in loading.accept(false)})
            .flatMap{_ -> Observable<[BoardModel]> in
                return BoardAPIService.shared.getBoardListData()}
            .do(onNext:{_ in loading.accept(true)})
            .subscribe(onNext: boards.onNext)
            .disposed(by: disposeBag)
        
        activated = loading.distinctUntilChanged()
        fetchBoardList = boards
        fetchBoardApi = fetching.asObserver()
        
        _ = sendBoard
            .do(onNext:{_ in loading.accept(false)})
            .flatMap{_ -> Observable<Void> in
                let realm = try! Realm()
                let users = realm.objects(UserModel.self)
                let user = users.first
                
                return BoardAPIService.shared.insertBoard(title: self.titleTxt.value
                                                          , userId: user!.id
                                                          , sex: user!.sex
                                                          , favoritGame: user!.favoritGame
                                                          , nickName: user!.nickName
                                                          , imgPath: user!.id
                                                          , regsterDate: self.getNowTime()
                                                          , age: "\(user!.age)")
            }
            .do(onNext:{_ in loading.accept(true)})
            .subscribe()
            .disposed(by: disposeBag)
        
    }
    
    func getNowTime() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = Date()
        let nowDateStr = formatter.string(from: date)
        return nowDateStr
    }
}
