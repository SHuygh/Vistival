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


class ViewController: UIViewController{
    
    
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


}

