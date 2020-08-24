//
//  RegisterDetailVC.swift
//  GamePartner
//
//  Created by 민창경 on 2020/08/22.
//

import UIKit

class RegisterDetailVC : UIViewController{
    
    @IBOutlet weak var lblMainNickName: UILabel!
    @IBOutlet weak var lblIntroduce: UILabel!
    @IBOutlet weak var vTxtIntroduce: UITextView!
    
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
    private func initControl(){
        self.btnNext.alpha = 0.0
        self.lblMainNickName.font = UIFont.boldSystemFont(ofSize: 30)
        self.lblIntroduce.font = UIFont.boldSystemFont(ofSize: 30)
        self.vTxtIntroduce.layer.cornerRadius = 10
    }
    
    @IBAction func btnNextPressed(_ sender: Any) {
        performSegue(withIdentifier: "moveToPictureRegister", sender: nil)
    }
    
    private func animate(){
        UIView.animateKeyframes(withDuration: 3.0, delay: 0.0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration:0.3, animations: {
                self.btnNext.alpha = 1.0
            })
        },completion: nil)
    }
}
