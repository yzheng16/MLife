 //
//  ItemCell.swift
//  MLife
//
//  Created by Yi Zheng on 2018-05-14.
//  Copyright © 2018 Yi Zheng. All rights reserved.
//

import LBTAComponents

var horizontalBarLeftAnchorConstraint: [NSLayoutConstraint]?
var sellingCell: SellingCell?
var itemHeader: ItemHeader?
 
 class ItemHeader: DatasourceCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    let cellId = "cellId"
    let itemSwichBarTitle = ["NEW", "NEARBY"]
    
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "SELLING ITEMS"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! itemSwichBarCell
        cell.textLabel.text = itemSwichBarTitle[indexPath.item]
        cell.textLabel.textColor = UIColor(r: 187, g: 187, b: 187)
        
        //set the default selected item
        let selectedItemSwichBarByDefault = NSIndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedItemSwichBarByDefault as IndexPath, animated: false, scrollPosition: .top)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 2, height: 25)
    }
    
    //get rid of the gap left and right
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        itemHeader = self
        
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)

        
        //link to itemSwichBarCell
        collectionView.register(itemSwichBarCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(textLabel)
        addSubview(collectionView)
        
        textLabel.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        collectionView.anchor(textLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 25)
        
        //MARK: make a horizontal swap bar animation
        setupHorizontalBar()
    }
    
    let horizontalBarView: UIView = {
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor(r: 99, g: 149, b: 224)
        return horizontalBarView
    }()
    
    func setupHorizontalBar() {
        
        addSubview(horizontalBarView)
        
        horizontalBarLeftAnchorConstraint = horizontalBarView.anchorWithReturnAnchors(nil, left: leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: frame.width / 2, heightConstant: 4 )

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let x = CGFloat(indexPath.item) * frame.width / 2
//        horizontalBarLeftAnchorConstraint?[0].constant = x
//        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            self.layoutIfNeeded()
//        }, completion: nil)
        
        sellingCell?.scrollTohorizontalBarIndex(barIndex: indexPath.item)

    }
    
 }
 
 
 
 class itemSwichBarCell: DatasourceCell {
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "NEW"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet {
            textLabel.textColor = isHighlighted ? UIColor.black : UIColor(r: 187, g: 187, b: 187)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            textLabel.textColor = isSelected ? UIColor.black : UIColor(r: 187, g: 187, b: 187)
        }
    }
    
    override func setupViews(){
        super.setupViews()
        
        addSubview(textLabel)
        
        textLabel.fillSuperview()
    }
 }

 
 class SellingCell: DatasourceCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let SellingCellId = "cellId"
    var category: ItemCategory?

    
    override var datasourceItem: Any? {
        didSet{
            guard let itemCategory = datasourceItem as? ItemCategory else {return}
//            items = itemCategory.items
            category = itemCategory
        }
    }
    
    let hCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //the default color is black
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    func scrollTohorizontalBarIndex(barIndex: Int) {
        let indexPath = NSIndexPath(item: barIndex, section: 0)
        hCollectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset.x)
        horizontalBarLeftAnchorConstraint?[0].constant = scrollView.contentOffset.x / 2
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        print(targetContentOffset.pointee.x)//0 -> 0.0, 1 -> 375
//        print(targetContentOffset.pointee.x / frame.width)//0.0, 1.0
        let indexPath = NSIndexPath(item: Int(targetContentOffset.pointee.x / frame.width) , section: 0)
        itemHeader?.collectionView.selectItem(at: indexPath as IndexPath, animated:  true, scrollPosition: .left)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //number of v items
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SellingCellId, for: indexPath) as! SellingSectionCell
//        cell.item = items?[indexPath.item]
        cell.category = category
//        backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
    
    //MARK: get rid of the cell gap up and down
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func setupViews() {
        super.setupViews()
        
        hCollectionView.dataSource = self
        hCollectionView.delegate = self
        
        sellingCell = self
        
        //link cell class and add cell into collectionView
        hCollectionView.register(SellingSectionCell.self, forCellWithReuseIdentifier: SellingCellId)
        hCollectionView.isPagingEnabled = true
        addSubview(hCollectionView)
        
        hCollectionView.fillSuperview()
    }
}

class SellingSectionCell: DatasourceCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let sectionCollectionViewCellId = "cellId"
    var items: [Item]?
    
    var category: ItemCategory? {
        didSet {
            items = category?.items
        }
    }
    
    let vCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //the default color is black
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: sectionCollectionViewCellId, for: indexPath) as! ItemCell
        cell.item = items?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 250)
    }
    
    //MARK: get rid of the cell gap up and down
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func setupViews() {
        super.setupViews()
//        backgroundColor = .red
        
        vCollectionView.dataSource = self
        vCollectionView.delegate = self
        
        //link cell class and add cell into collectionView
        vCollectionView.register(ItemCell.self, forCellWithReuseIdentifier: sectionCollectionViewCellId)
        vCollectionView.isScrollEnabled = false
        
        addSubview(vCollectionView)
        
        vCollectionView.fillSuperview()
        
    }
}

