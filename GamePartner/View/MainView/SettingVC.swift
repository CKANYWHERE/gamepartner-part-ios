//
//  SettingVC.swift
//  GamePartner
//
//  Created by 민창경 on 2020/11/16.
//

import UIKit
import RealmSwift
import Kingfisher

class SettingVC : UIViewController{
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnOpenSource: UIButton!
    @IBOutlet weak var btnPrivateInfo: UIButton!
    @IBOutlet weak var btnUsing: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setImage()
    }
    
    func setImage(){
        let realm = try! Realm()
        let users = realm.objects(UserModel.self)
        let user = users.first
        let imgUrl = URL(string: "https://storage.googleapis.com/gamepartner/" + user!.id)
        imgView.kf.setImage(with: imgUrl)
    }
    
    func setUI(){
        btnOpenSource.setTitleColor(.white, for:.normal)
        btnOpenSource.backgroundColor = .systemBlue
        btnOpenSource.layer.cornerRadius = 20
        btnOpenSource.widthAnchor.constraint(equalToConstant: view.bounds.width - 20)
                .isActive = true
        
        btnPrivateInfo.setTitleColor(.white, for:.normal)
        btnPrivateInfo.backgroundColor = .systemBlue
        btnPrivateInfo.layer.cornerRadius = 20
        btnPrivateInfo.widthAnchor.constraint(equalToConstant: view.bounds.width - 20)
                .isActive = true
        
        btnUsing.setTitleColor(.white, for:.normal)
        btnUsing.backgroundColor = .systemBlue
        btnUsing.layer.cornerRadius = 20
        btnUsing.widthAnchor.constraint(equalToConstant: view.bounds.width - 20)
                .isActive = true
    }
    
}
