//
//  RegisterBasicVC.swift
//  GamePartner
//
//  Created by 민창경 on 2020/08/19.
//

import UIKit
import PromiseKit
import SwiftyJSON
import RxSwift
import RxCocoa

class RegisterBaiscVC: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var btnNext: UIButton!
//    @IBOutlet weak var lblGuide: UILabel!
    @IBOutlet weak var txtCheckId: UILabel!
    @IBOutlet weak var txtId: UITextField!
    @IBOutlet weak var txtPw: UITextField!
    
    @IBOutlet weak var txtIDPWUnderLength: UILabel!
    @IBOutlet weak var txtIDPWIllegalChar: UILabel!
    
    private var isDuplicated:Bool!
    
    let viewModel = RegisterIDPasswordViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        view.largeContentTitle = "회원가입"

        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        validLogin()
    }
    
    func validLogin(){
        txtId.rx.text.asObservable()
            .subscribe(onNext: {id in
                // 자리수 판별
                if id?.count ?? 0 >= 9 {
//                    self.txtIDPWUnderLength.textColor = .green
                } else {
//                    self.txtIDPWUnderLength.textColor = .red
                }

                // 특수문자 판별
                
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by:disposeBag)
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination
        guard let rvc = dest as? RegisterSexVC else {
            return
        }
        
        rvc.paramId = txtId.text
        rvc.paramPw = txtPw.text
    }
 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func parseResponse(response:[String:Any]) -> Promise<[String:Any]>{
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
    
    @IBAction func btnNextPressed(_ sender: Any) {
        
        btnNext.isEnabled = false
        RegisterAPIService.shared.checkUserId(userId: txtId.text)
        .then{ response -> Promise<[String : Any]> in
            //return
            self.parseResponse(response: response)
        }
        .done{ result in
            if self.txtId.text!.isEmpty || self.txtPw.text!.isEmpty{
//                self.alert("값을 입력해주세요!", message: "ID와 PW를 입력해주세요!")
                self.txtCheckId.text = "값을 입력해주세요"
            }else if self.txtId.text!.count < 8 || self.txtPw.text!.count < 8{
//                self.alert("값을 확인해주세요!", message: "ID와 PW는 최소 9개 이상으로 입력가능합니다!")
                self.txtCheckId.text = "ID와 비밀번호는 최소 9자 이상으로 입력가능합니다."
            }else if result["duplicated"] as! Bool == true{
//                self.alert("값을 확인해주세요!", message: "이미 존재하는 아이디 입니다!")
                self.txtCheckId.text = "이미 존재하는 아이디입니다."
            }else{
                self.performSegue(withIdentifier: "moveToSexRegister", sender: nil)
            }

            self.btnNext.isEnabled = true
        }
        .catch{ error in
            self.alert("오류 발생", message: "회원 가입중 오류가 발생 했습니다. 네트워크를 확인 해주세요 :(")
        }

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let utf8Char = string.cString(using: .utf8)
            let isBackSpace = strcmp(utf8Char, "\\b")
               if string.isValidId() || isBackSpace == -92{
                return true
            }
        return false
    }
    
    
    
    
   
    
    
    private func alert(_ title: String, message: String){
        let alert = UIAlertController(title: title, message: message
                                      ,preferredStyle:UIAlertController.Style.alert)
        let action = UIAlertAction(title:"OK", style: UIAlertAction.Style.default,handler: nil)
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
}

// 뷰 관련
extension RegisterBaiscVC{
    private func animate(){
        UIView.animateKeyframes(withDuration: 3.0, delay: 0.0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration:0.3, animations: {
//                self.btnNext.alpha = 1.0
            })
        },completion: nil)
    }
    
    private func initControl(){
        self.txtId.layer.cornerRadius = 50
        self.txtPw.layer.cornerRadius = 50
        self.btnNext.alpha = 0.0
        self.btnNext.layer.cornerRadius = 8
        self.txtCheckId.isHidden = true
    }
    
//    private func wrongData()
    
    enum errorMessage {
        
    }
}


class RegisterIDPasswordViewModel{
//    var user:UserModel
    

}
