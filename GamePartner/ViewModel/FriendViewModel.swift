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
    var friendList: Observable<[FriendInfoSection]> { get }
    //var bountyInfo : Observable<BountyInfo> {get}
}

class FriendViewModel : FriendViewModelType{
    let friendList: Observable<[FriendInfoSection]>
    //let bountyInfo : Observable<BountyInfo>
    
    init(){
        friendList = Observable.just([
            
            FriendInfoSection(header: "친구 요청 받은 리스트", items: [
                FriendModel(name: "권예진", sex: "woman", introduce: "롤 마스터", favoritGame: "리그오브레전드", imgUrl: "janu723"),
                FriendModel(name: "민창경", sex: "man", introduce: "롤 마스터", favoritGame: "리그오브레전드", imgUrl: "janu723"),
                FriendModel(name: "민창경", sex: "man", introduce: "롤 마스터", favoritGame: "리그오브레전드", imgUrl: "janu723"),
            ]),
            FriendInfoSection(header: "친구 요청한 리스트", items: [
                FriendModel(name: "민창경", sex: "man", introduce: "롤 마스터", favoritGame: "리그오브레전드", imgUrl: "janu723"),
                FriendModel(name: "권례찐", sex: "woman", introduce: "롤 마스터", favoritGame: "리그오브레전드", imgUrl: "janu723"),
                FriendModel(name: "민창경", sex: "man", introduce: "롤 마스터", favoritGame: "리그오브레전드", imgUrl: "janu723"),
            ]),
            FriendInfoSection(header: "내 친구 리스트", items: [
                FriendModel(name: "권예진", sex: "woman", introduce: "롤 마스터", favoritGame: "리그오브레전드", imgUrl: "janu723"),
                FriendModel(name: "권예찐", sex: "woman", introduce: "롤 마스터", favoritGame: "리그오브레전드", imgUrl: "janu723"),
                FriendModel(name: "민창경", sex: "man", introduce: "롤 마스터", favoritGame: "리그오브레전드", imgUrl: "janu723"),
            ]),
            
            
            
            
        ]).observeOn(MainScheduler.instance)
        
    }
    
}
