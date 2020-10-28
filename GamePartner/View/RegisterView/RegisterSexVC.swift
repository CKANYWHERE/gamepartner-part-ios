//
//  RegisterSexVC.swift
//  GamePartner
//
//  Created by 민창경 on 2020/08/22.
//

import UIKit

class RegisterSexVC: UIViewController{
 
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblMain: UILabel!
    @IBOutlet weak var btnWoman: UIButton!
    @IBOutlet weak var btnMan: UIButton!
    @IBOutlet weak var lblSub: UILabel!
    
    var user: UserModel!
        
    var imgWoman: UIImage?
    var imgMan: UIImage?
    var imgWomanChecked: UIImage?
    var imgManCheked: UIImage?
    var sexType:String!
    
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
        guard let rvc = dest as? RegisterBirthVC else {
            return
        }
        
        self.user.sex = sexType
        rvc.user = user
    }
    
    @IBAction func btnNextPressed(_ sender: Any) {
        if btnMan.isSelected == false && btnWoman.isSelected == false{
            alert("값을 입력해주세요!", message: "성별을 선택해주세요!")
        }
        performSegue(withIdentifier: "moveToBirthdayRegister", sender: nil)
    }
    
    @IBAction func btnRadioAction(_ sender: UIButton) {
        
        if sender == btnWoman{
            btnMan.isSelected = false
            btnWoman.isSelected = true
            sexType = "W"
        }
        
        else if sender == btnMan{
            btnMan.isSelected = true
            btnWoman.isSelected = false
            sexType = "M"
        }
        
    }
    
  
    private func initControl(){
        print("init")
        self.lblMain.font = UIFont.boldSystemFont(ofSize: 30)
        self.btnNext.alpha = 0.0
        
        self.imgWoman = UIImage(named: "radio_woman.png")
        self.imgMan = UIImage(named: "radio_man.png")
        self.imgManCheked = UIImage(named: "radio_cheked_man.png")
        self.imgWomanChecked = UIImage(named: "radio_cheked_woman.png")
    }
    
    private func alert(_ title: String, message: String){
        let alert = UIAlertController(title: title, message: message
                                      ,preferredStyle:UIAlertController.Style.alert)
        let action = UIAlertAction(title:"OK", style: UIAlertAction.Style.default,handler: nil)
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    private func animate(){
        UIView.animateKeyframes(withDuration: 3.0, delay: 0.0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration:0.3, animations: {
                self.btnNext.alpha = 1.0
            })
        },completion: nil)
    }
}
