//
//  CategoriesViewController.swift
//  PublicAPIs
//
//  Created by Derik Malcolm on 10/21/18.
//  Copyright © 2018 Derik Malcolm. All rights reserved.
//

import UIKit

class CategoriesViewController: UITableViewController {
    
    var categories: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Categories"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        
        DataManager.fetchCategories { (categories) in
            self.categories = categories
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let categories = categories else { return 0 }
        
        if section == 0 {
            return 1
        } else {
            return categories.count - 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        guard let categories = categories else { return cell }
        
        if indexPath.section == 0 {
            cell.textLabel?.text = categories[0]
        } else {
            cell.textLabel?.text = categories[indexPath.row + 1]
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let categories = categories else { return }
        
        var category: String
        
        if indexPath.section == 0 {
            category = categories[0]
        } else {
            category = categories[indexPath.row]
        }
        
        let apisViewController = APIsViewController(style: .plain)
        apisViewController.category = category
        
        navigationController?.pushViewController(apisViewController, animated: true)
    }

}

