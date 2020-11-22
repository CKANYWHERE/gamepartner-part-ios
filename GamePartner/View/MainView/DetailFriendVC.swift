//
//  DetailFriendVC.swift
//  GamePartner
//
//  Created by 민창경 on 2020/11/01.
//


import UIKit
import MessageUI
import RxCocoa
import RxSwift
import RxDataSources
import RxViewController
import RxKingfisher

class DetailFriendVC:UIViewController{
  
    @IBOutlet weak var lblNickName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblFavoritGame: UILabel!
    @IBOutlet weak var imgSexType: UIImageView!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblIntroduce: UILabel!
    
    lazy var spinner = MyIndicator(frame:CGRect(x: 0, y: 0, width: 50, height: 50)
                                   ,x: Int(view.frame.width)/2
                                   ,y: Int(view.frame.height)/2)
    let chatButton = UIButton()
    let dialButton = UIButton()
    let acceptButton = UIButton()
    let declineButton = UIButton()
    let sendFriendButton = UIButton()
    let waitLabel = UILabel()
    let alertView = UIAlertController()
    
    var viewModel:FriendDetialViewModel!
    let disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let friendInfo = viewModel else { return }
        
        friendInfo.imgUrlTxt
            .subscribe(onNext: {[weak self] url in
                self?.imgProfile.kf.setImage(with: URL(string: "https://storage.googleapis.com/gamepartner/" + url))
            })
            .disposed(by: disposeBag)
        
        friendInfo.ageTxt
            .bind(to: lblAge.rx.text)
            .disposed(by: disposeBag)
        
        friendInfo.favoritGameTxt
            .bind(to: lblFavoritGame.rx.text)
            .disposed(by: disposeBag)
        
        friendInfo.introduceTxt
            .bind(to: lblIntroduce.rx.text)
            .disposed(by: disposeBag)
        
        friendInfo.nickNameTxt
            .bind(to: lblNickName.rx.text)
            .disposed(by: disposeBag)
        
        friendInfo.sexTypeImg
            .bind(to: imgSexType.rx.image)
            .disposed(by: disposeBag)
        
        friendInfo.friendType
            .subscribe(onNext: {[weak self] type in
                if type == "wantedFrom"{
                    self?.setDecideButton()
                }
                else if type == "wantedTo"{
                    self?.setWaitLabel()
                }
                else if type == "friend"{
                    self?.setChatButton()
                }
                else if type == "sendWantTo"{
                    self?.setSendFriendButton()
                }
                
            })
            .disposed(by: disposeBag)
    
        
        friendInfo.moveToMainPage
            .asObservable()
            .subscribe(onNext: {[weak self] in
                //print("move to main")
                self?.navigationController?.popToRootViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        friendInfo.activated
            .map({ $0 })
            .bind(to: spinner.rx.isHidden)
            .disposed(by: disposeBag)
        
        chatButton.rx.tap
            .do(onNext: {[weak self] in
                UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                    self?.chatButton.alpha = 0.5
                }, completion: nil)
            })
            .do(onNext: {[weak self] in
                UIView.animate(withDuration: 0.2, delay: 0.0,options: UIView.AnimationOptions.curveEaseOut, animations: {
                    self?.chatButton.alpha = 1.0
                }, completion: nil)
            })
            .bind(to: friendInfo.btnChatClicked)
            .disposed(by: disposeBag)
        
