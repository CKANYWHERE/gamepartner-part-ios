//
//  UserModel.swift
//  GamePartner
//
//  Created by 민창경 on 2020/08/21.
//

import Foundation
import RealmSwift

class ChatRoomModel : Object{

    @objc dynamic var firstUserId: String = ""
    @objc dynamic var secondtUserId: String = ""
    @objc dynamic var firstUserImgPath: String = ""
    @objc dynamic var secondUserImgPath: String = ""
    @objc dynamic var roomId: String = ""
    
    convenience init(firstUserId:String,secondtUserId:String,firstUserImgPath:String,secondUserImgPath:String
                     ,roomId:String) {
        self.init()
        self.firstUserId = firstUserId
        self.secondtUserId = secondtUserId
        self.firstUserImgPath = firstUserImgPath
        self.secondUserImgPath = secondUserImgPath
        self.roomId = roomId
    }
    
    override class func primaryKey() -> String? {
        return "roomId"
    }
    

}
