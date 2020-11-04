//
//  FriendDetailViewModel.swift
//  GamePartner
//
//  Created by 민창경 on 2020/11/02.
//

import Foundation
import RxCocoa
import RxSwift

protocol FriendDetialViewModelType {
    var imgUrlTxt: Observable<String> { get }
    var nickNameTxt: Observable<String> { get }
    var sexTypeImg: Observable<UIImage> { get }
    var favoritGameTxt: Observable<String> { get }
    var introduceTxt: Observable<String> { get }
    var ageTxt:Observable<String>{ get }
    var friendType:Observable<String>{ get }
    
    var btnChatClicked:AnyObserver<Void>{ get }
    var btnAcceptClicked:AnyObserver<Void>{ get }
    var btnDeclineCliked:AnyObserver<Void>{ get }
    
    var moveToMainPage:Observable<Void> { get }
    //var chatResult:Signal<Result<String>> { get }
}

class FriendDetialViewModel : FriendDetialViewModelType{
    
    var disposeBag = DisposeBag()
    
    let imgUrlTxt: Observable<String>
    let nickNameTxt: Observable<String>
    let sexTypeImg: Observable<UIImage>
    let favoritGameTxt: Observable<String>
    let introduceTxt: Observable<String>
    let ageTxt: Observable<String>
    let friendType: Observable<String>
    
    let btnChatClicked: AnyObserver<Void>
    let btnAcceptClicked: AnyObserver<Void>
    let btnDeclineCliked: AnyObserver<Void>
    var moveToMainPage: Observable<Void>

    init(model Friend:FriendModel){
        //super.init()
        
        let chating = PublishSubject<Void>()
        let decline = PublishSubject<Void>()
        let accept = PublishSubject<Void>()
        
        imgUrlTxt = Observable.just(Friend.imgUrl ?? "")
            .observeOn(MainScheduler.instance)
        nickNameTxt = Observable.just(Friend.nickName ?? "")
            .observeOn(MainScheduler.instance)
        sexTypeImg = Observable.just(Friend.imageSex ?? UIImage(named: "man.png")!)
            .observeOn(MainScheduler.instance)
        favoritGameTxt = Observable.just(Friend.favoritGame ?? "")
            .observeOn(MainScheduler.instance)
        introduceTxt = Observable.just(Friend.introduce ?? "")
            .observeOn(MainScheduler.instance)
        ageTxt = Observable.just(Friend.age ?? "0세")
            .observeOn(MainScheduler.instance)
        friendType = Observable.just(Friend.friendType ?? "wantedTo")
            .observeOn(MainScheduler.instance)
        
        _ = chating.subscribe(
            onNext: { _ in
                print("chat")
            }).disposed(by: disposeBag)
        
        _ = decline.subscribe(onNext: { _ in
            print("decline api call")
        }).disposed(by: disposeBag)
        
        _ = accept.subscribe(onNext: { _ in
            print("accept api call")
        }).disposed(by: disposeBag)
        
        btnChatClicked = chating.asObserver()
        btnAcceptClicked = accept.asObserver()
        btnDeclineCliked = decline.asObserver()
        
        moveToMainPage = Observable.merge(accept,decline)
    }
    

}