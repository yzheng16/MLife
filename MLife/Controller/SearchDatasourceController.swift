//
//  SearchController.swift
//  MLife
//
//  Created by Yi Zheng on 2018-06-17.
//  Copyright © 2018 Yi Zheng. All rights reserved.
//

import LBTAComponents
import UIKit

class SearchDatasourceController: DatasourceController {
    
    let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Search"
        return sb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.addSubview(searchBar)
        
        let navBar = navigationController?.navigationBar
        
        searchBar.anchor(navBar?.topAnchor, left: navBar?.leftAnchor, bottom: navBar?.bottomAnchor, right: navBar?.rightAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
    }
}
