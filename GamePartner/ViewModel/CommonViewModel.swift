//
//  CommonViewModel.swift
//  GamePartner
//
//  Created by 문효재 on 2020/10/11.
//

import Foundation
import RxSwift
import RxCocoa

class CommonViewModel:NSObject {
    let title : Driver<String>
    let userInfo:UserModel
    
    init(title: String, userInfo: UserModel) {
        self.title = Observable.just(title).asDriver(onErrorJustReturn: "")
        self.userInfo = userInfo
    }
}