class ItemCell: DatasourceCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    var imageViewArray: [UIImage]?
    private let imageCollectionViewCellId = "cellId"
    
    var item: Item? {
        didSet {
//            guard let item = datasourceItem as? Item  else {return}
            if let item = item {
                itemNameLabel.text = item.itemName
                priceLabel.text = "$\(item.itemPrice!)"
                profileImageView.image = item.user?.profileImage
                usernameLabel.text = item.user?.userName
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM-dd-yyyy"
                timeLabel.text = dateFormatter.string(from: item.date!)
                
                locationLabel.text = item.place! + ", " + item.city!
                numberOfLikes.text = "\(item.numberOfLikes!) Likes"
                imageViewArray = item.itemImages
            }
            
        }
    }
    
    //this is LBTAComponents' method to get data
//    override var datasourceItem: Any? {
//        didSet{
//            guard let item = datasourceItem as? Item  else {return}
//            itemNameLabel.text = item.itemName
//            priceLabel.text = "$\(item.itemPrice!)"
//            profileImageView.image = item.user?.profileImage
//            usernameLabel.text = item.user?.userName
//
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "MM-dd-yyyy"
//            timeLabel.text = dateFormatter.string(from: item.date!)
//
//            locationLabel.text = item.place! + ", " + item.city!
//            numberOfLikes.text = "\(item.numberOfLikes!) Likes"
//            imageViewArray = item.itemImages
//
//
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = imageViewArray?.count {
            return count
        }
        return 0
    }
    
    //sent cell to imageCell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCollectionViewCellId, for: indexPath) as! ImageCell
        cell.image = imageViewArray?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 129, height: frame.height)
    }
    
    let imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //the default color is black
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
//    let imagesView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .red
//        return view
//    }()
    
    let itemNameLabel: UILabel = {
        let label = UILabel()
        label.text = "FIRST AID BEAUTY Hello Fab Coconut Micellar Makeup Melter"
        //        label.backgroundColor = .blue
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let priceLabel:UILabel = {
        let label = UILabel()
        label.text = "$99"
        //        label.backgroundColor = .purple
        label.textColor = .red
        label.textAlignment = .right
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        //        image.backgroundColor = .green
        imageView.image = #imageLiteral(resourceName: "profile_image")
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Yi Zheng"
        //        label.backgroundColor = .brown
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "12/13/2018"
        label.textColor = UIColor(r: 130, g: 130, b: 130)
        //        label.backgroundColor = .black
        return label
    }()
    
    let locationIcon: UIImageView = {
        let image = UIImageView()
        //        image.backgroundColor = .red
        image.image = #imageLiteral(resourceName: "Location_Pin")
        return image
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "soughate"
        label.textColor = UIColor(r: 130, g: 130, b: 130)
        //        label.backgroundColor = .blue
        return label
    }()
    
    let numberOfLikes: UILabel = {
        let label = UILabel()
        label.text = "999+ comments"
        label.textColor = UIColor(r: 130, g: 130, b: 130)
        //        label.backgroundColor = .green
        label.textAlignment = .right
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = .white
        
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        
        //link cell class and add cell into collectionView
        imageCollectionView.register(ImageCell.self, forCellWithReuseIdentifier: imageCollectionViewCellId)
        
        addSubview(imageCollectionView)
        addSubview(itemNameLabel)
        addSubview(priceLabel)
        addSubview(profileImageView)
        addSubview(usernameLabel)
        addSubview(timeLabel)
        addSubview(locationIcon)
        addSubview(locationLabel)
        addSubview(numberOfLikes)
        
        imageCollectionView.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 17, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 125)
        itemNameLabel.anchor(imageCollectionView.bottomAnchor, left: imageCollectionView.leftAnchor, bottom: nil, right: priceLabel.leftAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 30)
        priceLabel.anchor(itemNameLabel.topAnchor, left: nil, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 100, heightConstant: 30)
        profileImageView.anchor(itemNameLabel.bottomAnchor, left: itemNameLabel.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 34, heightConstant: 34)
        usernameLabel.anchor(profileImageView.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 34)
        timeLabel.anchor(profileImageView.bottomAnchor, left: profileImageView.leftAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 10, leftConstant: 0, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        locationIcon.anchor(timeLabel.topAnchor, left: timeLabel.rightAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 0, leftConstant: 5, bottomConstant: 10, rightConstant: 0, widthConstant: 20, heightConstant: 20)
        locationLabel.anchor(timeLabel.topAnchor, left: locationIcon.rightAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        numberOfLikes.anchor(timeLabel.topAnchor, left: locationLabel.rightAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 5, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 20)
        
    }
}

class ImageCell:DatasourceCell {
    //this is original collectionView method. line 48 (cellForItemAt) will sent cell.app to the app
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "home-trade")
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        
//        backgroundColor = .blue
        addSubview(imageView)
        
        imageView.fillSuperview()
    }
    
    
}
