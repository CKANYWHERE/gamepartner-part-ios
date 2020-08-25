//
//  RegisterBasicVC.swift
//  GamePartner
//
//  Created by 민창경 on 2020/08/19.
//

import UIKit

class RegisterBaiscVC: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblGuide: UILabel!
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
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animate()
      
    }
 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func btnNextPressed(_ sender: Any) {
        if txtId.text!.isEmpty || txtPw.text!.isEmpty{
            alert("값을 입력해주세요!", message: "ID와 PW를 입력해주세요!")
        }else{
            performSegue(withIdentifier: "moveToSexRegister", sender: nil)
        }
    }
    
    private func initControl(){
        self.lblGuide.font = UIFont.boldSystemFont(ofSize: 30)
        self.txtId.layer.cornerRadius = 50
        self.txtPw.layer.cornerRadius = 50
        self.btnNext.alpha = 0.0
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
