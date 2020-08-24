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
    
    var imgWoman: UIImage?
    var imgMan: UIImage?
    var imgWomanChecked: UIImage?
    var imgManCheked: UIImage?
    
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
        performSegue(withIdentifier: "moveToBirthdayRegister", sender: nil)
    }
    
    @IBAction func btnRadioAction(_ sender: UIButton) {
        
        if sender == btnWoman{
            btnMan.isSelected = false
            btnWoman.isSelected = true
        }
        
        else if sender == btnMan{
            btnMan.isSelected = true
            btnWoman.isSelected = false
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
    
    private func animate(){
        UIView.animateKeyframes(withDuration: 3.0, delay: 0.0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration:0.3, animations: {
                self.btnNext.alpha = 1.0
            })
        },completion: nil)
    }
}