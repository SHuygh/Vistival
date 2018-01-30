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
    var showID = 0;
    var testOrigin = "";
    
    @IBOutlet weak var artistview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        // Do any additional setup after loading the view.
    //sort line-up in functie van de tijd
        
        filterLineup();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        filterLineup();
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ImportData.data.stageList.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lineup.filter({$0.stageID == section }).count
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//        return ImportData.data.stageList[section].title;
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var btnShowStage = UIButton.init(type: .system);
        btnShowStage.accessibilityLabel = "\(section)"
        btnShowStage.addTarget(self, action: #selector(showStageBtnClicked(sender:)), for: .touchUpInside)
        
        let cell = artistview.dequeueReusableCell(withIdentifier: "cell")
        
        cell?.textLabel?.text = ImportData.data.stageList[section].title;

        return cell;
    }
    
    @objc func showStageBtnClicked(sender: UIButton){
        print(sender.accessibilityLabel)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell")!
        var totalRow = indexPath.row;
        
        totalRowLoop: for artist in lineup {
            if(indexPath.section == artist.stageID){
                break totalRowLoop
            }
            totalRow += 1;
        }
        
        let selected:Artist = lineup[totalRow]
        
        let formatter:DateFormatter = DateFormatter.init();
        formatter.dateStyle = .short;
        formatter.timeStyle = .short;
        let timeSelected = formatter.string(from: selected.time)
        
        let stageSelected:String = ImportData.data.stageList[selected.stageID].title!;

        cell.textLabel?.text = "\(selected.name) \(testOrigin)"
        cell.detailTextLabel?.text = "\(stageSelected)\t\(timeSelected)";
        
        return cell
    }
    
    
    @IBAction func zaterdagPressed() {
        if(showID != 1){
            showID = 1;
        }else{
            showID = 0
        }
        self.filterLineup()
    }
    
    @IBAction func zondagPressed() {
        if(showID != 2){
            showID = 2;
        }else{
            showID = 0
        }
        self.filterLineup()
    }
    
    func filterLineup(){
        lineup = ImportData.data.artistList;
        lineup.sort(by: {
            
            if($0.stageID < $1.stageID){
                return true;
            }
            if($0.stageID == $1.stageID && $0.time < $1.time){
                return true;
            }else{
                return false;
            }
            
        })
        
        switch showID {
        case 1:
            //alles tot en met zondag 6 am
            lineup = lineup.filter({$0.time <= Date.init(timeIntervalSince1970: 1533708000)})
        case 2:
            //alles na zondag 6am
            lineup = lineup.filter({$0.time > Date.init(timeIntervalSince1970: 1533708000)})
        default: //totale lijst
            break;
        }
        artistview.reloadData();
        
    }
    
    
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        let destination:DetailFAQViewController = segue.destination as! DetailFAQViewController

    
    

}
