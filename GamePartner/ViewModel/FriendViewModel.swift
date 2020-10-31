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
    var fetchFriendList: Observable<[FriendInfoSection]> { get }
    var fetchIndexApi: AnyObserver<Void> { get }
    
    var activated: Observable<Bool> { get }
}

class FriendViewModel : FriendViewModelType{
    var disposeBag = DisposeBag()
    let fetchFriendList: Observable<[FriendInfoSection]>
    let fetchIndexApi: AnyObserver<Void>

    var activated: Observable<Bool>
    
    init(){
        let fetching = PublishSubject<Void>()
        let friends = BehaviorSubject<[FriendInfoSection]>(value: [])
        //let loadingProcess = BehaviorRelay(value: false)
        let loading = BehaviorRelay<Bool>(value:true)
        fetchIndexApi = fetching.asObserver()
        fetchFriendList = friends
        
        fetching
            .do(onNext:{_ in loading.accept(false)})
            .flatMap{_ -> Observable<[FriendInfoSection]> in
            return FriendAPIService.shared.getIndexData(userId: "janu723123")}
            .do(onNext: {_ in loading.accept(true)})
            .subscribe(onNext: friends.onNext)
            .disposed(by: disposeBag)
        
        activated = loading.distinctUntilChanged()
    }
    
}
