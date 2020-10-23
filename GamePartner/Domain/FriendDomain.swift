//
//  FriendDomain.swift
//  GamePartner
//
//  Created by 민창경 on 2020/10/22.
//

import Foundation
import RxSwift

protocol FriendFetchable {
    func fetchFriends(userId:String?) -> Observable<[FriendInfoSection]>
}

class MenuStore: FriendFetchable {

    
    func fetchFriends(userId:String?) -> Observable<[FriendInfoSection]> {
        
        return FriendAPIService.getIndexData(userId: userId)
            .map { data in
                guard let response = try? JSONDecoder().decode(Response.self, from: data) else {
                    throw NSError(domain: "Decoding error", code: -1, userInfo: nil)
                }
                return response.menus
            }
    }
}

