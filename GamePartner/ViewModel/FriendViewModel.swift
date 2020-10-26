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
    var fetchFriendList: Observable<[FriendInfoSection]> { get }
    var fetchIndexApi: AnyObserver<Void> { get }
    //var bountyInfo : Observable<BountyInfo> {get}
}

class FriendViewModel : FriendViewModelType{
    var disposeBag = DisposeBag()
    let fetchFriendList: Observable<[FriendInfoSection]>
    let fetchIndexApi: AnyObserver<Void>
    //let bountyInfo : Observable<BountyInfo>
    
    init(){
        let fetching = PublishSubject<Void>()
        let friends = BehaviorSubject<[FriendInfoSection]>(value: [])
        //let loadingProcess = BehaviorRelay(value: false)
        
        fetchIndexApi = fetching.asObserver()
        fetchFriendList = friends

        fetching
            .flatMap{_ -> Observable<[FriendInfoSection]> in
            return FriendAPIService.shared.getIndexData(userId: "janu723123")}
            .subscribe(onNext: friends.onNext)
            .disposed(by: disposeBag)
    }
    
}
