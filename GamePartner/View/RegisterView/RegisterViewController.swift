//
//  RegisterViewController.swift
//  GamePartner
//
//  Created by 문효재 on 2020/10/27.
//

import UIKit
import PromiseKit
import RxSwift
import RxCocoa

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    
    @IBOutlet weak var textFieldID: UITextField!
    @IBOutlet weak var textFieldPW: UITextField!
    @IBOutlet weak var textFieldPWValid: UITextField!
    
    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var labelErrorMessage: UILabel!
    
    var viewModel = RegisterViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initComponents()
        validRegisterInfo()
    }
    
    // 이동
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination
        guard let rvc = dest as? RegisterSexVC else {
            return
        }
        
        rvc.paramId = textFieldID.text
        rvc.paramPw = textFieldPW.text
    }
    
    // 기본 컴포넌트 설정
    func initComponents(){
        // View 제목, 진행상황 표시
        let prog:Float = 1/7
        
        progress.setProgress( prog , animated: true)
        progress.tintColor = DefaultStyle.Colors.tint
        labelTitle.text = "아이디/비밀번호"
        
        //Password Valid 가리기
        textFieldPWValid.isHidden = true
        labelErrorMessage.isHidden = true
        
        textFieldID.layer.cornerRadius = DefaultStyle.Radius.TextField
        textFieldPW.layer.cornerRadius = DefaultStyle.Radius.TextField
        textFieldPWValid.layer.cornerRadius = DefaultStyle.Radius.TextField
        textFieldID.layoutMargins.top = 100
        
        buttonNext.backgroundColor = DefaultStyle.Colors.tint
        buttonNext.tintColor = DefaultStyle.Colors.text
        buttonNext.layer.cornerRadius = DefaultStyle.Radius.button
        buttonNext.isHidden = true
        
    }
    
    
    // Register 
    @IBAction func nextPressed(_ sender: Any) {
        guard let id = textFieldID.text, let pw = textFieldPW.text else {return}
        let user:UserModel = UserModel()
        user.id = id
        user.pw = pw
        
        let result = regitser(user: user)
        if result.isEmpty {
            self.performSegue(withIdentifier: "moveToSexRegister", sender: nil)
        } else {
            self.labelErrorMessage.isHidden = false
            self.labelErrorMessage.text = result
        }
    }

    
    func validRegisterInfo(){
        textFieldID.rx.text.asObservable()
            .subscribe(onNext: { id in
                guard let id = id else { return }
                if id.count >= 9 || id.isEmpty {
                    self.textFieldID.backgroundColor = .none
                }  else {
                    self.textFieldID.backgroundColor = .systemRed
                }
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        
        textFieldPW.rx.text.asObservable()
            .subscribe(onNext: { pw in
                guard let pw = pw else { return }
                if pw.isEmpty {
                    self.textFieldPWValid.isHidden = true
                    self.textFieldPWValid.text = ""
                    
                } else if pw.count >= 9 {
                    self.textFieldPW.backgroundColor = .none
                    self.textFieldPWValid.isHidden = false
                                    
                } else {
                    self.textFieldPW.backgroundColor = .systemRed
                    self.textFieldPWValid.isHidden = true
                    
                }
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        
        textFieldPWValid.rx.text.asObservable()
            .subscribe(onNext: { pwValid in
                guard let pwValid = pwValid else { return }
                guard let pw = self.textFieldPW.text else { return }
                
                print("pw=\(pw), pwValid=\(pwValid)")
                if pwValid == pw && !pw.isEmpty {
                    self.buttonNext.isHidden = false
                } else {
                    self.buttonNext.isHidden = true
                }
                
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
    }
    
    
    
}

extension RegisterViewController {
    
    func regitser(user: UserModel) -> String{
        var message:String = "!"
        RegisterAPIService.shared.checkUserId(userId: user.id)
            .then{ response -> Promise<[String : Any]> in
                //return
                self.parseResponse(response: response)
            }
            .done{ result in
                if user.id.isEmpty || user.pw.isEmpty{
                    message = "아이디와 비밀번호를 입력해주세요"

                }else if user.id.count < 8 || user.pw.count < 8{
                    message = "아이디와 비밀번호를 최소 9자리 이상으로 맞춰주세요"
                    
                }else if result["duplicated"] as! Bool == true{
                     message = "이미 존재하는 아이디입니다"

                }else{
                    message = ""
                    
                }
                
                dump(message)
            }
            .catch{ error in
                message = "회원 가입중 오류가 발생 했습니다. 네트워크를 확인 해주세요 :("
            }
        
        dump(message)
        
        return message
    }
    
    private func parseResponse(response:[String:Any]) -> Promise<[String:Any]>{
        return Promise{ seal in
            if(response["message"] as! String == "N"){
                seal.fulfill(["duplicated":true])
            }
            if(response["message"] as! String == "Y"){
                seal.fulfill(["duplicated":false])
            }
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

class RegisterViewModel {
    var newUser:UserModel = UserModel()
    var errorMessage:String = ""
    
    func register(){
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



