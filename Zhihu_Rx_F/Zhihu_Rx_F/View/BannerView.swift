//
//  BannerView.swift
//  Zhihu_Rx_F
//
//  Created by Fisland_Z on 2017/9/19.
//  Copyright © 2017年 Zehuihong. All rights reserved.
//

import UIKit
import Then
import RxSwift
import RxCocoa
import RxDataSources
import Kingfisher

//refreshView加载在bannerview上
class BannerView: UICollectionView {
    let imgUrlArr = Variable([StoryModel]())
    
    let disposeBag = DisposeBag()
    let offY = Variable(0.0)
    let bannerDelegate : BannerDelegate? = nil
    
    override func awakeFromNib() {
        contentOffset.x = KScreenW
        
        imgUrlArr
            .asObservable()
            .bind(to: self.rx.items(cellIdentifier: "BannerCell", cellType: BannerCell.self)){ row, model, cell in
                cell.img.kf.setImage(with: URL.init(string: model.image!))
                cell.imgTitle.text = model.title!
        }
            .addDisposableTo(disposeBag)
        
        rx.setDelegate(self).disposed(by: disposeBag)
        
        offY.asObservable()
            .subscribe(onNext: { offy in
                self.visibleCells.forEach{ cell in
                    let cell = cell as! BannerCell
                    cell.img.frame.origin.y = CGFloat.init(offy)
                    cell.img.frame.size.height = 200 - CGFloat.init(offy)
                }
            })
            .addDisposableTo(disposeBag)
    }
}



extension BannerView : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x == CGFloat.init(imgUrlArr.value.count - 1 ) * KScreenW {
            scrollView.contentOffset.x = KScreenW
        }
        else if scrollView.contentOffset.x == 0{
            scrollView.contentOffset.x = CGFloat.init(imgUrlArr.value.count - 2) * KScreenW
        }
        bannerDelegate?.scrollTo(index: Int(scrollView.contentOffset.x / KScreenW ) - 1)
    }
}


protocol BannerDelegate {
    func selectedItem(model: StoryModel)
    func scrollTo(index: Int)
}
