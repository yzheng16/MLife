//
//  MenuCell.swift
//  MLife
//
//  Created by Yi Zheng on 2018-05-30.
//  Copyright © 2018 Yi Zheng. All rights reserved.
//

import LBTAComponents

class MenuCell: DatasourceCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let menuCellId = "cellId"
    var homeDatasourceController: HomeDatasourceController?
    let menuItems: [[String:String]] = [["imageName": "icon", "title": "Selling"],["imageName": "icon", "title": "Article"],["imageName": "icon", "title": "Navigation"]]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuCellId, for: indexPath) as! MenuItemCell
        cell.menuItem = menuItems[indexPath.item]
        return cell
    }
    
    //get rid of the gap left and right
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 3, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        homeDatasourceController?.showMenuItemDetail(index: indexPath.item)
    }
    
    let hMenuItemCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.backgroundColor = .red
        return collectionView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        
        hMenuItemCollectionView.register(MenuItemCell.self, forCellWithReuseIdentifier: menuCellId)
        hMenuItemCollectionView.dataSource = self
        hMenuItemCollectionView.delegate = self
        
//        backgroundColor = .red
        
        addSubview(hMenuItemCollectionView)
        
        hMenuItemCollectionView.fillSuperview()
        
    }
}

class MenuItemCell: DatasourceCell {
    
    var menuItem: [String:String]?{
        didSet {
            if let menuItem = menuItem {
                menuIcon.image = UIImage(named: menuItem["imageName"]!)
                menuLabel.text = menuItem["title"]!
            }
        }
    }
    
    let menuIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon")
        return imageView
    }()
    
    let menuLabel: UILabel = {
        let label = UILabel()
        label.text = "Selling"
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .white
        
        addSubview(menuIcon)
        addSubview(menuLabel)
        
        menuIcon.anchorCenterXToSuperview()
        menuLabel.anchorCenterXToSuperview()
        menuIcon.anchor(topAnchor, left: nil, bottom: nil, right: nil, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 60)
        menuLabel.anchor(menuIcon.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
}
