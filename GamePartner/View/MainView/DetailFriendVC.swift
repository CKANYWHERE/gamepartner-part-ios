//
//  DetailFriendVC.swift
//  GamePartner
//
//  Created by 민창경 on 2020/11/01.
//


import UIKit
import RxCocoa
import RxSwift
import RxDataSources
import RxViewController
import RxKingfisher

class DetailFriendVC:UIViewController{
    
    @IBOutlet weak var lblNickName: UILabel!
    @IBOutlet weak var imgSexType: UIImageView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblFavoritGame: UILabel!
    @IBOutlet weak var lblIntroduce: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    
    let chatButton = UIButton()
    let acceptButton = UIButton()
    let declineButton = UIButton()
    let waitLabel = UILabel()
    
    var viewModel:FriendDetialViewModel!
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let friendInfo = viewModel else { return }
        
        friendInfo.imgUrlTxt
            .subscribe(onNext: {url in
                self.imgProfile.kf.setImage(with: URL(string: "https://storage.googleapis.com/gamepartner/" + url))
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
            .subscribe(onNext: { type in
                if type == "wantedFrom"{
                    //self.btnChat.setTitle("친구수락", for: .normal)
                }
                else if type == "wantedTo"{
                    //self.btnChat.isEnabled = false
                    //self.btnChat.isHidden = true
                }
                else if type == "friend"{
                    self.setChatButton()
                }
                
            })
            .disposed(by: disposeBag)
    
        
//        btnChat.rx.tap
//            .bind(to: friendInfo.btnChatClicked)
//            .disposed(by: disposeBag)
            
    }
    
    func setChatButton(){
        chatButton.setTitle("채팅하기", for: .normal)
        chatButton.setTitleColor(.white, for:.normal)
        chatButton.backgroundColor = .systemBlue
        self.view.addSubview(chatButton)
        
        chatButton.translatesAutoresizingMaskIntoConstraints = false
        chatButton.centerXAnchor.constraint(equalTo:view.centerXAnchor)
                .isActive = true
        chatButton.centerYAnchor.constraint(equalTo:view.centerYAnchor)
                .isActive = true
        chatButton.heightAnchor.constraint(equalToConstant: 200)
                .isActive = true
        chatButton.widthAnchor.constraint(equalToConstant: 200)
                .isActive = true
        
    }
    
    func setDecideButton(){
        
    }
    
    func setWaitLabel(){
        
    }
    
}
