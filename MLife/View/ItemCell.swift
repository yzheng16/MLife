//
//  ItemCell.swift
//  MLife
//
//  Created by Yi Zheng on 2018-05-14.
//  Copyright © 2018 Yi Zheng. All rights reserved.
//

import LBTAComponents


//private var item: Item?


class ItemCell: DatasourceCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    var imageViewArray: [UIImage]?
    private let imageCollectionViewCellId = "cellId"
    
    //this is LBTAComponents' method to get data
    override var datasourceItem: Any? {
        didSet{
            guard let item = datasourceItem as? Item  else {return}
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
