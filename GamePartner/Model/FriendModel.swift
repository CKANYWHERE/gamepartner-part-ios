//
//  FriendModel.swift
//  GamePartner
//
//  Created by 민창경 on 2020/10/13.
//

import UIKit

struct FriendModel {
    var imgUrl:String?
    let nickName:String?
    let sex:String?
    let introduce:String?
    let favoritGame:String?
    let friendType: String?
    var imgProfile:UIImage?
    var imageSex:UIImage?{
        if self.sex == "M"{
            return UIImage(named: "man.png")
        }else{
            return UIImage(named: "woman.png")
        }
    }
    
    init(name:String, sex:String, introduce:String, favoritGame:String, imgUrl:String, friendType:String) {
        self.nickName = name
        self.sex = sex
        self.introduce = introduce
        self.favoritGame = favoritGame
        self.imgUrl = imgUrl
        self.friendType = friendType
    }
    

    init(name:String, sex:String, introduce:String, favoritGame:String, imgProfile:UIImage, friendType:String) {
        self.nickName = name
        self.sex = sex
        self.introduce = introduce
        self.favoritGame = favoritGame
        self.imgProfile = imgProfile
        self.friendType = friendType
    }
    
}
