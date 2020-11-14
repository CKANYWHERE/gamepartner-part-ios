//
//  SendBoardView.swift
//  GamePartner
//
//  Created by 민창경 on 2020/11/13.
//

import Foundation
import UIKit

class SendBoardView: UIViewController{
    
    var lblTitle = UILabel()
    var subView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray4
        view.isOpaque = false
        
        subView.clipsToBounds = true
        subView.layer.cornerRadius = 10
        subView = UIView(frame:CGRect(x: view.frame.width/2
                                      , y:(view.frame.height)/2
                                      , width: 500
                                      , height: 500))
        subView.center = .init(x: Int(view.frame.width/2), y: Int(view.frame.height/2))
        subView.backgroundColor = .white
        
        self.view.addSubview(subView)
     
        
        setTitleLbl()
    }
    
    
    func setTitleLbl(){
//        lblTitle.text = "친구요청 대기중"
//        lblTitle.textColor = .white
//        lblTitle.backgroundColor = .systemBlue
//        lblTitle.font = UIFont.boldSystemFont(ofSize: 20)
//
//        lblTitle.layer.cornerRadius = 20
//        lblTitle.layer.masksToBounds = true
//
//        lblTitle.textAlignment = .center
//
//        self.subView.addSubview(lblTitle)
        
//        lblTitle.translatesAutoresizingMaskIntoConstraints = false
//        lblTitle.centerXAnchor.constraint(equalTo:view.centerXAnchor)
//                .isActive = true
////        lblTitle.centerYAnchor.constraint(equalTo:view.centerYAnchor)
////                .isActive = true
//        lblTitle.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
//                .isActive = true
//        lblTitle.heightAnchor.constraint(equalToConstant: 50)
//                .isActive = true
//        lblTitle.widthAnchor.constraint(equalToConstant: view.bounds.width - 10)
//                .isActive = true
    }
    
}
