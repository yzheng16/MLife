//
//  ArticleCell.swift
//  MLife
//
//  Created by Yi Zheng on 2018-05-15.
//  Copyright © 2018 Yi Zheng. All rights reserved.
//

import LBTAComponents

class ArticleCell: DatasourceCell {
    
    override var datasourceItem: Any?{
        didSet {
            guard let article = datasourceItem as? Article else {return}
            articleTitleLabel.text = article.title
            numberOfViews.text = "\(article.numberOfViews)\nviews"
            profileImageView.image = article.user.profileImage
            usernameLabel.text = article.user.userName
            contentTextView.text = article.content
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            timeLabel.text = dateFormatter.string(from: article.time)
            locationLabel.text = article.location
            numberOfComment.text = "\(article.numberOfComments) comments"
            
        }
    }
    
    let articleTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "FIRST AID BEAUTY Hello Fab Coconut Micellar Makeup Melter"
        //        label.backgroundColor = .blue
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let numberOfViews: UILabel = {
       let label = UILabel()
        label.text = "9999\nviews"
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor(r: 130, g: 130, b: 130).cgColor
        label.textColor = UIColor(r: 130, g: 130, b: 130)
        label.font = UIFont.boldSystemFont(ofSize: 9)
//        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textAlignment = .center
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
    
    //MARK: there is a bug how to display partial text in the textView
    let contentTextView: UITextView = {
        let textView = UITextView()
        textView.text = "this is a test content of article. it should be very long. but it only display 4 lines.this is a test content of article. it should be very long. but it only display 4 lines.this is a test content of article. it should be very long. but it only display 4 lines.this is a test content of article. it should be very long. but it only display 4 lines."
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.isEditable = false
        return textView
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
    
    let numberOfComment: UILabel = {
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
        
        addSubview(articleTitleLabel)
        addSubview(numberOfViews)
        addSubview(profileImageView)
        addSubview(usernameLabel)
        addSubview(contentTextView)
        addSubview(timeLabel)
        addSubview(locationIcon)
        addSubview(locationLabel)
        addSubview(numberOfComment)
        
        articleTitleLabel.anchor(topAnchor, left: leftAnchor, bottom: nil, right: numberOfViews.leftAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 25)
        numberOfViews.anchor(articleTitleLabel.topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 40, heightConstant: 25)
        profileImageView.anchor(articleTitleLabel.bottomAnchor, left: articleTitleLabel.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 34, heightConstant: 34)
        usernameLabel.anchor(profileImageView.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 34)
        contentTextView.anchor(profileImageView.bottomAnchor, left: profileImageView.leftAnchor, bottom: nil, right: rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 80)
        timeLabel.anchor(contentTextView.bottomAnchor, left: profileImageView.leftAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 10, leftConstant: 0, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        locationIcon.anchor(timeLabel.topAnchor, left: timeLabel.rightAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 0, leftConstant: 5, bottomConstant: 10, rightConstant: 0, widthConstant: 20, heightConstant: 20)
        locationLabel.anchor(timeLabel.topAnchor, left: locationIcon.rightAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        numberOfComment.anchor(timeLabel.topAnchor, left: locationLabel.rightAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 5, bottomConstant: 5, rightConstant: 10, widthConstant: 0, heightConstant: 20)
    }
}
