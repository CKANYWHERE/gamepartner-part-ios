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
}


class BoardViewModel : BoardViewModelType {
    var disposeBag = DisposeBag()
    
    let fetchBoardApi: AnyObserver<Void>
    let fetchBoardList: Observable<[BoardModel]>
    let activated: Observable<Bool>
    
    init(){
        let fetching = PublishSubject<Void>()
        let boards = BehaviorSubject<[BoardModel]>(value:[])
        let loading = BehaviorRelay<Bool>(value: false)
        
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
        
    }
}
