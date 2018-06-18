//
//  ViewController.swift
//  MLife
//
//  Created by Yi Zheng on 2018-05-08.
//  Copyright © 2018 Yi Zheng. All rights reserved.
//

import LBTAComponents
import UIKit

class HomeDatasourceController: DatasourceController, UISearchBarDelegate {

    let locationButton: UIButton = {
       let ub = UIButton()
        
        let locationLabel = UILabel()
        locationLabel.text = "EDM"
        let icon = UIImageView()
        icon.image = #imageLiteral(resourceName: "expand-arrow-30")
        
        ub.addSubview(locationLabel)
        ub.addSubview(icon)
        
        locationLabel.anchor(ub.topAnchor, left: ub.leftAnchor, bottom: ub.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        icon.anchor(nil, left: locationLabel.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 15, heightConstant: 15)
        icon.anchorCenterYToSuperview()
        //MARK: --QUESTION: why i can't write action in the closer
//        ub.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControlEvents#>)
        return ub
    }()
    
    @objc func handleLocationButton(){
        print("location button pressed\ni think i should use segway for this button")
        navigationController?.pushViewController(UIViewController(), animated: false)
    }
    
    
    let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Search"
        return sb
    }()
    
    let languageButton: UIButton = {
        let ub = UIButton()
        let languageLabel = UILabel()
        languageLabel.text = "EN"
        let icon = UIImageView()
        icon.image = #imageLiteral(resourceName: "expand-arrow-30")
        
        ub.addSubview(languageLabel)
        ub.addSubview(icon)
        
        languageLabel.anchor(ub.topAnchor, left: ub.leftAnchor, bottom: ub.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        icon.anchor(nil, left: languageLabel.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 15, heightConstant: 15)
        icon.anchorCenterYToSuperview()
        
        return ub
    }()
    
    @objc func handleLanguageButton(){
        print("language button pressed\ni think i should use segway for this button")
        navigationController?.pushViewController(UIViewController(), animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: change inside of navigationBar
        navigationController?.navigationBar.isTranslucent = false
        /*
            //MARK: usage of UILabel construction to set position
            let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
            titleLabel.text = "Home"
            titleLabel.textColor = .white
            titleLabel.font = UIFont.systemFont(ofSize: 20)
            navigationItem.titleView = titleLabel
        */
        navigationController?.navigationBar.addSubview(locationButton)
        navigationController?.navigationBar.addSubview(searchBar)
        //MARK: this is a way to use searchBar in the navigation bar
//        navigationItem.searchController = MUISearchController()
        navigationController?.navigationBar.addSubview(languageButton)
        
        locationButton.addTarget(self, action: #selector(handleLocationButton), for: .touchUpInside)
        languageButton.addTarget(self, action: #selector(handleLanguageButton), for: .touchUpInside)
        
        let navBar = navigationController?.navigationBar

        locationButton.anchor(navBar?.topAnchor, left: navBar?.leftAnchor, bottom: navBar?.bottomAnchor, right: nil, topConstant: 0, leftConstant: 4, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 0)

        searchBar.anchor(navBar?.topAnchor, left: locationButton.rightAnchor, bottom: navBar?.bottomAnchor, right: languageButton.leftAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)

        languageButton.anchor(navBar?.topAnchor, left: nil, bottom: navBar?.bottomAnchor, right: navBar?.rightAnchor, topConstant: 0, leftConstant: 4, bottomConstant: 0, rightConstant: 4, widthConstant: 40, heightConstant: 0)
        
        let homeDatasource = HomeDatasource()
        self.datasource = homeDatasource
        
        //gray background color
        collectionView?.backgroundColor = UIColor(r: 232, g: 236, b: 241)
        navigationController?.hidesBarsOnSwipe = true
        
        collectionView?.showsVerticalScrollIndicator = false
    }
    
//    // called before text changes
//    public func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        return true
//    }
//
//    // called when text starts editing
//    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar){
//        print("123")
//    }
    
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

