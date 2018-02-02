//
//  InfoViewController.swift
//  Vistival
//
//  Created by Daan Demeulemeester on 29/01/2018.
//  Copyright © 2018 Stijn Huygh. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ExpandableHeaderViewDelegate {
    

    @IBOutlet weak var tableview: UITableView!
//    var faqItems = ImportData.data.faqList
    
    var faqItems = [
        FAQ(title: "Mag ik zelf drinken meebrengen?",
            body: ["Neen, er zijn foodstands aanwezig op het terein."],
            expanded: false),
        FAQ(title: "Waar is Vistival?",
            body: ["Havengeul, 8620, Nieuwpoort"],
            expanded: false),
        FAQ(title: "Is het Vistival betalend?",
            body: ["Neen, de toegang is gratis."],
            expanded: false)
    ]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        faqItems = ImportData.data.faqList;
//        tableview.reloadData();
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return faqItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqItems[section].body.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell")
//        let currentItem:FAQ = faqItems[indexPath.row]

//        cell?.textLabel?.text = currentItem.title
        cell?.textLabel?.text = faqItems[indexPath.section].body[indexPath.row]
        let frame = tableView.frame;

        let textLbl = UILabel.init(frame: CGRect.init(x: 0.03 * frame.width, y: 0.9 * tableView.rowHeight, width: 0.8 * frame.width, height: 30))
        
        textLbl.sizeToFit()

        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (faqItems[indexPath.section].expanded) {
            return 44
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.customInit(title: faqItems[section].title, section: section, delegate: self as ExpandableHeaderViewDelegate)
        return header
    }
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        faqItems[section].expanded = !faqItems[section].expanded
        
        tableview.beginUpdates()

        for i in 0 ..< faqItems[section].body.count {
            tableview.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        tableview.endUpdates()
    }

    

    
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//    let destination:DetailFAQViewController = segue.destination as! DetailFAQViewController
//
//        let indexpath = tableview.indexPath(for: sender as! UITableViewCell)
//
//        let toPass:FAQ = faqItems[indexpath!.row]
//
//    destination.currentItem = toPass
//
//}
}
