//
//  RegisterCompleteVC.swift
//  GamePartner
//
//  Created by 민창경 on 2020/09/03.
//

import Foundation
import UIKit

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
        
        
            /*let realm = try! Realm()
            let user = UserModel(id:self.paramId,pw:self.paramPw,sex:self.paramSex,age:self.paramAge
                                 ,birthDay:self.paramBirthDay,favoritGame: self.paramGames
                                 ,introduce: self.paramIntroduce,nickName: self.paramNickNamesss
            
            try! realm.write{
                realm.add(user)
            }*/

    }
}
