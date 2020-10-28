//
//  RegisterViewModel.swift
//  GamePartner
//
//  Created by 문효재 on 2020/10/28.
//

import Foundation
import PromiseKit

class RegisterViewModel {
    var newUser:UserModel = UserModel()
    var errorMessage:String = "!"
    
    func register() -> String {
        RegisterAPIService.shared.checkUserId(userId: newUser.id)
            .then{ response -> Promise<[String : Any]> in
                //return
                self.parseResponse(response: response)
            }.done{ result in
                if self.newUser.id.isEmpty || self.newUser.pw.isEmpty{
                    self.errorMessage = "아이디와 비밀번호를 입력해주세요"
                    
                }else if self.newUser.id.count < 8 || self.newUser.pw.count < 8{
                    self.errorMessage = "아이디와 비밀번호를 최소 9자리 이상으로 맞춰주세요"
                    
                }else if result["duplicated"] as! Bool == true{
                    self.errorMessage = "이미 존재하는 아이디입니다"
                    
                }else{
                    self.errorMessage = ""
                    
                }
            }.catch{ error in
                self.errorMessage = "\(error)"
            }
        
        return self.errorMessage
    }
    
    private func parseResponse(response:[String:Any]) -> Promise<[String:Any]>{
        return Promise{ seal in
            if(response["message"] as! String == "N"){
                //                self.txtCheckId.isHidden = false
                seal.fulfill(["duplicated":true])
            }
            if(response["message"] as! String == "Y"){
                //                self.txtCheckId.isHidden = true
                seal.fulfill(["duplicated":false])
            }
        }
        
    }
}



