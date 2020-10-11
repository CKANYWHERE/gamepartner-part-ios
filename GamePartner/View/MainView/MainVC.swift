//
//  MainVC.swift
//  GamePartner
//
//  Created by 민창경 on 2020/08/19.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class MainVC: UITabBarController, ViewModelBindableType {
    var viewModel: MainViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        
        print("hello")
        
        
        
    }
}
