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

class MainVC: UIViewController{
    
    let viewModel = FriendViewModel()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    

    private lazy var dataSource = RxTableViewSectionedReloadDataSource<FriendInfoSection>(
        configureCell: { (_, tv, indexPath, element) in
            let cell = tv.dequeueReusableCell(withIdentifier: "cell") as! MainTableCell
            
            cell.imgProfile.image = element.image
            cell.imgProfile.layer.cornerRadius = cell.imgProfile.frame.height/2
            cell.imgProfile.layer.borderWidth = 1
            cell.imgProfile.layer.masksToBounds = true
            
            cell.lblNickName.text = element.nickName
            cell.lblAge.text = String(element.age ?? 0)
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
        
        
        viewModel.friendList
            .bind(to: tableView.rx.items(dataSource:self.dataSource))
            .disposed(by: disposeBag)
            
    }
    
}
