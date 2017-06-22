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
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scrollContentView: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = Bundle.main.loadNibNamed("FJSelectLocationView", owner: self, options: nil)?.first as! UIView
        contentView.frame = self.bounds
        addSubview(contentView)
        awakeFromNib()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    /// 菜单列表
    func setupCollectionView() {
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FJButtonCVCell.classForCoder(), forCellWithReuseIdentifier: FJButtonCVCellIdentifier)
    }
    
    fileprivate var level:Int = 1
    fileprivate var parent_id = 0
    /// 已选数组
    fileprivate var itemArray:[FJAddressModel] = []
    
    /// 地址数组

    fileprivate var totaldataArray:[[FJAddressModel]] = []


    /// 地址列表
    fileprivate var tableViews:[UITableView] = []
    fileprivate var scrollView:UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 41, width: SCREEN_WIDTH, height: 300))
        scrollView.backgroundColor = UIColor.red
        scrollView.contentSize = CGSize(width: SCREEN_WIDTH, height: 300)
        return scrollView
    }()
    func setupTableView() {
        let tableView = UITableView(frame: CGRect(x: SCREEN_WIDTH*CGFloat(tableViews.count), y: 0, width: SCREEN_WIDTH, height: 300), style: .plain)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(FJAddressTVCell.classForCoder(), forCellReuseIdentifier: FJAddressTVCellIdentifier)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableViews.append(tableView)
        scrollView.addSubview(tableView)
        scrollView.contentSize = CGSize(width: SCREEN_WIDTH*CGFloat(tableViews.count), height: 300)
    }
    func setupUI() {
        addSubview(scrollView)
        setupCollectionView()
        setupTableView()
        totaldataArray.append(FJSQLiteUtils.instance.queryAllProvince())
        tableViews[0].reloadData()
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
        return (itemArray.count == 0) ? 1 : itemArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FJButtonCVCellIdentifier, for: indexPath) as! FJButtonCVCell
        if itemArray.count > 0 {
            cell.model = itemArray[indexPath.row]
            cell.titleLabel.textColor = UIColor.hexStringColor(hex: "#333333")
            if level == indexPath.row + 1 {
                cell.titleLabel.textColor = UIColor.red
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = self.itemArray[indexPath.row]
        level = indexPath.row + 1
//        SJBRequestModel.pull_fetchAddressSection(level: level, parent_id: model.parent_id) { (response, status) in
//            self.dataArray = response as! [FJAddressModel]
//            
//            self.level = model.level + 1
//            self.itemArray[self.level - 2] = model
//            
//            let temmodel = FJAddressModel()
//            temmodel.name = "请选择"
//            self.itemArray.append(temmodel)
//            
//            self.collectionView.reloadData()
////            self.tableView.reloadData()
//        }
        self.itemArray.removeSubrange(Range(indexPath.row..<itemArray.count))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 35)
    }
}
extension FJSelectLocationView:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dataArray = totaldataArray[tableViews.index(of: tableView)!]
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FJAddressTVCellIdentifier, for: indexPath) as! FJAddressTVCell
        cell.selectionStyle = .none
        let dataArray = totaldataArray[tableViews.index(of: tableView)!]
        cell.model = dataArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let dataArray = totaldataArray[tableViews.index(of: tableView)!]
        let model = dataArray[indexPath.row]
        let newDataArray = FJSQLiteUtils.instance.queryData(level: model.level + 1, parent_id: model.id)
        if newDataArray.count > 0 {
            if model.level == tableViews.count {
                totaldataArray[model.level - 1] = newDataArray
            }
            else
            {
                totaldataArray.append(newDataArray)
            }
            setupTableView()
            scrollView.contentOffset = CGPoint(x: SCREEN_WIDTH*CGFloat(level), y: scrollView.contentOffset.y)
        }
        return indexPath
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataArray = totaldataArray[tableViews.index(of: tableView)!]
        let model = dataArray[indexPath.row]
        tableViews[model.level - 1].reloadData()
//        SJBRequestModel.pull_fetchAddressSection(level: model.level + 1, parent_id: model.id) { (response, status) in
//            if status == 1 {
//                if (response as! NSArray).count > 0 {
//                    self.totaldataArray.append(response as! [FJAddressModel])
//                    self.level = model.level + 1
//                    self.itemArray[self.level - 2] = model
//                    
//                    let temmodel = FJAddressModel()
//                    temmodel.name = "请选择"
//                    self.itemArray.append(temmodel)
//                    self.setupTableView()
//                    self.collectionView.reloadData()
//                    self.tableViews[self.level - 1].reloadData()
//
//                }
//                else
//                {
//                    self.itemArray[self.level - 1] = model
//                    self.collectionView.reloadData()
//                }
//            }
//            else
//            {
//                
//            }
//            
//        }
        

    }
//    func getData() -> [FJAddressModel] {
//        
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.01
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.01
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
}
