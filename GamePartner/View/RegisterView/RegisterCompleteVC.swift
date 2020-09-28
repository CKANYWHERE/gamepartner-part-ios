//
//  RegisterCompleteVC.swift
//  GamePartner
//
//  Created by 민창경 on 2020/09/03.
//

import Foundation
import UIKit
import PromiseKit
import SwiftyJSON
import RealmSwift

class RegisterCompleteVC : UIViewController{
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var paramId:String!
    var paramPw:String!
    var paramSex:String!
    var paramAge:Int!
    var paramBirthDay:String!
    var paramGame:String!
    var paramNickName:String!
    var paramIntroduce:String!
    var paramImage:UIImage!
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        spinner.startAnimating()
        doRegister()
    }
    
    private func doRegister(){
        
        firstly{
            RegisterAPIService.shared.insertImage(image: paramImage, userId: paramId, imageType: "jpeg")
        }.done{ response in
            let swifyJson = JSON.init(response["image"] as Any)
            let imgPath = swifyJson[0]["filename"].string
            _ = RegisterAPIService.shared.insertUser(userId: self.paramId, pw: self.paramPw, sex: self.paramSex, age: self.paramAge, birthDay: self.paramBirthDay, favoritGame: self.paramGame, introduce: self.paramIntroduce, nickName: self.paramNickName, imgPath: imgPath!)
        }.done{ response in
            print(response)
        }.catch { error in
            self.alert("오류발생", message: "다시시도 해주세요!")
        }


    }
    
    private func insertIntoMemory(){
        let realm = try! Realm()
        let user = UserModel(id:self.paramId,pw:self.paramPw,sex:self.paramSex,age:self.paramAge
                                 ,birthDay:self.paramBirthDay,favoritGame: self.paramGame
                             ,introduce: self.paramIntroduce,nickName: self.paramNickName)
        try! realm.write{
            realm.add(user)
        }
    }
    
    private func alert(_ title: String, message: String){
        let alert = UIAlertController(title: title, message: message
                                      ,preferredStyle:UIAlertController.Style.alert)
        let action = UIAlertAction(title:"OK", style: UIAlertAction.Style.default,handler: nil)
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
}
