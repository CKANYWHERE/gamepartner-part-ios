//
//  RegisterBasicVC.swift
//  GamePartner
//
//  Created by 민창경 on 2020/08/19.
//

import UIKit

class RegisterBaiscVC: UIViewController {
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblGuide: UILabel!
    @IBOutlet weak var txtId: UITextField!
    @IBOutlet weak var txtPw: UITextField!
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animate()
      
    }
 
    @IBAction func btnNextPressed(_ sender: Any) {
        performSegue(withIdentifier: "moveToSexRegister", sender: nil)
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
}