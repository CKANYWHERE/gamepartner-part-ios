//
//  IndicatorView.swift
//  GamePartner
//
//  Created by 민창경 on 2020/11/07.
//

import Foundation
import UIKit

class MyIndicator: UIView {

    let activityIndicator = UIActivityIndicatorView()
    var loadingView: UIView = UIView()
    
    init(frame: CGRect,x: Int, y: Int) {
        super.init(frame: frame)
       
        loadingView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        loadingView.center = .init(x: x, y: y)
     
        loadingView.backgroundColor = UIColor.systemGray5
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = frame
        activityIndicator.color = .blue
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        activityIndicator.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2,
                                           y: loadingView.frame.size.height / 2);
        loadingView.addSubview(activityIndicator)
        addSubview(loadingView)
    }

    required init(coder: NSCoder) {
        fatalError()
    }
}
