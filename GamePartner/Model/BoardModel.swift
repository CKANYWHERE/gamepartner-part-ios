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
    let age:Int
    var date:String
    let title:String
    
    init(imgPath:String, userId:String, favoritGame:String, nickName:String, age:Int
         , date:String, boardOid:String, title:String) {
        self.nickName = nickName
        self.userId = userId
        self.favoritGame = favoritGame
        self.age = age
        self.imgPath = imgPath
        self.date = date
        self.boardOid = boardOid
        self.title = title
    }
}
