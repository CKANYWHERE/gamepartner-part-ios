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
    lazy var spinner = MyIndicator(frame:CGRect(x: 0, y: 0, width: 50, height: 50)
                                   ,x: Int(view.frame.width)/2
                                   ,y: Int(view.frame.height)/2)
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        self.view.addSubview(self.spinner)
        tableView.separatorColor = .clear
        tableView.refreshControl = UIRefreshControl()
       
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
                print("cell date: " + board.date)
               
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
        
        
    }
    
}
