//
//  UserViewModel.swift
//  GamePartner
//
//  Created by 민창경 on 2020/08/29.
//

import RxCocoa


protocol UserViewPresentable {
    typealias Input = (
        id: Driver<String>,
        pw: Driver<String>,
        sex: Driver<String>,
        age: Driver<Int>,
        birthDay: Driver<String>,
        favoritGame: Driver<String>,()
    )
    typealias Output = ()
    
    var input: UserViewPresentable.Input {get}
    var output: UserViewPresentable.Output {get}
}

class UserViewModel : UserViewPresentable{
    
    var input: UserViewPresentable.Input
    var output: UserViewPresentable.Output
    
    init(input: UserViewPresentable.Input){
        self.input = input
        self.output = UserViewModel.output(input: self.input)
    }
    
}

private extension UserViewModel{
    static func output(input: UserViewPresentable.Input)
    -> UserViewPresentable.Output {
        
        return()
    }
}
