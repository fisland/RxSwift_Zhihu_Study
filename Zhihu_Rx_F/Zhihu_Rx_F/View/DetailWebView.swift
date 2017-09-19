//
//  DetailWebView.swift
//  Zhihu_Rx_F
//
//  Created by Fisland_Z on 2017/9/19.
//  Copyright © 2017年 Zehuihong. All rights reserved.
//

import UIKit
import Then

class DetailWebView: UIWebView {
    
    var img = UIImageView().then {
        $0.frame = CGRect.init(x: 0, y: 0, width: KScreenW, height: 200)
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    var maskImg = UIImageView().then {
        $0.frame = CGRect.init(x: 0, y: 100, width: KScreenW, height: 100)
        $0.image = UIImage.init(named: "Home_Image_Mask")
    }
    var titleLab = UILabel().then {
        $0.frame = CGRect.init(x: 15, y: 150, width: KScreenW - 30, height: 26)
        $0.font = UIFont.boldSystemFont(ofSize: 21)
        $0.numberOfLines = 2
        $0.textColor = UIColor.white
    }
    var imgLab = UILabel().then {
        $0.frame = CGRect.init(x: 15, y: 180, width: KScreenW - 30, height: 16)
        $0.font = UIFont.systemFont(ofSize: 10)
        $0.textAlignment = .right
        $0.textColor = UIColor.white
    }
    var previousLab = UILabel().then {
        $0.frame = CGRect.init(x: 15, y: -30, width: KScreenW - 30, height: 20)
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.text = "载入上一篇"
        $0.textAlignment = .center
        $0.textColor = UIColor.white
    }
    var nextLab = UILabel().then {
        $0.frame = CGRect.init(x: 15, y: KScreenH + 30, width: KScreenW - 30, height: 20)
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.text = "载入下一篇"
        $0.textAlignment = .center
        $0.textColor = UIColor.colorFromHex(0x777777)
    }
    var waitView = UIView().then {
        $0.backgroundColor = UIColor.white
        $0.frame = CGRect.init(x: 0, y: 0, width: KScreenW, height: KScreenH)
        let acv = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
        acv.center = $0.center
        acv.startAnimating()
        $0.addSubview(acv)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        img.addSubview(maskImg)
        scrollView.addSubview(img)
        scrollView.addSubview(titleLab)
        scrollView.addSubview(imgLab)
        scrollView.addSubview(previousLab)
        scrollView.addSubview(nextLab)
        scrollView.addSubview(waitView)
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
