//
//  ViewController.swift
//  Vistival
//
//  Created by Stijn Huygh on 29/01/2018.
//  Copyright © 2018 Stijn Huygh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let data =  ImportData.data;

    override func viewDidLoad() {
        super.viewDidLoad()

        //all data is put in the arrays in ImportData
        data.fillAllData();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("test")
    }


}

