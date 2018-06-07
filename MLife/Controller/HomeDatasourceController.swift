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
        
        collectionView?.showsVerticalScrollIndicator = false
    }
    
    //remove the gap between each itemCell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    //main cell in a section
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 3 {
            return CGSize(width: view.frame.width, height: 200)
        }else if indexPath.section == 2 {
            return CGSize(width: view.frame.width, height: 480)
        }else if indexPath.section == 1 {
            return CGSize(width: view.frame.width, height: 120)
        }else if indexPath.section == 0 {
            return CGSize(width: view.frame.width, height: 200)
        }
        return CGSize(width: view.frame.width, height: 250)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 2{
            let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! SellingCell
            cell.homeDatasourceController = self
            return cell
        }else if indexPath.section == 1 {
            let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! MenuCell
            cell.homeDatasourceController = self
            return cell
        }
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath)
        return cell
    }
    
    //MARK: TODO: create a new controller file
    func showMenuItemDetail(index: Int) {
        let menuItemDetailController = UIViewController()
        navigationController?.pushViewController(menuItemDetailController, animated: true)
        if index == 0 {
            navigationItem.title = "in the Selling Menu"
        } else if index == 1 {
            navigationItem.title = "in the Article Menu"
        }else if index == 2 {
            navigationItem.title = "in the Navigation Menu"
        }else {
            navigationItem.title = "undifind"
        }
        
    }
    
    //MARK: TODO: create a new controller file
    func showItemDetail(item:Item) {
        let itemDetailController = UIViewController()
        navigationController?.pushViewController(itemDetailController, animated: true)
        navigationItem.title = "in the Selling Item"
    }
    
    //header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 || section == 1 {
            return CGSize(width: 0, height: 0)
        }
        return CGSize(width: view.frame.width, height: 80)
    }
    
    //footer
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 3 {
            return CGSize(width: view.frame.width, height: 53)
        }else if section == 1 {
            return CGSize(width: 0, height: 14)
        }else if section == 0 {
            return CGSize(width: 0, height: 0)
        }
        return CGSize(width: view.frame.width, height: 60 + 14)
    }


}

