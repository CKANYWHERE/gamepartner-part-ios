//
//  MainVC.swift
//  GamePartner
//
//  Created by 민창경 on 2020/08/19.
//

import RxCocoa
import RxSwift
import RxDataSources
import RxViewController
import Kingfisher
import RealmSwift

class MainVC: UIViewController, UIScrollViewDelegate{
    
    let viewModel = FriendViewModel()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    lazy var spinner = MyIndicator(frame:CGRect(x: 0, y: 0, width: 50, height: 50)
                                   ,x: Int(view.frame.width)/2
                                   ,y: Int(view.frame.height)/2)
    
    @objc func touchToPickPhoto(tapGestureRecognizer: UITapGestureRecognizer){
        let view = tapGestureRecognizer.view as! UIImageView
        let modal = self.storyboard?.instantiateViewController(withIdentifier: "ModalImage") as! ModalImage
        modal.image = view.image
        modal.modalPresentationStyle = .overCurrentContext
        present(modal, animated: false, completion: nil)
    }
    
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

            cell.lblIntroduce?.text = element.introduce
            cell.lblGame?.text = element.favoritGame
            
            return cell
        },
        titleForHeaderInSection: { dataSource, sectionIndex in
            return dataSource[sectionIndex].header
        }
    )
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailFriend" {
            let vc = segue.destination as? DetailFriendVC
            if let index = sender as? FriendModel {
                vc?.viewModel = FriendDetialViewModel(model:index)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorColor = .clear
        self.view.addSubview(self.spinner)

        let firstLoad = rx.viewWillAppear
            .map { _ in () }
        
        Observable.merge(firstLoad)
            .bind(to: viewModel.fetchIndexApi)
            .disposed(by: disposeBag)
        
        viewModel.fetchFriendList
            .bind(to: tableView.rx.items(dataSource:self.dataSource))
            .disposed(by: disposeBag)
       
        viewModel.activated
            .map({ $0 })
            .bind(to: spinner.rx.isHidden)
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(FriendModel.self)
            .subscribe(onNext:{item in
                if item.userId != ""{
                    self.performSegue(withIdentifier: "showDetailFriend", sender: item)
                }
            })
            .disposed(by: disposeBag)
        
    }
    
}
