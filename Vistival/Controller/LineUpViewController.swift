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
    var showStage:[Bool] = [Bool]()
    var personalLineup = false;
    
    @IBOutlet weak var artistview: UITableView!
    
    @IBOutlet weak var btnZaterdag: UIButton!
    
    @IBOutlet weak var btnZondag: UIButton!
    
    @IBOutlet weak var btnZaZo: UIButton!
    
    @IBOutlet weak var btnPersonal: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        // Do any additional setup after loading the view.
    //sort line-up in functie van de tijd
        
        for _ in ImportData.data.stageList{
            showStage.append(true)
        }
        btnZaterdag.backgroundColor = UIColor(red:0.09, green:0.37, blue:0.49, alpha:1.0);
        btnZaterdag.titleLabel?.textColor = UIColor.white
        btnZondag.backgroundColor = UIColor(red:0.09, green:0.37, blue:0.49, alpha:1.0);
        btnZondag.titleLabel?.textColor = UIColor.white
        btnZaZo.backgroundColor = UIColor.white
        btnZaZo.titleLabel?.textColor = UIColor.black
        //button.titleLabel.textColor
        btnPersonal.setImage(UIImage.init(named: "unliked.png"), for: .normal)
        
        filterLineup();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(showID == 0){
        btnZaterdag.backgroundColor = UIColor(red:0.09, green:0.37, blue:0.49, alpha:1.0);
            btnZaterdag.titleLabel?.textColor = UIColor.white
        btnZondag.backgroundColor = UIColor(red:0.09, green:0.37, blue:0.49, alpha:1.0);
            btnZondag.titleLabel?.textColor = UIColor.white
            btnZaZo.backgroundColor = UIColor.white
            btnZaZo.titleLabel?.textColor = UIColor.black;
        }else if (showID == 1){
            btnZaterdag.backgroundColor = UIColor.white;
            btnZaterdag.titleLabel?.textColor = UIColor.black;
            btnZondag.backgroundColor = UIColor(red:0.09, green:0.37, blue:0.49, alpha:1.0);
            btnZondag.titleLabel?.textColor = UIColor.white
            btnZaZo.backgroundColor = UIColor(red:0.09, green:0.37, blue:0.49, alpha:1.0);
            btnZaZo.titleLabel?.textColor = UIColor.white
        }else{
            btnZaterdag.backgroundColor = UIColor(red:0.09, green:0.37, blue:0.49, alpha:1.0);
            btnZaterdag.titleLabel?.textColor = UIColor.white
            btnZondag.backgroundColor = UIColor.white;
            btnZondag.titleLabel?.textColor = UIColor.black;
            btnZaZo.backgroundColor = UIColor(red:0.09, green:0.37, blue:0.49, alpha:1.0)
            btnZaZo.titleLabel?.textColor = UIColor.white
        }
        lineup = ImportData.data.artistList;
        filterLineup();
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ImportData.data.stageList.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lineup.filter({$0.stageID == section }).count
  
    }
    

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let frame = artistview.frame;
        
        let showStageBtn = UIButton.init(frame: CGRect.init(x: frame.size.width - 70, y: 0, width: 60, height: 50))
        
            //showStageBtn.setTitle("...", for: .normal);
            //showStageBtn.backgroundColor = UIColor.red;
        if(showStage[section]){
            showStageBtn.setImage(UIImage.init(named: "up.png"), for: .normal)
        }else{
            showStageBtn.setImage(UIImage.init(named: "down.png"), for: .normal)
        }
            showStageBtn.addTarget(self, action: #selector(showStageBtnClicked(sender:)), for: .touchUpInside);
        
            showStageBtn.accessibilityLabel = "\(section)"
        
        let lblHeader =  UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 50));
        
            lblHeader.center = CGPoint.init(x: frame.size.width/2.0, y: 25)
            lblHeader.textAlignment = .center;
            lblHeader.text = ImportData.data.stageList[section].title;
            lblHeader.textColor = UIColor.white;
            lblHeader.font = UIFont.init(name: lblHeader.font.fontName, size: 20)
        
        let header = UIView.init(frame: CGRect.init(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        
            header.addSubview(showStageBtn)
            header.addSubview(lblHeader)
        
            header.isUserInteractionEnabled = true;
        
        header.backgroundColor = UIColor(red:0.09, green:0.37, blue:0.49, alpha:1.0);
        
        return header;

        
    }
    
    
    @objc func showStageBtnClicked(sender: UIButton){
        
        let btnID = (sender.accessibilityLabel! as NSString).integerValue
        showStage[btnID] = !showStage[btnID]
        
        if(showStage[btnID]){
            sender.setImage(UIImage.init(named: "up.png"), for: .normal)
        }else{
            sender.setImage(UIImage.init(named: "down.png"), for: .normal)
        }
        
        self.filterLineup()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
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
        
        if(!lineup[totalRow].personal){
            cell.imageView?.image = UIImage.init(named: "unliked.png")
        }else{
            cell.imageView?.image = UIImage.init(named: "liked.png")
        }
        
        
        //ge maakt ne recognizer
        //selector called een functie (zie hieronder)
        let recognizer = UITapGestureRecognizer.init(target: self, action: #selector(imageOfCellTapped(sender:)))
        
        //ge voegt die toe
        cell.imageView?.addGestureRecognizer(recognizer);
        //ge moogt die aanklikken
        cell.imageView?.isUserInteractionEnabled = true;
        
        cell.textLabel?.text = selected.name
        cell.detailTextLabel?.text = "\(stageSelected)\t\(timeSelected)";
        
        return cell
    }
    
    @objc func imageOfCellTapped(sender: UITapGestureRecognizer){
        //ge ziet waar ge tapped
        let tapLocation = sender.location(in: artistview)

        //haal den index vna die row op
            if let tapIndexPath = self.artistview.indexPathForRow(at: tapLocation){
                var totalRow = tapIndexPath.row;
                
                totalRowLoop: for artist in lineup {
                    if(tapIndexPath.section == artist.stageID){
                        break totalRowLoop
                    }
                    totalRow += 1;
                }
                
                if(lineup[totalRow].personal){
                   ImportData.data.deleteArtistInPersonalLineUp(artist: lineup[totalRow])
                }else{
                    ImportData.data.saveArtistInPersonalLineUp(artist: lineup[totalRow])
                }
                
                if(lineup[totalRow].personal){
                    artistview.cellForRow(at: tapIndexPath)?.imageView?.image = UIImage.init(named: "liked.png")
                }else{
                    artistview.cellForRow(at: tapIndexPath)?.imageView?.image = UIImage.init(named: "unliked.png")
                }
            }
    }

    @IBAction func zaterdagPressed() {

        btnZaterdag.titleLabel?.textColor = UIColor.black;
        btnZaterdag.backgroundColor = UIColor.white;
        btnZaterdag.titleLabel?.textColor = UIColor.black;
        btnZondag.backgroundColor = UIColor(red:0.09, green:0.37, blue:0.49, alpha:1.0);
        btnZondag.titleLabel?.textColor = UIColor.white
        btnZaZo.backgroundColor = UIColor(red:0.09, green:0.37, blue:0.49, alpha:1.0);
        btnZaZo.titleLabel?.textColor = UIColor.white

            showID = 1;
 
        
        self.filterLineup()
    }
    
    @IBAction func zondagPressed() {

        btnZaterdag.backgroundColor = UIColor(red:0.09, green:0.37, blue:0.49, alpha:1.0);
        btnZondag.titleLabel?.textColor = UIColor.white

        btnZondag.backgroundColor = UIColor.white;
        btnZondag.titleLabel?.textColor = UIColor.black;
        
        btnZaZo.backgroundColor = UIColor(red:0.09, green:0.37, blue:0.49, alpha:1.0);
        btnZaZo.titleLabel?.textColor = UIColor.white

            showID = 2;

        self.filterLineup()
    }
    
    
    @IBAction func zazopressed() {
        btnZaterdag.backgroundColor = UIColor(red:0.09, green:0.37, blue:0.49, alpha:1.0);
        btnZaterdag.titleLabel?.textColor = UIColor.white

        btnZondag.backgroundColor = UIColor(red:0.09, green:0.37, blue:0.49, alpha:1.0);
        btnZondag.titleLabel?.textColor = UIColor.white

        btnZaZo.backgroundColor = UIColor.white
        btnZaZo.titleLabel?.textColor = UIColor.black
        showID = 0
        self.filterLineup();
    }
    
    @IBAction func personalPressed() {
        personalLineup = !personalLineup

        if(personalLineup){
            btnPersonal.setImage(UIImage.init(named: "liked.png"), for: .normal)
        }else{
            btnPersonal.setImage(UIImage.init(named: "unliked.png"), for: .normal)
        }
        self.filterLineup();
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
        
        for (index, stage) in showStage.enumerated() {
            if(!stage){
                lineup = lineup.filter({$0.stageID != index })
            }
        }
        
        lineup = lineup.filter({$0.personal == true || !personalLineup})
        
        artistview.reloadData();
        

    }
    

}
