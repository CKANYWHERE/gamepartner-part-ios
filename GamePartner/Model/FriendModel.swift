//
//  FriendModel.swift
//  GamePartner
//
//  Created by 민창경 on 2020/10/13.
//

import UIKit

struct FriendModel {
    let imgUrl:String?
    let nickName:String?
    let sex:String?
    let age:Int?
    let favoritGame:String?
    var image:UIImage?{
        return UIImage(named: "luffy.jpg")
    }
    
    init(name:String, sex:String, age:Int, favoritGame:String, imgUrl:String ) {
        self.nickName = name
        self.sex = sex
        self.age = age
        self.favoritGame = favoritGame
        self.imgUrl = imgUrl
    }
}
