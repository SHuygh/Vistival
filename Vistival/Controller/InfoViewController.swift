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
    var faq = ImportData.data.faqList
    
    var faqExpanded:[Bool] = [Bool]()
    
    var cellHeight = CGFloat();

    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in faq{
            var boolean = false
            faqExpanded.append(boolean)
        }
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        faq = ImportData.data.faqList;

        tableview.reloadData();
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return faq.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell")
        let frame = tableview.frame;
        
        let textview = UITextView.init(frame: CGRect.init(x: 0.05 * frame.size.width, y: 0, width: 0.9 * frame.size.width, height: 200), textContainer: nil)
        textview.text = faq[indexPath.section].body;
        
        textview.font = UIFont.init(name: (textview.font?.fontName)!, size: 16)
        
        textview.translatesAutoresizingMaskIntoConstraints = true
        textview.sizeToFit()
        textview.isScrollEnabled = false
        cellHeight = textview.contentSize.height;

        cell?.addSubview(textview)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (faqExpanded[indexPath.section]) {
            return cellHeight
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.customInit(title: faq[section].title, section: section, delegate: self as ExpandableHeaderViewDelegate)
        return header
    }
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        
        for (index, expanded) in faqExpanded.enumerated(){
            if (index != section){
            faqExpanded[index] = false
            }else{
             faqExpanded[section] = !faqExpanded[section]
            }
        }
        

        tableview.reloadData();
    }

}
