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
    let introduce:String?
    let favoritGame:String?
    
//    var image:UIImage?{
//        return UIImage(named: "luffy.jpg")
//    }
    var imageSex:UIImage?{
        if self.sex == "M"{
            return UIImage(named: "man.png")
        }else{
            return UIImage(named: "woman.png")
        }
    }
    
    init(name:String, sex:String, introduce:String, favoritGame:String, imgUrl:String ) {
        self.nickName = name
        self.sex = sex
        self.introduce = introduce
        self.favoritGame = favoritGame
        self.imgUrl = imgUrl
    }
}
