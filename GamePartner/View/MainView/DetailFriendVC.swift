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
import Kingfisher

class DetailFriendVC:UIViewController{
    
    @IBOutlet weak var lblNickName: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblIntroduce: UILabel!
    @IBOutlet weak var lblFriendCount: UILabel!
    @IBOutlet weak var lblFavoritGame: UILabel!
    @IBOutlet weak var imgSexType: UIImageView!
    @IBOutlet weak var btnChat: UIButton!
    
    var friend:FriendModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
        print(friend as Any)
    }
    
}
