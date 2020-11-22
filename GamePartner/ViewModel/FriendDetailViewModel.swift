//
//  FriendDetailViewModel.swift
//  GamePartner
//
//  Created by 민창경 on 2020/11/02.
//

import Foundation
import RxCocoa
import RxSwift
import RealmSwift
import MessageUI
import Firebase

protocol FriendDetialViewModelType {
    var imgUrlTxt: Observable<String> { get }
    var nickNameTxt: Observable<String> { get }
    var sexTypeImg: Observable<UIImage> { get }
    var favoritGameTxt: Observable<String> { get }
    var introduceTxt: Observable<String> { get }
    var ageTxt:Observable<String>{ get }
    var friendType:Observable<String>{ get }
    var userId:Observable<String>{ get }
    
    var btnChatClicked:AnyObserver<Void>{ get }
    var btnAcceptClicked:AnyObserver<Void>{ get }
    var btnDeclineCliked:AnyObserver<Void>{ get }
    var btnDialClicked:AnyObserver<Void>{ get }
    
    var moveToMainPage:Observable<Void> { get }
    
    var activated: Observable<Bool> { get }
    //var chatResult:Signal<Result<String>> { get }
}

class FriendDetialViewModel : FriendDetialViewModelType{
    
    var disposeBag = DisposeBag()
    var db = Database.database().reference()
    
    
    let imgUrlTxt: Observable<String>
    let nickNameTxt: Observable<String>
    let sexTypeImg: Observable<UIImage>
    let favoritGameTxt: Observable<String>
    let introduceTxt: Observable<String>
    let ageTxt: Observable<String>
    let friendType: Observable<String>
    let userId: Observable<String>
    
    let btnChatClicked: AnyObserver<Void>
    let btnAcceptClicked: AnyObserver<Void>
    let btnDeclineCliked: AnyObserver<Void>
    let btnDialClicked: AnyObserver<Void>
    var moveToMainPage: Observable<Void>
    
    let activated: Observable<Bool>


    init(model Friend:FriendModel){
        //super.init()
        
        let chating = PublishSubject<Void>()
        let decline = PublishSubject<Void>()
        let accept = PublishSubject<Void>()
        let paging = PublishSubject<Void>()
        let sending = PublishSubject<Void>()
        let dialing = PublishSubject<Void>()
        let loading = BehaviorRelay<Bool>(value: false)
        
        btnChatClicked = chating.asObserver()
        btnAcceptClicked = accept.asObserver()
        btnDeclineCliked = decline.asObserver()
        btnDialClicked = dialing.asObserver()
        activated = loading.distinctUntilChanged()
        moveToMainPage = paging.asObserver()
        //moveToMainPage = Observable.merge(accept,decline)
      
        
        userId = Observable.just(Friend.userId ?? "")
            .observeOn(MainScheduler.instance)
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
        
        _ = dialing.subscribe(onNext:{ _ in
                //print("btnDial")
                if let url = NSURL(string: "tel://\(String(describing: Friend.cellPhone))"),
                   UIApplication.shared.canOpenURL(url as URL) {
                    UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
                }
            }).disposed(by: disposeBag)
        
        _ = chating.subscribe(onNext: { _ in
            }).disposed(by: disposeBag)
        
        _ = decline
            .do(onNext: {_ in loading.accept(false)})
            .flatMap{ _ -> Observable<Void> in
                    let realm = try! Realm()
                    let users = realm.objects(UserModel.self)
                    let user = users.first
                    return FriendAPIService.shared.postInsertData(toUser: user?.id, fromUser: Friend.userId)
                }
            .do(onNext: {_ in loading.accept(true)})
            .bind(to: paging)
            .disposed(by: disposeBag)
        
        _ = paging
            .bind(to: btnAcceptClicked)
            .disposed(by: disposeBag)
        
        _ = accept
            .do(onNext: {_ in loading.accept(false)})
            .flatMap{ _ -> Observable<Void> in
                    let realm = try! Realm()
                    let users = realm.objects(UserModel.self)
                    let user = users.first
                    return FriendAPIService.shared.postInsertData(toUser: user?.id, fromUser: Friend.userId)
                }
            .do(onNext: {_ in loading.accept(true)})
            .bind(to: paging)
            .disposed(by: disposeBag)
        
        _ = sending
            .do(onNext: {_ in loading.accept(false)})
            .flatMap{ _ -> Observable<Void> in
                    let realm = try! Realm()
                    let users = realm.objects(UserModel.self)
                    let user = users.first
                    return FriendAPIService.shared.postWanted(toUser: user?.id, fromUser: Friend.userId)
                }
            .map({$0})
            .do(onNext: {_ in loading.accept(true)})
            .subscribe()
            .disposed(by: disposeBag)
    }
    
  
}
