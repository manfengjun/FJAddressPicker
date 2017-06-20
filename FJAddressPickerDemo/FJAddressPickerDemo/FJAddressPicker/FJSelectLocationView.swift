//
//  FJSlectLocationView.swift
//  FJAddressPickerDemo
//
//  Created by jun on 2017/6/20.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
fileprivate let FJButtonCVCellIdentifier = "fJButtonCVCell"
fileprivate let FJAddressTVCellIdentifier = "fJAddressTVCell"

class FJSelectLocationView: UIView {
    
    /// 菜单列表
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame:CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.yellow
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(FJButtonCVCell.classForCoder(), forCellWithReuseIdentifier: FJButtonCVCellIdentifier)
        
        collectionView.delegate = self
        
        collectionView.dataSource = self
        return collectionView

    }()
    /// 数据列表
    fileprivate lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(FJAddressTVCell.classForCoder(), forCellReuseIdentifier: FJAddressTVCellIdentifier)
        tableView.backgroundColor = UIColor.orange
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        return tableView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    func setupUI() {
        addSubview(collectionView)
        addSubview(tableView)
    }
    func setupConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.height.equalTo(300)
            make.leftMargin.rightMargin.bottomMargin.equalTo(0)
        }
        collectionView.snp.makeConstraints { (make) in
            make.bottomMargin.equalTo(tableView)
            make.leftMargin.rightMargin.equalTo(0)
            make.height.equalTo(30)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension FJSelectLocationView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FJButtonCVCellIdentifier, for: indexPath) as! FJButtonCVCell
//        cell.backgroundColor = UIColor.purple
        cell.titleLabel.text = "\(indexPath.row)"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 30)
    }
}
extension FJSelectLocationView:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FJAddressTVCellIdentifier, for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = "\(indexPath.row)"
//        cell.backgroundColor = UIColor.purple
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
