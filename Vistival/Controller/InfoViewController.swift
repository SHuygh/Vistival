//
//  InfoViewController.swift
//  Vistival
//
//  Created by Daan Demeulemeester on 29/01/2018.
//  Copyright © 2018 Stijn Huygh. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var tableview: UITableView!
    var faqItems = ImportData.data.faqList

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cellIdentifier = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell")
        let currentItem:FAQ = faqItems[indexPath.row]

        cell?.textLabel?.text = faqItems[indexPath.row].title
        return cell!
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    let destination:DetailFAQViewController = segue.destination as! DetailFAQViewController
    
        let indexpath = tableview.indexPath(for: sender as! UITableViewCell)
        
        let toPass:FAQ = faqItems[indexpath!.row]
    
    destination.currentItem = toPass

}
}
