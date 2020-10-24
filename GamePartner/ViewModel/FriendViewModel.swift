//
//  FriendViewModel.swift
//  GamePartner
//
//  Created by 민창경 on 2020/10/13.
//

import Foundation
import RxSwift
import RxCocoa

protocol FriendViewModelType {
    // MARK: - Output
    var fetchFriendList: AnyObserver<Void> { get }
    //var bountyInfo : Observable<BountyInfo> {get}
}

class FriendViewModel : FriendViewModelType{
    var disposeBag = DisposeBag()
    let fetchFriendList: AnyObserver<Void>
    //let bountyInfo : Observable<BountyInfo>
    
    init(){
        let fetching = PublishSubject<Void>()
        //let friendList = BehaviorSubject<[FriendInfoSection]>(value: [])
        fetchFriendList = fetching.asObserver()
        
        //let disposeBag = DisposeBag()
//        friendList = Observable.just([
//
//            FriendInfoSection(header: "친구 요청 받은 리스트", items: [
//                FriendModel(name: "권예진", sex: "W", introduce: "롤 마스터", favoritGame: "리그오브레전드", imgUrl: "janu782323"),
//                FriendModel(name: "민창경", sex: "M", introduce: "롤 마스터", favoritGame: "리그오브레전드", imgUrl: "2020033111330479802_1.jpg"),
//                FriendModel(name: "민창경", sex: "M", introduce: "롤 마스터", favoritGame: "리그오브레전드", imgUrl: "9fd8599293eafd6d60cf3457bdd6384e.jpg"),
//            ]),
//            FriendInfoSection(header: "친구 요청한 리스트", items: [
//                FriendModel(name: "민창경", sex: "M", introduce: "롤 마스터", favoritGame: "리그오브레전드", imgUrl: "2020033111330479802_1.jpg"),
//                FriendModel(name: "권례찐", sex: "W", introduce: "롤 마스터", favoritGame: "리그오브레전드", imgUrl: "janu782323"),
//                FriendModel(name: "민창경", sex: "M", introduce: "롤 마스터", favoritGame: "리그오브레전드", imgUrl: "9fd8599293eafd6d60cf3457bdd6384e.jpg"),
//            ]),
//            FriendInfoSection(header: "내 친구 리스트", items: [
//                FriendModel(name: "권예진", sex: "W", introduce: "롤 마스터", favoritGame: "리그오브레전드", imgUrl: "janu782323"),
//                FriendModel(name: "권예찐", sex: "W", introduce: "롤 마스터", favoritGame: "리그오브레전드", imgUrl: "2020033111330479802_1.jpg"),
//                FriendModel(name: "민창경", sex: "M", introduce: "롤 마스터", favoritGame: "리그오브레전드", imgUrl: "9fd8599293eafd6d60cf3457bdd6384e.jpg"),
//            ]),
//
//
//
//
//        ]).observeOn(MainScheduler.instance)
        
        
        fetching
            .flatMap{ _ -> Observable<[FriendInfoSection]> in
                return FriendAPIService.shared.getIndexData(userId: "janu723123")
            }
            .subscribe{ (event) in
                print("asdfasdf")
                switch event {
                case .next(let friend):
                    print(friend)
                case .error(let error):
                    print(error)
                case .completed:
                    print("completed")
                }
            }
            .disposed(by: disposeBag)
    }
    
}
