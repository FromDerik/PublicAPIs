//
//  APIsViewController.swift
//  PublicAPIs
//
//  Created by Derik Malcolm on 10/21/18.
//  Copyright © 2018 Derik Malcolm. All rights reserved.
//

import UIKit

class APIsViewController: UITableViewController {
    
    var category: String?
    var entries: [Entry]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = category
        
        tableView.register(APICell.self, forCellReuseIdentifier: "cellId")
//        tableView.rowHeight = 60
        
        
        if let category = category {
            DataManager.fetchEntries(category: category) { (entries) in
                self.entries = entries
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let entries = entries else { return 0 }
        return entries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! APICell
        
        guard let entries = entries else { return cell }
        let entry = entries[indexPath.row]
        
        cell.titleLabel.text = entry.api
        cell.descriptionLabel.text = entry.description
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
