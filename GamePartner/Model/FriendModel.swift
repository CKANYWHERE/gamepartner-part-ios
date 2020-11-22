//
//  FriendModel.swift
//  GamePartner
//
//  Created by 민창경 on 2020/10/13.
//

import UIKit
import Kingfisher

struct FriendModel {
    var imgUrl:String?
    let userId:String?
    let nickName:String?
    let sex:String?
    let age:String?
    let introduce:String?
    let favoritGame:String?
    let friendType: String?
    var cellPhone: String?
    var imgProfile:UIImage?
    var imageSex:UIImage?{
        if self.sex == "M"{
            return UIImage(named: "man.png")
        }else{
            return UIImage(named: "woman.png")
        }
    }
    
    init(name:String, sex:String, introduce:String, favoritGame:String, imgUrl:String
         , friendType:String, age:String, userId:String) {
        self.nickName = name
        self.sex = sex
        self.introduce = introduce
        self.favoritGame = favoritGame
        self.imgUrl = imgUrl
        self.friendType = friendType
        self.age = age
        self.userId = userId
    }
    
    init(name:String, sex:String, introduce:String, favoritGame:String, imgUrl:String
         , friendType:String, age:String, userId:String,cellPhone:String) {
        self.nickName = name
        self.sex = sex
        self.introduce = introduce
        self.favoritGame = favoritGame
        self.imgUrl = imgUrl
        self.friendType = friendType
        self.age = age
        self.userId = userId
        self.cellPhone = cellPhone
    }
    
    
    init(name:String, sex:String, introduce:String, favoritGame:String, imgProfile:UIImage
         , friendType:String, age:String, userId:String) {
        self.nickName = name
        self.sex = sex
        self.introduce = introduce
        self.favoritGame = favoritGame
        self.imgProfile = imgProfile
        self.friendType = friendType
        self.age = age
        self.userId = userId
    }
    
}
