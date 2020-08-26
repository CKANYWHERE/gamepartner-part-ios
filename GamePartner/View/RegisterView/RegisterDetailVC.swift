//
//  RegisterDetailVC.swift
//  GamePartner
//
//  Created by 민창경 on 2020/08/22.
//

import UIKit

class RegisterDetailVC : UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var lblMainNickName: UILabel!
    @IBOutlet weak var lblIntroduce: UILabel!
    @IBOutlet weak var txtIntroduce: UITextField!{
        didSet{
            let placeholderText = NSAttributedString(string: "소개 부탁드려요!")
            self.txtIntroduce.delegate = self
            self.txtIntroduce.attributedPlaceholder = placeholderText
        }
    }
    @IBOutlet weak var txtNickName: UITextField!{
        didSet{
            let placeholderText = NSAttributedString(string: "사용하실 닉네임을 입력해주세요!")
            self.txtNickName.delegate = self
            self.txtNickName.attributedPlaceholder = placeholderText
        }
    }
    
    var paramId:String!
    var paramPw:String!
    var paramSex:String!
    var paramAge:Int!
    var paramBirthDay:String!
    var paramGame:String!

    
    @IBOutlet weak var btnNext: UIButton!
    
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
        guard let rvc = dest as? RegisterPitureVC else {
            return
        }

        rvc.paramId = paramId
        rvc.paramPw = paramPw
        rvc.paramSex = paramSex
        rvc.paramAge = paramAge
        rvc.paramBirthDay = paramBirthDay
        rvc.paramGame = paramGame
        rvc.paramNickName = txtNickName.text!
        rvc.paramIntroduce = txtIntroduce.text!
    }
    
    
    private func initControl(){
        self.btnNext.alpha = 0.0
        self.lblMainNickName.font = UIFont.boldSystemFont(ofSize: 30)
        self.lblIntroduce.font = UIFont.boldSystemFont(ofSize: 30)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    @IBAction func btnNextPressed(_ sender: Any) {
        if txtNickName.text!.isEmpty || txtIntroduce.text!.isEmpty{
            alert("값을 입력해주세요!", message: "닉네임과 한줄소개를 입력해주세요!")
        }
        performSegue(withIdentifier: "moveToPictureRegister", sender: nil)
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
