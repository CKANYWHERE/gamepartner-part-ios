//
//  BoardListVC.swift
//  GamePartner
//
//  Created by 민창경 on 2020/11/10.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources
import RxViewController
import Kingfisher

class BoardListVC: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    

    let viewModel = BoardViewModel()
    let disposeBag = DisposeBag()
    let sendBoardView = SendBoardView()
    
    lazy var spinner = MyIndicator(frame:CGRect(x: 0, y: 0, width: 50, height: 50)
                                   ,x: Int(view.frame.width)/2
                                   ,y: Int(view.frame.height)/2)
    let sendMessage = UIButton()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailFriend" {
            let vc = segue.destination as? DetailFriendVC
            if let index = sender as? FriendModel {
                vc?.viewModel = FriendDetialViewModel(model:index)
            }
        }
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        self.view.addSubview(self.spinner)
        tableView.separatorColor = .clear
        tableView.refreshControl = UIRefreshControl()
        setSendFriendButton()
        
        
        let firstLoad = rx.viewWillAppear
            .take(1)
            .map { _ in () }

        let reload = tableView.refreshControl?.rx
            .controlEvent(.valueChanged)
            .map { _ in () } ?? Observable.just(())
        
        Observable.merge([firstLoad,reload])
            .bind(to: viewModel.fetchBoardApi)
            .disposed(by: disposeBag)
        
        viewModel.fetchBoardList
            .bind(to: tableView.rx.items(cellIdentifier: "cell",cellType: BoardTableCell.self)){ index, board, cell in
                let imgUrl = URL(string: "https://storage.googleapis.com/gamepartner/" + board.imgPath)
                //print("cell date: " + board.date)
               
                cell.imgView?.isUserInteractionEnabled = true
                cell.imgView?.layer.cornerRadius = (cell.imgView?.frame.height)! / 2
                cell.imgView?.layer.masksToBounds = true
                cell.imgView?.contentMode = .scaleAspectFill
                
                let split = board.date.components(separatedBy: " ")
                let date = split[0].components(separatedBy: "-")
                let hour = split[1].components(separatedBy: ":")
                
                cell.imgView.kf.setImage(with: imgUrl)
                cell.lblTitle.text = board.title
                cell.lblSubtitle.text = board.nickName + ", " + board.favoritGame + ", " + "\(board.age)"
                cell.lblDate.text = date[1]+"월 "+date[2]+"일 " + hour[0]+"시 " + hour[1]+"분"
                
            }
            .disposed(by:disposeBag)
        
        viewModel.activated
            .do(onNext:{_ in self.tableView.refreshControl?.endRefreshing()})
            .bind(to: spinner.rx.isHidden)
            .disposed(by: disposeBag)
        
        
        tableView.rx.modelSelected(BoardModel.self)
            .subscribe(onNext:{item in
                if item.userId != ""{
                    let friendModel = FriendModel(name: item.nickName, sex: item.sex
                                                  , introduce: item.title, favoritGame: item.favoritGame, imgUrl: item.imgPath
                                                  , friendType: "sendWantTo", age: "\(item.age)", userId: item.userId)
                    self.performSegue(withIdentifier: "showDetailFriend", sender: friendModel)
                }
            })
            .disposed(by: disposeBag)
        
        sendMessage.rx.tap
            .do(onNext: {[weak self] in
                UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                    self?.sendMessage.alpha = 0.5
                }, completion: nil)
            })
            .do(onNext: {[weak self] in
                UIView.animate(withDuration: 0.2, delay: 0.0,options: UIView.AnimationOptions.curveEaseOut, animations: {
                    self?.sendMessage.alpha = 1.0
                }, completion: nil)
            })
            .subscribe(onNext:{[weak self] in
                self?.sendBoardView.modalPresentationStyle = .overCurrentContext
                self?.present(self!.sendBoardView, animated: true ,completion: nil)
            })
            .disposed(by: disposeBag)
        
    }
    
    func setSendFriendButton(){
        sendMessage.setTitle("요청 띄우기", for: .normal)
        sendMessage.setTitleColor(.white, for:.normal)
        sendMessage.setImage(#imageLiteral(resourceName: "sendicon.png"),for:.normal)
        sendMessage.imageView?.contentMode = .scaleAspectFit
        //button.contentHorizontalAlignment = .center
        sendMessage.semanticContentAttribute = .forceRightToLeft
        sendMessage.backgroundColor = .systemBlue
        sendMessage.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        sendMessage.layer.cornerRadius = 20
    
        
        self.view.addSubview(sendMessage)
        
        sendMessage.translatesAutoresizingMaskIntoConstraints = false
        sendMessage.centerXAnchor.constraint(equalTo:view.centerXAnchor)
                .isActive = true
        sendMessage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
                .isActive = true
        sendMessage.heightAnchor.constraint(equalToConstant: 50)
                .isActive = true
        sendMessage.widthAnchor.constraint(equalToConstant: view.bounds.width - 20)
                .isActive = true
        
        
    }
    
}
