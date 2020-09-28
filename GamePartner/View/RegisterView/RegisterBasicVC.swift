//
//  RegisterBasicVC.swift
//  GamePartner
//
//  Created by 민창경 on 2020/08/19.
//

import UIKit
import PromiseKit
import SwiftyJSON

class RegisterBaiscVC: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblGuide: UILabel!
    @IBOutlet weak var txtCheckId: UILabel!
    @IBOutlet weak var txtId: UITextField!{
        didSet{
            let placeholderText = NSAttributedString(string: "ID를 입력해주세요")
            txtId.delegate = self
            txtId.attributedPlaceholder = placeholderText
        }
    }
    
    @IBOutlet weak var txtPw: UITextField!{
        didSet{
            let placeholderText = NSAttributedString(string: "PW를 입력해주세요")
            txtPw.delegate = self
            txtPw.attributedPlaceholder = placeholderText
        }
    }
    private var isDuplicated:Bool = false
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animate()
      
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
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason){
        firstly{
            RegisterAPIService.shared.checkUserId(userId: txtId.text)
        }.done{ response in
            if(response["message"] as! String == "N"){
                self.txtCheckId.isHidden = false
                self.isDuplicated = false
            }
            if(response["message"] as! String == "Y"){
                self.txtCheckId.isHidden = true
                self.isDuplicated = true
            }
        }.catch{ error in
            self.alert("오류 발생", message: "회원 가입중 오류가 발생 했습니다. 네트워크를 확인 해주세요 :(")
        }
    }
    
    @IBAction func btnNextPressed(_ sender: Any) {
        print(isDuplicated)
        if txtId.text!.isEmpty || txtPw.text!.isEmpty{
            alert("값을 입력해주세요!", message: "ID와 PW를 입력해주세요!")
        }else if txtId.text!.count < 8 || txtPw.text!.count < 8{
            alert("값을 확인해주세요!", message: "ID와 PW는 최소 9개 이상으로 입력가능합니다!")
        }else if self.isDuplicated == true{
            alert("값을 확인해주세요!", message: "이미 존재하는 아이디 입니다!")
        }else{
            performSegue(withIdentifier: "moveToSexRegister", sender: nil)
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
    
    
    private func initControl(){
        self.lblGuide.font = UIFont.boldSystemFont(ofSize: 30)
        self.txtId.layer.cornerRadius = 50
        self.txtPw.layer.cornerRadius = 50
        self.btnNext.alpha = 0.0
        self.txtCheckId.isHidden = true
    }
    
   
    private func animate(){
        UIView.animateKeyframes(withDuration: 3.0, delay: 0.0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration:0.3, animations: {
                self.btnNext.alpha = 1.0
            })
        },completion: nil)
    }
    
    private func alert(_ title: String, message: String){
        let alert = UIAlertController(title: title, message: message
                                      ,preferredStyle:UIAlertController.Style.alert)
        let action = UIAlertAction(title:"OK", style: UIAlertAction.Style.default,handler: nil)
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
}

