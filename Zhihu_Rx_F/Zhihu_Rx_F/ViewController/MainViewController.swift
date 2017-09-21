//
//  MainViewController.swift
//  Zhihu_Rx_F
//
//  Created by Fisland_Z on 2017/9/20.
//  Copyright © 2017年 Zehuihong. All rights reserved.
//

import UIKit
import Kingfisher
import Moya
import RxSwift

class MainViewController: UITabBarController {

    let provider = RxMoyaProvider<ApiManager>()
    let launchView = UIImageView().then{
        $0.frame =  CGRect.init(x: 0, y: 0, width: KScreenW, height: KScreenH)
        $0.alpha = 0.99
        $0.backgroundColor = UIColor.black
    }
    let dispose = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(launchView)
        
        provider
            .request(.getLauchImg)
            .mapModel(LaunchModel.self)
            .subscribe(onNext: { model in
                if let imgModel = model.creatives?.first{
                    self.launchView.kf.setImage(with: URL.init(string: imgModel.url!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (_, _, _, _) in
                        UIView.animate(withDuration: 1.5, animations: {
                            self.launchView.alpha = 1.0
                        }, completion: { (_) in
                            UIView.animate(withDuration: 0.3, animations: {
                                self.launchView.alpha = 0
                            }, completion: { (_) in
                                self.launchView.removeFromSuperview()
                            })
                        })
                    })
                }
                else{
                    self.launchView.removeFromSuperview()
                }
            })
            .disposed(by: dispose)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
