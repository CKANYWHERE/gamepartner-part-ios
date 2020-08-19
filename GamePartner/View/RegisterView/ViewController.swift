//
//  ViewController.swift
//  GamePartner
//
//  Created by 민창경 on 2020/08/11.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var WelcomeLabel: UILabel!
    @IBOutlet weak var infoLabel1: UILabel!
    @IBOutlet weak var infoLabel2: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initLabel()
    }
 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animate()
      
    }
    
    @IBAction func btnNextPressed(_ sender: Any) {
        performSegue(withIdentifier: "moveToBasicRegister", sender: nil)
    }
    
    private func initLabel(){
        self.WelcomeLabel.font = UIFont.boldSystemFont(ofSize: 40)
        self.WelcomeLabel.adjustsFontSizeToFitWidth = true
        
        self.infoLabel1.font = UIFont.systemFont(ofSize: 14)
        self.infoLabel1.adjustsFontSizeToFitWidth = true
        self.infoLabel1.alpha = 0.0
        
        self.infoLabel2.font = UIFont.systemFont(ofSize: 14)
        self.infoLabel2.adjustsFontSizeToFitWidth = true
        self.infoLabel2.alpha = 0.0
        
        self.btnNext.alpha = 0.0
    }
    

   
    
    private func animate(){
        UIView.animateKeyframes(withDuration: 3.0, delay: 0.0, options: [], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration:0.3, animations: {
                self.infoLabel1.alpha = 1.0
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration:0.4, animations: {
                self.infoLabel2.alpha = 1.0
            })
  
            UIView.addKeyframe(withRelativeStartTime: 0.9, relativeDuration:0.5, animations: {
                self.btnNext.alpha = 1.0
            })
        },completion: nil)
    }
}

