//
//  BoardModel.swift
//  GamePartner
//
//  Created by 민창경 on 2020/11/10.
//

import Foundation

struct BoardModel {
    var imgPath:String
    let boardOid:String
    let userId:String
    let favoritGame:String
    let nickName:String
    let age:String
    let date:String
    let clickCount:Int
    
    init(imgPath:String, userId:String, favoritGame:String, nickName:String, age:String
         , date:String, clickCount:Int, boardOid:String) {
        self.nickName = nickName
        self.userId = userId
        self.favoritGame = favoritGame
        self.age = age
        self.imgPath = imgPath
        self.date = date
        self.clickCount = clickCount
        self.boardOid = boardOid
    }
}
