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

class MainVC: UITabBarController {
    
    @IBOutlet weak var tableView: UITableView!
 
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, FriendInfo>>(
        configureCell: { (_, tv, indexPath, element) in
            let cell = tv.dequeueReusableCell(withIdentifier: "cell")!
            //cell.textLabel?.text = element.
            //cell.
            
            return cell
        },
        titleForHeaderInSection: { dataSource, sectionIndex in
            return dataSource[sectionIndex].model
        }
    )
    override func viewDidLoad() {
        super.viewDidLoad()


    }
}
