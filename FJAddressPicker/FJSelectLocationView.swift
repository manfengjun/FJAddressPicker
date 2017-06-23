//
//  FJSlectLocationView.swift
//  FJAddressPickerDemo
//
//  Created by jun on 2017/6/20.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
fileprivate let FJItemCVCellIdentifier = "fJItemCVCell"
fileprivate let FJAddressTVCellIdentifier = "fJAddressTVCell"

class FJSelectLocationView: UIView {
    /// 当前级
    fileprivate var level:Int = 1
    /// 所有地址数据源
    fileprivate var totaldataArray:[[FJAddressModel]] = []
    /// 地址列表TableView数据源
    fileprivate var tableViews:[UITableView] = []
    /// 菜单列表
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0.5, width: SCREEN_WIDTH, height: 40), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "FJItemCVCell", bundle: Bundle.main), forCellWithReuseIdentifier: FJItemCVCellIdentifier)
        return collectionView
    }()
    
    /// 创建分割线
    ///
    /// - Parameter frame: frame description
    /// - Returns: return value description
    func createLineView(frame:CGRect) -> UIView {
        let view = UIView(frame: frame)
        view.backgroundColor = FJSQLiteUtils.instance.arribute.separationColor
        return view
    }
    
    /// 创建地址选择列表
    func setupTableView() {
        let tableView = UITableView(frame: CGRect(x: SCREEN_WIDTH*CGFloat(tableViews.count), y: 0, width: SCREEN_WIDTH, height: FJSQLiteUtils.instance.arribute.height - 41), style: .plain)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "FJAddressTVCell", bundle: Bundle.main), forCellReuseIdentifier: FJAddressTVCellIdentifier)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableViews.append(tableView)
        scrollView.addSubview(tableView)
        scrollView.contentSize = CGSize(width: SCREEN_WIDTH*CGFloat(tableViews.count), height: FJSQLiteUtils.instance.arribute.height - 41)
    }
    
    /// 多级滚动视图
    fileprivate var scrollView:UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 41, width: SCREEN_WIDTH, height: FJSQLiteUtils.instance.arribute.height - 41))
        scrollView.backgroundColor = UIColor.red
        scrollView.contentSize = CGSize(width: SCREEN_WIDTH, height: FJSQLiteUtils.instance.arribute.height - 41)
        return scrollView
    }()
    
    init() {
        super.init(frame: CGRect(x: 0, y: SCREEN_HEIGHT - FJSQLiteUtils.instance.arribute.height, width: SCREEN_WIDTH, height: FJSQLiteUtils.instance.arribute.height))
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UI界面
extension FJSelectLocationView {
    /// UI初始化
    func setupUI() {
        addSubview(createLineView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 0.5)))
        addSubview(collectionView)
        addSubview(createLineView(frame: CGRect(x: 0, y: 40.5, width: SCREEN_WIDTH, height: 0.5)))
        addSubview(scrollView)
        setupTableView()
        setupData()
    }
    
    /// 初始化数据
    func setupData() {
        //添加第一级数据源
        totaldataArray.append(FJSQLiteUtils.instance.queryAllProvince())
        //默认按钮
        let model = FJAddressModel()
        model.name = "请选择"
        model.level = 1
        FJSQLiteUtils.instance.itemArray.append(model)
        //刷新数据
        tableViews[0].reloadData()
        collectionView.reloadData()
    }
}
extension FJSelectLocationView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FJSQLiteUtils.instance.itemArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FJItemCVCellIdentifier, for: indexPath) as! FJItemCVCell
        if FJSQLiteUtils.instance.itemArray.count > 0 {
            cell.model = FJSQLiteUtils.instance.itemArray[indexPath.row]
            // 选中状态
            cell.titleLabel.textColor = FJSQLiteUtils.instance.arribute.noSelectTextColor
            if level == indexPath.row || indexPath.row == FJSQLiteUtils.instance.itemArray.count - 1 {
                cell.titleLabel.textColor = FJSQLiteUtils.instance.arribute.selectTextColor
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let model = FJSQLiteUtils.instance.itemArray[indexPath.row]
//        if model.level == indexPath.row + 1 {
//            return
//        }
        // 选择低一级的移除数据和列表
        totaldataArray.removeSubrange(Range(indexPath.row + 1..<FJSQLiteUtils.instance.itemArray.count))
        scrollView.contentOffset = CGPoint(x: SCREEN_WIDTH*CGFloat(model.level - 1), y: scrollView.contentOffset.y)
        for (index,value) in tableViews.enumerated() {
            if index > model.level - 1 {
                value.removeFromSuperview()
            }
        }
        tableViews.removeSubrange(Range(indexPath.row + 1..<FJSQLiteUtils.instance.itemArray.count))
        FJSQLiteUtils.instance.itemArray.removeSubrange(Range(indexPath.row + 1..<FJSQLiteUtils.instance.itemArray.count))

        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 自适应
        let model = FJSQLiteUtils.instance.itemArray[indexPath.row]
        let width = widthForsize(text: model.name, size: CGSize(width:10000, height:35), font: 14)
        return CGSize(width: width + 20, height:40)
    }
    /// 自适应宽度
    ///
    /// - Parameter size: size description
    func widthForsize(text:String, size:CGSize,font:CGFloat) -> CGFloat{
        let attrbute = [NSFontAttributeName:UIFont.systemFont(ofSize: font)]
        let nsStr = NSString(string: text)
        return nsStr.boundingRect(with: size, options: [.usesLineFragmentOrigin,.usesFontLeading,.truncatesLastVisibleLine], attributes: attrbute, context: nil).size.width
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
        let model = dataArray[indexPath.row]
        cell.model = model
        // 选中变色
        cell.titleLabel.textColor = FJSQLiteUtils.instance.arribute.noSelectTextColor
        cell.titleIV.isHidden = true
        if model.id == FJSQLiteUtils.instance.itemArray[model.level - 1].id {
            cell.titleLabel.textColor = FJSQLiteUtils.instance.arribute.selectTextColor
            cell.titleIV.isHidden = false
        }
        return cell
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let dataArray = totaldataArray[tableViews.index(of: tableView)!]
        let model = dataArray[indexPath.row]
        let newDataArray = FJSQLiteUtils.instance.queryData(level: model.level + 1, parent_id: model.id)
        level = model.level
        if newDataArray.count > 0 {
            if model.level + 1 > totaldataArray.count {
                //添加下一级数据是
                totaldataArray.append(newDataArray)
                //添加下一级列表
                setupTableView()
                //修改当前级别选择
                FJSQLiteUtils.instance.itemArray[model.level - 1] = model
                //滚动
                scrollView.contentOffset = CGPoint(x: SCREEN_WIDTH*CGFloat(model.level), y: scrollView.contentOffset.y)
                //添加下一级默认按钮
                let item = FJAddressModel()
                item.name = "请选择"
                item.level = model.level + 1
                FJSQLiteUtils.instance.itemArray.append(item)
                //刷新数据
                collectionView.reloadData()
            }
        }
        else
        {
            FJSQLiteUtils.instance.itemArray[model.level - 1] = model
            collectionView.reloadData()
        }
        return indexPath
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
    }
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
