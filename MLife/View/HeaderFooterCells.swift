//
//  Cells.swift
//  MLife
//
//  Created by Yi Zheng on 2018-05-11.
//  Copyright © 2018 Yi Zheng. All rights reserved.
//

import LBTAComponents

class ItemHeader: DatasourceCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    let cellId = "cellId"
    let itemSwichBarTitle = ["NEW", "NEARBY"]
    var horizontalBarLeftAnchorConstraint: [NSLayoutConstraint]?
    
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
        
//        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(horizontalBarView)
        
        horizontalBarLeftAnchorConstraint = horizontalBarView.anchorWithReturnAnchors(nil, left: leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: frame.width / 2, heightConstant: 4 )
        horizontalBarView.leftAnchor.constraint(equalTo: leftAnchor).constant = 187.5
//        print(frame.width)
//        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
//        horizontalBarLeftAnchorConstraint?.isActive = true
//        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
//        horizontalBarView.heightAnchor.constraint(equalToConstant: 8).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let x = CGFloat(indexPath.item) * frame.width / 2
        horizontalBarLeftAnchorConstraint?[0].constant = x
//        horizontalBarView.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 0, leftConstant: x, bottomConstant: 0, rightConstant: 0, widthConstant: frame.width / 2, heightConstant: 4 )
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
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

class ArticleHeader: DatasourceCell {
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "ARTICLES"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = .white
        
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        addSubview(textLabel)
        textLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}

class ItemFooter:DatasourceCell {
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Show me more"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        
        addSubview(backgroundView)
        addSubview(textLabel)
        
        backgroundView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 14, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        textLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 14, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}

class ArticleFooter:DatasourceCell {
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Show me more"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        
        addSubview(backgroundView)
        addSubview(textLabel)
        
        backgroundView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        textLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}
