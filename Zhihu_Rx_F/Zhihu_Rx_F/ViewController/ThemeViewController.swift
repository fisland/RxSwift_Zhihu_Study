//
//  ThemeViewController.swift
//  Zhihu_Rx_F
//
//  Created by Fisland_Z on 2017/9/20.
//  Copyright © 2017年 Zehuihong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Kingfisher
import SwiftDate
import Moya

class ThemeViewController: UIViewController {

    let provider = RxMoyaProvider<ApiManager>()
    let dispose = DisposeBag()
    let menuView = MenuViewController.shareInstance
    let listModelArr = Variable([StoryModel]())
    var refreshView : RefreshView?
    let offHeadY = Variable(0.0)
    
    var id = 0

    var menuBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getData()
        addRefresh()
        offHeadY.asObservable()
            .subscribe(onNext:{ offy in
                self.headImg.frame.origin.y = -64
                self.headImg.frame.size.height = 64 - CGFloat.init(offy)
            })
            .disposed(by: dispose)
        
        menuBtn.rx.tap
            .subscribe(onNext:{
                self.menuView.showView = !self.menuView.showView
            })
                .disposed(by: dispose)

        NotificationCenter.default.rx
            .notification(Notification.Name.init(rawValue: "setTheme"))
            .subscribe(onNext:{ notifi in
                if let model = notifi.userInfo?["model"] as? ThemeModel{
                    self.title = model.name
                    self.headImg.kf.setImage(with: URL.init(string: (model.thumbnail)!))
                    self.id = model.id!
                    self.getData()
                }

            })
            .disposed(by: dispose)
        
        tableView.rx.setDelegate(self)
            .disposed(by: dispose)
        
        tableView.rx
            .modelSelected(StoryModel.self)
            .subscribe(onNext:{model in
                self.tableView.deselectRow(at: self.tableView.indexPathForSelectedRow!, animated: true)
                let detailVc = DetailViewController()
                self.listModelArr.value.forEach({ (model) in
                    detailVc.idArr.append(model.id!)
                })
                detailVc.id = model.id!
                self.navigationController?.pushViewController(detailVc, animated: true)
            })
            .disposed(by: dispose)

        listModelArr
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "ListTableViewCell", cellType: ListTableViewCell.self)){ indexPath, item , cell in
                cell.title.text = item.title
                cell.morepicImg.isHidden = !item.multipic
                if item.images == nil{
                    cell.img.isHidden = true
                    cell.titleRight.constant = 15
                }
                else{
                    cell.img.isHidden = false
                    cell.titleRight.constant = 105
                    cell.img.kf.setImage(with: URL.init(string:(item.images?.first)!))
                }
        }
            .disposed(by: dispose)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ThemeViewController{
    func setupUI(){

        title = UserDefaults.standard.object(forKey: "themeName") as! String?
        id = UserDefaults.standard.object(forKey: "themeNameId") as! Int
        let url = UserDefaults.standard.object(forKey: "themeImgUrl") as! String?
        headImg.kf.setImage(with: URL.init(string: url!))
        
        menuBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 60))
        menuBtn.setImage(UIImage.init(named: "Back_White"), for: .normal)
        menuBtn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -20, bottom: 0, right: 60)
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: menuBtn)
        
        navigationController?.navigationBar.subviews.first?.alpha = 0.0
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        
        
        headImg.frame = CGRect(x: 0, y: -64, width: KScreenW, height: 64)
        tableView.frame = CGRect(x: 0, y: 0, width: KScreenW, height: KScreenH - 64)
        self.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGesture(sender:))))
    }
    
    func panGesture(sender:UIPanGestureRecognizer) {
        menuView.panGesture(pan: sender)
    }
    
    func getData() {
        provider.request(.getThemeDesc(id))
            .mapModel(listModel.self)
            .subscribe(onNext: { listModel in
                self.listModelArr.value = listModel.stories!
                self.tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: true)
                self.refreshView?.endRefresh()

            })
            .disposed(by: dispose)
    }
    
    func addRefresh() {
        refreshView = RefreshView.init(frame: CGRect.init(x: 118, y: -42, width: 40, height: 40))
        refreshView?.backgroundColor = UIColor.clear
        view.addSubview(refreshView!)
    }
    
}
extension ThemeViewController : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= 0 {
            self.offHeadY.value = Double(0.0)
        }
        else{
            self.offHeadY.value = Double(scrollView.contentOffset.y)
            refreshView?.pullToRefresh(progress: (-scrollView.contentOffset.y) / 64)

        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        refreshView?.resetLayer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y <= -64 {
            refreshView?.beginRefresh {
                self.getData()
            }
        }
    }
}
extension ThemeViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}
