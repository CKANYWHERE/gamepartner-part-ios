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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initLabel()
    }
    
    override func viewDidLayoutSubviews() {
        animate()
    }
    
    private func initLabel(){
        WelcomeLabel.font = UIFont.boldSystemFont(ofSize: 40)
        WelcomeLabel.adjustsFontSizeToFitWidth = true
        infoLabel1.font = UIFont.systemFont(ofSize: 14)
        infoLabel1.adjustsFontSizeToFitWidth = true
        infoLabel2.font = UIFont.systemFont(ofSize: 14)
        infoLabel2.adjustsFontSizeToFitWidth = true
    }
    
    private func animate(){
        UIView.animate(withDuration: 3,delay: 0, animations: {
            self.infoLabel1.alpha = 1
        })
    }
}

