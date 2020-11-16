//
//  SendBoardView.swift
//  GamePartner
//
//  Created by 민창경 on 2020/11/13.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class SendBoardView: UIViewController, UITextFieldDelegate{
    
    let viewModel = BoardViewModel()
    var disposeBag = DisposeBag()
    var lblTitle = UILabel()
    var txtContent = UITextField()
    var subView = UIView()
    var btnCancle = UIButton()
    var sendMessage = UIButton()
    lazy var spinner = MyIndicator(frame:CGRect(x: 0, y: 0, width: 50, height: 50)
                                   ,x: Int(view.frame.width)/2
                                   ,y: Int(view.frame.height)/2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnCancle.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        setViewUI()
        
        sendMessage.rx.tap
            .do(onNext: {[weak self] in
                UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                    self?.sendMessage.alpha = 0.5
                }, completion: nil)
            })
            .do(onNext: {[weak self] in
                UIView.animate(withDuration: 0.2, delay: 0.0,options: UIView.AnimationOptions.curveEaseOut, animations: {
                    self?.sendMessage.alpha = 1.0
                }, completion: nil)
            })
            .bind(to: viewModel.btnSendCliked)
            .disposed(by: disposeBag)
        
        viewModel.activated
            .bind(to: spinner.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.titleTxt
            .bind(to: txtContent.rx.value)
            .disposed(by: disposeBag)
        
        txtContent.rx.controlEvent([.editingChanged])
               .asObservable().subscribe({ [weak self] _ in
                    self?.viewModel.titleTxt.accept(self?.txtContent.text! ?? "안녕하세요")
               }).disposed(by: disposeBag)
        
    }
    
    @objc func dismissView(){
        dismiss(animated: false, completion: nil)
    }
    
    func setViewUI(){
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.7)
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
     

        lblTitle.text = "내가 원하는 제목으로 요청을 띄워보어요 :)"
        lblTitle.textColor = .systemBlue
        //lblTitle.backgroundColor = .systemBlue
        lblTitle.font = UIFont.boldSystemFont(ofSize: 20)

        lblTitle.layer.cornerRadius = 20
        lblTitle.layer.masksToBounds = true

        lblTitle.textAlignment = .center

        
        self.subView.addSubview(lblTitle)
        

        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.centerXAnchor.constraint(equalTo:subView.centerXAnchor)
                .isActive = true
        lblTitle.centerYAnchor.constraint(equalTo:subView.centerYAnchor, constant: -100.0)
                .isActive = true
        lblTitle.heightAnchor.constraint(equalToConstant: 50)
                .isActive = true
        lblTitle.widthAnchor.constraint(equalToConstant: subView.bounds.width - 10)
                .isActive = true
        
        txtContent.delegate = self
        txtContent.backgroundColor = .systemGray4
        txtContent.borderStyle = .roundedRect
        txtContent.text = "안녕하세요!"

        
        self.subView.addSubview(txtContent)
        
        txtContent.translatesAutoresizingMaskIntoConstraints = false
        txtContent.centerYAnchor.constraint(equalTo: subView.centerYAnchor, constant: +30.0)
            .isActive = true
        txtContent.centerXAnchor.constraint(equalTo: subView.centerXAnchor)
            .isActive = true
        txtContent.heightAnchor.constraint(equalToConstant: 50)
            .isActive = true
        txtContent.widthAnchor.constraint(equalToConstant: 400)
            .isActive = true
        
        
        btnCancle.setTitle("X",for: .normal)
        btnCancle.setTitleColor(.systemBlue, for: .normal)
        btnCancle.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btnCancle.layer.cornerRadius = 20
        self.view.addSubview(btnCancle)
        
        btnCancle.translatesAutoresizingMaskIntoConstraints = false
        btnCancle.centerYAnchor.constraint(equalTo: subView.centerYAnchor, constant: -240.0)
            .isActive = true
        btnCancle.centerXAnchor.constraint(equalTo: subView.centerXAnchor, constant: -200.0)
            .isActive = true
        btnCancle.heightAnchor.constraint(equalToConstant: 15)
            .isActive = true
        btnCancle.widthAnchor.constraint(equalToConstant: 15)
            .isActive = true
        
        sendMessage.setTitle("요청 띄우기", for: .normal)
        sendMessage.setTitleColor(.white, for:.normal)
        sendMessage.setImage(#imageLiteral(resourceName: "sendicon.png"),for:.normal)
        sendMessage.imageView?.contentMode = .scaleAspectFit
        sendMessage.semanticContentAttribute = .forceRightToLeft
        sendMessage.backgroundColor = .systemBlue
        sendMessage.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        sendMessage.layer.cornerRadius = 20
    
        
        self.view.addSubview(sendMessage)
        
        sendMessage.translatesAutoresizingMaskIntoConstraints = false
        sendMessage.centerXAnchor.constraint(equalTo:view.centerXAnchor)
                .isActive = true
        sendMessage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
                .isActive = true
        sendMessage.heightAnchor.constraint(equalToConstant: 50)
                .isActive = true
        sendMessage.widthAnchor.constraint(equalToConstant: view.bounds.width - 20)
                .isActive = true
    }
    

}
