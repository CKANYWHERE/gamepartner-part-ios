//
//  MainVC.swift
//  GamePartner
//
//  Created by 민창경 on 2020/08/19.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources
import Kingfisher

class MainVC: UIViewController{
    
    let viewModel = FriendViewModel()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    

    private lazy var dataSource = RxTableViewSectionedReloadDataSource<FriendInfoSection>(
        configureCell: { (_, tv, indexPath, element) in
            let cell = tv.dequeueReusableCell(withIdentifier: "cell") as! MainTableCell
            let imgUrl = URL(string: "https://gamepartner.storage.googleapis.com/" + element.imgUrl!)
            
            cell.imgProfile.image = element.image
            cell.imgProfile.layer.cornerRadius = cell.imgProfile.frame.height/2
            cell.imgProfile.layer.masksToBounds = true
            cell.imgProfile.kf.setImage(with: imgUrl)
            cell.imgProfile.contentMode = .scaleAspectFill
            
            cell.imgSex.image = element.imageSex
            
            cell.lblNickName.text = element.nickName
            
            if element.sex == "W"{
                cell.lblNickName.textColor = .systemPink
            }
            
            
            cell.lblIntroduce.text = element.introduce
            cell.lblGame.text = element.favoritGame
            
            return cell
        },
        titleForHeaderInSection: { dataSource, sectionIndex in
            return dataSource[sectionIndex].header
        }
    )
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.rowHeight = 70
        tableView.separatorInset.left = 0
        //self.definesPresentationContext = true
//        
//        let firstLoad = rx.viewWillAppear
//            .take(1)
//            .map { _ in () }
//
//        Observable
//            .bind(to: viewModel.fetchIndexApi)
//            .disposed(by: disposeBag)
//        Observable.just(Void)
//            .bind(to: viewModel.fetchIndexApi)
//
        
        Observable<Void>.just(())
            .bind(to: viewModel.fetchIndexApi)
            .disposed(by: disposeBag)
        
        
        viewModel.fetchFriendList
            .bind(to: tableView.rx.items(dataSource:self.dataSource))
            .disposed(by: disposeBag)
            
    }
    
}
