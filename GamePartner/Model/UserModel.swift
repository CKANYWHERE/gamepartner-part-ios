//
//  UserModel.swift
//  GamePartner
//
//  Created by 민창경 on 2020/08/21.
//

import Foundation
import RealmSwift

class UserModel : Object{

    @objc dynamic var id: String = ""
    @objc dynamic var pw: String = ""
    @objc dynamic var sex: String = ""
    @objc dynamic var age: Int = 0
    @objc dynamic var birthDay: String = ""
    @objc dynamic var favoritGame: String = ""
    @objc dynamic var introduce: String = ""
    @objc dynamic var nickName: String = ""
    

    
    convenience init(id:String,pw:String,sex:String,age:Int,birthDay:String,favoritGame:String,introduce:String,nickName:String) {
        self.init()
        self.id = id
        self.pw = pw
        self.sex = sex
        self.age = age
        self.birthDay = birthDay
        self.favoritGame = favoritGame
        self.introduce = introduce
        self.nickName = nickName
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    override class func indexedProperties() -> [String] {
        return ["id","nickName"]
    }
}
