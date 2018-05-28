//
//  ViewController.swift
//  MLife
//
//  Created by Yi Zheng on 2018-05-08.
//  Copyright © 2018 Yi Zheng. All rights reserved.
//

import LBTAComponents

class HomeDatasourceController: DatasourceController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: change inside of navigationBar
        navigationController?.navigationBar.isTranslucent = false
        //MARK: usage of UILabel construction to set position
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        let homeDatasource = HomeDatasource()
        self.datasource = homeDatasource
        
        //gray background color
        collectionView?.backgroundColor = UIColor(r: 232, g: 236, b: 241)
        navigationController?.hidesBarsOnSwipe = true
    }
    
    //remove the gap between each itemCell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    //main cell in a section
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: view.frame.width, height: 200)
        }else if indexPath.section == 0 {
            return CGSize(width: view.frame.width, height: 500)
        }
        return CGSize(width: view.frame.width, height: 250)
    }
    
    //header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 53)
    }
    
    //footer
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 1 {
            return CGSize(width: view.frame.width, height: 53)
        }
        return CGSize(width: view.frame.width, height: 53 + 14)
    }


}

