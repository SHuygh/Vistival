//
//  ViewController.swift
//  Vistival
//
//  Created by Stijn Huygh on 29/01/2018.
//  Copyright © 2018 Stijn Huygh. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let data = ImportData.data
    var newsItems = ImportData.data.newsList

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //all data is put in the arrays in ImportData
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let currentItem:NewsFeed = newsItems[indexPath.row]
        cell?.textLabel?.text = newsItems[indexPath.row].title
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination:NewsItemsViewController = segue.destination as! NewsItemsViewController
        
        let indexpath = tableView.indexPath(for: sender as! UITableViewCell)
        
        let toPass:NewsFeed = newsItems[indexpath!.row]
        
        destination.currentItem = toPass
        
    }

}

