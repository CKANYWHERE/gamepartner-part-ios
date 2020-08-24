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
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animate()
    }
    
    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
    
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
