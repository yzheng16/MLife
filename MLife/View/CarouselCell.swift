//
//  CarouselCell.swift
//  MLife
//
//  Created by Yi Zheng on 2018-06-06.
//  Copyright © 2018 Yi Zheng. All rights reserved.
//

import LBTAComponents

class CarouselCell: DatasourceCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var carouselImages: [UIImage]?
    let carouselImageCellId = "cellId"
    var timer: Timer?

    
    override var datasourceItem: Any? {
        didSet {
            guard let images = datasourceItem as? [UIImage] else {return}
            carouselImages = images
        }
    }
    
    let hCollectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    let pageControl: UIPageControl = {
       let pc = UIPageControl()
        pc.currentPage = 0
        //MARK - BUG
        pc.numberOfPages = 4
        pc.currentPageIndicatorTintColor = .black
        //backgound gray
        pc.pageIndicatorTintColor = UIColor(r: 232, g: 236, b: 241)
        return pc
    }()
    
    /**
     Invokes Timer to start Automatic Animation with repeat enabled
     */
    func startTimer() -> Timer {
        
        let timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollToNextCell), userInfo: nil, repeats: true)
        
        return timer
    }
    
    /**
     Scroll to Next Cell
     */
    @objc func scrollToNextCell(){
        
        //get Collection View Instance
//        let collectionView: UICollectionView
        
        //get cell size
        let cellSize = CGSize(width: frame.width, height: frame.height)
        
        //get current content Offset of the Collection view
        
        let contentOffset = hCollectionView.contentOffset
//        print(contentOffset)
        //scroll to next cell
        hCollectionView.scrollRectToVisible(CGRect(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true);
        let index = contentOffset.x / frame.width
        pageControl.currentPage = Int(index)
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        timer?.invalidate()
        let index = targetContentOffset.pointee.x / frame.width
//        print(hCollectionView.contentOffset.x)
        if index <= 4  && index > 0{
            pageControl.currentPage = Int(index) - 1
//            print(Int(index) - 1)
            
        }
        timer = startTimer()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        //只需要监视“前”点
        if x == frame.width * 5 {
            let cgPoint = CGPoint(x: frame.width, y: 0)
            scrollView.setContentOffset(cgPoint, animated: false)
            pageControl.currentPage = 0
        }else if x == 0{
            let cgPoint = CGPoint(x: frame.width * 4, y: 0)
            scrollView.setContentOffset(cgPoint, animated: false)
            pageControl.currentPage = 4
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let cgPoint = CGPoint(x: frame.width * 1, y: 0)
        collectionView.setContentOffset(cgPoint, animated: false)
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (carouselImages?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: carouselImageCellId, for: indexPath) as! CarouselImageCell
        cell.image = carouselImages?[indexPath.item]
        return cell
    }
    
    override func setupViews() {
        super.setupViews()
        
        hCollectionView.delegate = self
        hCollectionView.dataSource = self
        hCollectionView.register(CarouselImageCell.self, forCellWithReuseIdentifier: carouselImageCellId)
        
        addSubview(hCollectionView)
        addSubview(pageControl)
        
        hCollectionView.fillSuperview()
        pageControl.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        timer = startTimer()
    }
}

class CarouselImageCell: DatasourceCell {
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    let imageView : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
//        backgroundColor = .red
        
        addSubview(imageView)
        
        imageView.fillSuperview()
    }
}
