//
//  RegisterBirthVC.swift
//  GamePartner
//
//  Created by 민창경 on 2020/08/22.
//

import UIKit

class RegisterBirthVC : UIViewController{
    
    @IBOutlet weak var lblMain: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var paramId:String!
    var paramPw:String!
    var paramSex:String!
    
    var age:Int!
    var birthDay:String!
    
    @IBAction func changeDatePicker(_ sender: Any) {
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination
        guard let rvc = dest as? RegisterGameVC else {
            return
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        birthDay = formatter.string(from: datePicker.date)
        
        print(formatter.string(from: datePicker.date))
        
        let formatYear = DateFormatter()
        formatYear.dateFormat = "YYYY"
        let birthYear: Int? = Int(formatYear.string(from: datePicker.date))
        let currentYear: Int? = Int(formatYear.string(from: Date()))
        let age = currentYear! - birthYear! + 1

        rvc.paramId = paramId
        rvc.paramPw = paramPw
        rvc.paramSex = paramSex
        rvc.paramAge = age
        rvc.paramBirthDay = birthDay
    }
    
    @IBAction func btnNextPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "moveToGameRegister", sender: nil)
    }
    
    private func initControl(){
        self.btnNext.alpha = 0.0
        self.lblMain.font = UIFont.boldSystemFont(ofSize: 30)
    }
    
    private func animate(){
        UIView.animateKeyframes(withDuration: 3.0, delay: 0.0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration:0.3, animations: {
                self.btnNext.alpha = 1.0
            })
        },completion: nil)
    }
}
