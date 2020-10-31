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
import RxViewController
import Kingfisher

class MainVC: UIViewController, UIScrollViewDelegate{
    
    let viewModel = FriendViewModel()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<FriendInfoSection>(
        configureCell: { [weak self] (_, tv, indexPath, element) in
            let cell = tv.dequeueReusableCell(withIdentifier: "cell") as! MainTableCell
            let imgUrl = URL(string: "https://storage.googleapis.com/gamepartner/" + element.imgUrl!)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self?.touchToPickPhoto(tapGestureRecognizer:)))
            cell.imgProfile?.addGestureRecognizer(tapGesture)
            cell.imgProfile?.isUserInteractionEnabled = true
            cell.imgProfile?.layer.cornerRadius = (cell.imgProfile?.frame.height)! / 2
            cell.imgProfile?.layer.masksToBounds = true
            cell.imgProfile?.kf.setImage(with: imgUrl)
            cell.imgProfile?.contentMode = .scaleAspectFill
            cell.imgSex?.image = element.imageSex
            
            cell.lblNickName?.text = element.nickName
            
            if element.sex == "W"{
                cell.lblNickName?.textColor = .systemPink
            }
            
            cell.lblIntroduce?.text = element.introduce
            cell.lblGame?.text = element.favoritGame
            
            return cell
        },
        titleForHeaderInSection: { dataSource, sectionIndex in
            return dataSource[sectionIndex].header
        }
    )
    
    @objc func touchToPickPhoto(tapGestureRecognizer: UITapGestureRecognizer){
        let view = tapGestureRecognizer.view as! UIImageView
        let modal = self.storyboard?.instantiateViewController(withIdentifier: "ModalImage") as! ModalImage
        modal.image = view.image
        modal.modalPresentationStyle = .overCurrentContext
        present(modal, animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorColor = .clear
//        tableView.refreshControl = UIRefreshControl()
        
//
//        let firstLoad = rx.viewWillAppear
//            .take(1)
//            .map { _ in () }
//
//        let reload = tableView.refreshControl?.rx
//            .controlEvent(.valueChanged)
//            .map { _ in () } ?? BehaviorSubject.just(())
//            //.do(onNext: { _ in self.tableView.refreshControl?.endRefreshing()})
//
//
//        Observable.merge([firstLoad, reload])
//            .bind(to: viewModel.fetchIndexApi)
//            .disposed(by: disposeBag)
//
        Observable.just(())
            .bind(to: viewModel.fetchIndexApi)
            .disposed(by: disposeBag)

//        tableView.refreshControl?.rx.controlEvent(.valueChanged)
//            .bind(onNext: { [weak self] in
//                _ = self?.viewModel.fetchFriendList
//            })
//            .disposed(by: disposeBag)

//        tableView.rx.itemSelected
        
        viewModel.fetchFriendList
            .bind(to: tableView.rx.items(dataSource:self.dataSource))
            .disposed(by: disposeBag)
        
        viewModel.activated
            .map({ $0 })
            .bind(to: spinner.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
}
