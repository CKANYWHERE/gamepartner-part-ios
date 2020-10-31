//
//  ModalImage.swift
//  GamePartner
//
//  Created by 민창경 on 2020/10/31.
//

import Foundation
import UIKit

class ModalImage: UIViewController{
    var image: UIImage!
    
    @IBOutlet weak var btnCancle: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var subView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subView.clipsToBounds = true
        subView.layer.cornerRadius = 10
        //subView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        
        imgView.image = image
        btnCancle.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }
    
    @objc func dismissView(){
        dismiss(animated: false, completion: nil)
    }
}