        acceptButton.rx.tap
            .do(onNext: {[weak self] in
                UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                    self?.acceptButton.alpha = 0.5
                }, completion: nil)
            })
            .do(onNext: {[weak self] in
                UIView.animate(withDuration: 0.2, delay: 0.0,options: UIView.AnimationOptions.curveEaseOut, animations: {
                    self?.acceptButton.alpha = 1.0
                }, completion: nil)
            })
            .bind(to: friendInfo.btnAcceptClicked)
            .disposed(by: disposeBag)
            
        declineButton.rx.tap
            .do(onNext: {[weak self] in
                UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                    self?.declineButton.alpha = 0.5
                }, completion: nil)
            })
            .do(onNext: {[weak self] in
                UIView.animate(withDuration: 0.2, delay: 0.0,options: UIView.AnimationOptions.curveEaseOut, animations: {
                    self?.declineButton.alpha = 1.0
                }, completion: nil)
            })
            .bind(to: friendInfo.btnDeclineCliked)
            .disposed(by: disposeBag)
        
        sendFriendButton.rx.tap
            .do(onNext: {[weak self] in
                UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                    self?.sendFriendButton.alpha = 0.5
                }, completion: nil)
            })
            .do(onNext: {[weak self] in
                UIView.animate(withDuration: 0.2, delay: 0.0,options: UIView.AnimationOptions.curveEaseOut, animations: {
                    self?.sendFriendButton.alpha = 1.0
                }, completion: nil)
            })
            .subscribe(onNext: {[weak self] in
                let composeViewController = MFMessageComposeViewController()
                self?.present(composeViewController, animated: true, completion:nil)
            })
            .disposed(by: disposeBag)
        
        dialButton.rx.tap
            .do(onNext: {[weak self] in
                UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                    self?.dialButton.alpha = 0.5
                }, completion: nil)
            })
            .do(onNext: {[weak self] in
                UIView.animate(withDuration: 0.2, delay: 0.0,options: UIView.AnimationOptions.curveEaseOut, animations: {
                    self?.dialButton.alpha = 1.0
                }, completion: nil)
            })
            .bind(to: friendInfo.btnDialClicked)
            .disposed(by: disposeBag)
       
    }
    
    
    func setSendFriendButton(){
        sendFriendButton.setTitle("친구요청 보내기", for: .normal)
        sendFriendButton.setTitleColor(.white, for:.normal)
        sendFriendButton.setImage(#imageLiteral(resourceName: "sendicon.png"),for:.normal)
        sendFriendButton.imageView?.contentMode = .scaleAspectFit
        //button.contentHorizontalAlignment = .center
        sendFriendButton.semanticContentAttribute = .forceRightToLeft
        sendFriendButton.backgroundColor = .systemBlue
        sendFriendButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        sendFriendButton.layer.cornerRadius = 20
    
        
        self.view.addSubview(sendFriendButton)
        
        sendFriendButton.translatesAutoresizingMaskIntoConstraints = false
        sendFriendButton.centerXAnchor.constraint(equalTo:view.centerXAnchor)
                .isActive = true
        sendFriendButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
                .isActive = true
        sendFriendButton.heightAnchor.constraint(equalToConstant: 50)
                .isActive = true
        sendFriendButton.widthAnchor.constraint(equalToConstant: view.bounds.width - 20)
                .isActive = true
        
        
    }
    
    func setChatButton(){
        chatButton.setTitle("메시지 보내기", for: .normal)
        chatButton.setTitleColor(.white, for:.normal)
        chatButton.backgroundColor = .systemBlue
        chatButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        chatButton.layer.cornerRadius = 20
    
        self.view.addSubview(chatButton)
        
        chatButton.translatesAutoresizingMaskIntoConstraints = false
        chatButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 19)
                .isActive = true
        chatButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
                .isActive = true
        chatButton.heightAnchor.constraint(equalToConstant: 50)
                .isActive = true
        chatButton.widthAnchor.constraint(equalToConstant: (view.bounds.width/2 - 30))
                .isActive = true
        
        dialButton.setTitle("전화하기", for: .normal)
        dialButton.setTitleColor(.white, for:.normal)
        dialButton.backgroundColor = .systemPink
        dialButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        dialButton.layer.cornerRadius = 20
    
        self.view.addSubview(dialButton)
        
        dialButton.translatesAutoresizingMaskIntoConstraints = false
        dialButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -19)
                .isActive = true
        dialButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
                .isActive = true
        dialButton.heightAnchor.constraint(equalToConstant: 50)
                .isActive = true
        dialButton.widthAnchor.constraint(equalToConstant: (view.bounds.width/2 - 30))
                .isActive = true
        
    }
    
    func setDecideButton(){
        acceptButton.setTitle("수락하기", for: .normal)
        acceptButton.setTitleColor(.white, for:.normal)
        acceptButton.backgroundColor = .systemBlue
        acceptButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        acceptButton.layer.cornerRadius = 20
    
        self.view.addSubview(acceptButton)
        
        acceptButton.translatesAutoresizingMaskIntoConstraints = false
        acceptButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 19)
                .isActive = true
        acceptButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
                .isActive = true
        acceptButton.heightAnchor.constraint(equalToConstant: 50)
                .isActive = true
        acceptButton.widthAnchor.constraint(equalToConstant: (view.bounds.width/2 - 30))
                .isActive = true
        
        declineButton.setTitle("거절하기", for: .normal)
        declineButton.setTitleColor(.white, for:.normal)
        declineButton.backgroundColor = .systemPink
        declineButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        declineButton.layer.cornerRadius = 20
    
        self.view.addSubview(declineButton)
        
        declineButton.translatesAutoresizingMaskIntoConstraints = false
        declineButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -19)
                .isActive = true
        declineButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
                .isActive = true
        declineButton.heightAnchor.constraint(equalToConstant: 50)
                .isActive = true
        declineButton.widthAnchor.constraint(equalToConstant: (view.bounds.width/2 - 30))
                .isActive = true
    }
    
    func setWaitLabel(){
        waitLabel.text = "친구요청 대기중"
        waitLabel.textColor = .white
        waitLabel.backgroundColor = .systemBlue
        waitLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        waitLabel.layer.cornerRadius = 20
        waitLabel.layer.masksToBounds = true
        
        waitLabel.textAlignment = .center
        
        self.view.addSubview(waitLabel)
        
        waitLabel.translatesAutoresizingMaskIntoConstraints = false
        waitLabel.centerXAnchor.constraint(equalTo:view.centerXAnchor)
                .isActive = true
        waitLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
                .isActive = true
        waitLabel.heightAnchor.constraint(equalToConstant: 50)
                .isActive = true
        waitLabel.widthAnchor.constraint(equalToConstant: view.bounds.width - 10)
                .isActive = true
    }
    
}
