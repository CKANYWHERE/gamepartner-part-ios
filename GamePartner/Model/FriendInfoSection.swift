//
//  FriendInfoSection.swift
//  GamePartner
//
//  Created by 민창경 on 2020/10/13.
//

struct FriendInfoSection {
    var header: String
    var items: [FriendInfo]
    
    init(header:String, items:[FriendInfo] ) {
        self.header = header
        self.items = items
    }
    
}

