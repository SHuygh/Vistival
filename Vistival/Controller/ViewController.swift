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
        newsItems.sort(by: {$0.id > $1.id})
       
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
        
        let frame = tableView.frame;
        
        //Image
        let image = UIImage.init(named: newsItems[indexPath.row].img)
        
        tableView.rowHeight = frame.width/1.77
        
        let imageview = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: frame.width, height: tableView.rowHeight))
        imageview.image = image;
        imageview.contentMode = .scaleAspectFill
        
        
        cell?.addSubview(imageview);
        
        //textlabel
        let textLbl = UILabel.init(frame: CGRect.init(x: 0.03 * frame.width, y: 0.9 * tableView.rowHeight - 30, width: 0.8 * frame.width, height: 30))
        
        textLbl.text = " \(newsItems[indexPath.row].title) "
        textLbl.textColor = UIColor.black;
        textLbl.backgroundColor = UIColor.white;
        textLbl.font = UIFont.boldSystemFont(ofSize: 18)
        
        textLbl.sizeToFit()
        
        cell?.addSubview(textLbl)
 
        

        
        return cell!
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination:NewsItemsViewController = segue.destination as! NewsItemsViewController
        
        let indexpath = tableView.indexPath(for: sender as! UITableViewCell)
        
        let toPass:NewsFeed = newsItems[indexpath!.row]
        
        destination.currentItem = toPass
        
    }

}

