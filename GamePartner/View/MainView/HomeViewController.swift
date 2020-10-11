//
//  HomeViewController.swift
//  GamePartner
//
//  Created by 문효재 on 2020/10/11.
//

import UIKit
import RxCocoa
import RxSwift
import NSObject_Rx

class HomeViewController: UIViewController, ViewModelBindableType{
    var viewModel: HomeViewModel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
            
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
