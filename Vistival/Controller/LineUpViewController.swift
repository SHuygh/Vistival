//
//  LineUpViewController.swift
//  Vistival
//
//  Created by Daan Demeulemeester on 29/01/2018.
//  Copyright © 2018 Stijn Huygh. All rights reserved.
//

import UIKit

class LineUpViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    var lineup = ImportData.data.artistList
    var testOrigin = "";
    
    @IBOutlet weak var artistview: UITableView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad();
        // Do any additional setup after loading the view.
    //sort line-up in functie van de tijd
        lineup.sort(by: { $0.time < $1.time })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        artistview.reloadData();
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ImportData.data.stageList.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lineup.filter({$0.stageID == section }).count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return ImportData.data.stageList[section].title;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell")!
        
        let selected:Artist = lineup[indexPath.row]
        
        let formatter:DateFormatter = DateFormatter.init();
        formatter.dateStyle = .short;
        formatter.timeStyle = .short;
        let timeSelected = formatter.string(from: selected.time)
        
        let stageSelected:String = ImportData.data.stageList[selected.stageID].title!;

        cell.textLabel?.text = "\(selected.name) \(testOrigin)"
        cell.detailTextLabel?.text = "\(stageSelected)\t\(timeSelected)";
        
        switch indexPath.section {
        case 0:
            cell.backgroundColor = UIColor.blue
        case 1:
            cell.backgroundColor = UIColor.red
        default:
            cell.backgroundColor = UIColor.lightGray
        }
        
        return cell
    }
    
    
    @IBAction func zaterdagPressed() {
    }
    
    @IBAction func zondagPressed() {
    }
    
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        let destination:DetailFAQViewController = segue.destination as! DetailFAQViewController

    
    

}
