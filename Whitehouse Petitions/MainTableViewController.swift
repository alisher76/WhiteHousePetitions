//
//  MainTableViewController.swift
//  Whitehouse Petitions
//
//  Created by Alisher Abdukarimov on 6/28/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var petitions = [[String:String]]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
            title = "Petitions"
        } else {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
            title = "Popular Petitions"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                let json = JSON(data: data)
                
                if json["metadata"]["responseInfo"]["status"].intValue == 200 {
                    print("hey")
                    parse(json: json)
                    return
                }else{
                    showError()
                }
            }
        }
    }
    
    func parse(json: JSON) {
        for result in json["results"].arrayValue {
            let title = result["title"].stringValue
            let body = result["body"].stringValue
            let sigs = result["signatureCount"].stringValue
            let obj = ["title" : title, "body" : body, "sigs" : sigs]
            petitions.append(obj)
        }
        tableView.reloadData()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return petitions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let petition = petitions[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = petition["title"]
        cell.detailTextLabel?.text = petition["body"]
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}
