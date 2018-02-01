//
//  ImportData.swift
//  Vistival
//
//  Created by Stijn Huygh on 29/01/2018.
//  Copyright © 2018 Stijn Huygh. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

public class ImportData{
    
    var faqList:[FAQ] = [FAQ]();
    var newsList:[NewsFeed] = [NewsFeed]();
    var artistList:[Artist] = [Artist]();
    var stageList:[Stage] = [Stage]();
    var foodCourt:[FoodStand] = [FoodStand]();
    var personalLineUp:[PersonalLineUp] = [PersonalLineUp]();
    
    let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;
    
    let currentIP = "10.3.210.21"
    
    static let data:ImportData = ImportData();
    
    let requestVersion = "huygh.stijn.vistivalversion";
    let requestStages = "huygh.stijn.stage";
    let requestArtist = "huygh.stijn.artist"
    let requestFoodstands = "huygh.stijn.foodstand";
    let requestNews = "huygh.stijn.newsfeed"
    let requestFAQ = "huygh.stijn.faq"
    
    init() {
        fillAllData()
    }
    
    func fillAllData(){
        self.news();
        
        //version control should be added once core data is introduced for all classes
        //self.accessRESTful(request: requestVersion)
        self.accessRESTful(request: requestArtist)
        self.accessRESTful(request: requestStages)
        self.accessRESTful(request: requestFAQ)
        self.accessRESTful(request: requestFoodstands)
        
        //self.makeFAQ();
        //self.makeNewsList();
        //self.makeFoodCourt();
        //self.makeStageList();
        //self.makeArtistList();
    
    }
    
    
    func news(){
        let uri = URL.init(string: "http://\(currentIP):8080/Vistival/webresources/\(requestNews)")
        
        do{
            let jsonData = try Data(contentsOf: uri!)
            
            let jsonArray = try JSONSerialization.jsonObject(with: jsonData) as! [NSObject];
            
            for jsonObject  in jsonArray{
                let title = jsonObject.value(forKey: "title") as! String;
                let body = jsonObject.value(forKey: "body") as! String;
                let id = jsonObject.value(forKey: "id") as! Int;
                let img = jsonObject.value(forKey: "img") as! String;
                
                let newsItem:NewsFeed = NewsFeed.init(title: title, body: body, id: id, img: img);
                print(newsItem.title)
                self.newsList.append(newsItem);
            }
            
        }catch{}
        
    }
    
    func accessRESTful(request: String){
        //based on http://matteomanferdini.com/network-requests-rest-apis-ios-swift/
        let session = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: OperationQueue.main)
        let url = URL(string: "http://\(currentIP):8080/Vistival/webresources/\(request)")!
        let task = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let data = data else {
                return
            }
            guard let jsonArray = try? JSONSerialization.jsonObject(with: data) as! [NSObject] else {
                return
            }

            switch request{
            case self.requestVersion:
                    print(self.requestVersion)
                    self.compareVersions(jsonArray: jsonArray)
                
                 case self.requestFAQ:
                    print(self.requestFAQ)
                    self.generateFAQ(jsonArray: jsonArray)
                
                case self.requestStages:
                    print(self.requestStages)
                    self.generateStages(jsonArray: jsonArray)
                
                case self.requestFoodstands:
                    print(self.requestFoodstands)
                    self.generateFoodCourt(jsonArray: jsonArray)
                
                case self.requestArtist:
                    print(self.requestArtist)
                    self.generateArtistlist(jsonArray: jsonArray)
                
                default:
                    break;
            }
        })
        
        task.resume()


    }
    
    func generateFoodCourt(jsonArray: [NSObject]){
        for jsonObject in jsonArray{
            let coordinateX = jsonObject.value(forKey: "coordinateX") as! Double;
            let coordinateY = jsonObject.value(forKey: "coordinateY") as! Double;
            let coordinate = CLLocationCoordinate2D.init(latitude: coordinateX, longitude: coordinateY)
            
            let title = jsonObject.value(forKey: "title") as! String;
            let id = jsonObject.value(forKey: "id") as! Int;
            let description = jsonObject.value(forKey: "description") as! String;
            
            let foodstand = FoodStand.init(coordinate: coordinate, name: title, id: id, descriptionFood: description)
            self.foodCourt.append(foodstand)
        }
    }
    
    func generateFAQ(jsonArray: [NSObject]){
        for jsonObject in jsonArray{
            let title = jsonObject.value(forKey: "title") as! String
            let body = jsonObject.value(forKey: "body") as! String;
            
            let faq = FAQ.init(title: title, body: body)
            faqList.append(faq);
        }
    }
    
    func generateStages(jsonArray: [NSObject]){
        for jsonObject in jsonArray{
            
            let coordinateX = jsonObject.value(forKey: "coordinateX") as! Double;
            let coordinateY = jsonObject.value(forKey: "coordinateY") as! Double;
            let coordinate = CLLocationCoordinate2D.init(latitude: coordinateX, longitude: coordinateY)
            
            let title = jsonObject.value(forKey: "title") as! String;
            let id = jsonObject.value(forKey: "id") as! Int;
            
            let stage = Stage.init(coordinate: coordinate, name: title, id: id)
            
            self.stageList.append(stage);
        }
        
    }
    
    func compareVersions(jsonArray: [NSObject]){
        let versionREST = jsonArray.last!
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Version");
        var versionCD: [Version]
        do{
            versionCD = try self.context.fetch(request) as! [Version];
            
            let idArtist = versionREST.value(forKey: "idArtist") as! Int16;
            let idFAQ = versionREST.value(forKey: "idFAQ") as! Int16;
            let idStage = versionREST.value(forKey: "idStage") as! Int16;
            let idFoodstand = versionREST.value(forKey: "idFoodstand") as! Int16;
            let id = versionREST.value(forKey: "id") as! Int16;
            
            
            if(versionCD.count == 0){
                print("no version loaded yet")
                let version:Version = Version(context: self.context);
                
                version.idArtist = idArtist
                version.idFAQ = idFAQ
                version.idStage = idStage
                version.idFoodstand = idFoodstand
                version.id = id
                
                self.accessRESTful(request: self.requestArtist)
                self.accessRESTful(request: self.requestFoodstands)
                self.accessRESTful(request: self.requestStages)
                self.accessRESTful(request: self.requestFAQ)
                
            }else if(idStage == versionCD[0].idStage && idFAQ == versionCD[0].idFAQ && idArtist == versionCD[0].idArtist && idFoodstand == versionCD[0].idFoodstand){
                print("versions matched")
            }else{
                if(idStage != versionCD[0].idStage){
                    self.accessRESTful(request: self.requestStages)
                }
                if(idFAQ != versionCD[0].idFAQ){
                    
                    self.accessRESTful(request: self.requestFAQ)
                }
                if(idArtist != versionCD[0].idArtist){
                    self.accessRESTful(request: self.requestArtist)
                    
                }
                if(idFoodstand != versionCD[0].idFoodstand){
                    self.accessRESTful(request: self.requestFoodstands)
                }
                
                print("versions didn't match")
                
                let deleteRequest = NSBatchDeleteRequest(fetchRequest: NSFetchRequest(entityName: "Version"))
                try self.context.execute(deleteRequest)
                
                let version:Version = Version(context: self.context);
                
                version.idArtist = idArtist
                version.idFAQ = idFAQ
                version.idStage = idStage
                version.idFoodstand = idFoodstand
                version.id = id
                
            }
            
            try self.context.save()
        }catch{}
    }
    
    func generateArtistlist(jsonArray: [NSObject]){
        for jsonObject in jsonArray{
            let name = jsonObject.value(forKey: "name") as! String;
            let stageID = jsonObject.value(forKey: "stageID") as! Int;
            let image = jsonObject.value(forKey: "image") as! String;
            let duration = jsonObject.value(forKey: "duration") as! Int;
            let id = jsonObject.value(forKey: "id") as! Int;
            
            let formater = DateFormatter.init();
            formater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss";
            var timeString = jsonObject.value(forKey: "time") as! String;
            var time = formater.date(from: timeString)
        
            var artist:Artist = Artist(name: name, stageID: stageID, time: time!, image: image, duration: duration, id: id)
            
            self.artistList.append(artist)
        }
        self.fetchPersonalLineUp();
    }

    
    //Get the personal Lineup from core data
    func fetchPersonalLineUp(){
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "PersonalLineUp")
        
        do{
            try personalLineUp = context.fetch(request) as! [PersonalLineUp];
            
        }catch{
            print("failed to get personal LineUp")
        }
        
        for artist in artistList {
            if(personalLineUp.contains(where: {$0.id == Int16(artist.id)})){
                artist.personal = true;
            }else{
                artist.personal = false;
            }
        }
    }
    
    func saveArtistInPersonalLineUp(artist: Artist){
        
        let personal = PersonalLineUp(context: context);
        
        personal.id = Int16(artist.id)
        
        do{
            try context.save();
        }catch{
            print("couldn't add artist to personal Line-Up")
        }
        
        personalLineUp.append(personal);
        artist.personal = true;
    }
    
    func deleteArtistInPersonalLineUp(artist: Artist){
        
        for (index, personalArtist) in personalLineUp.enumerated(){
            if(personalArtist.id == Int16(artist.id)){
                context.delete(personalArtist)
                personalLineUp.remove(at: index)
            }
        }
        
        do{
            try context.save();
        }catch{
            print("problem in deleting artist")
        }
        
        
        artist.personal = false;
    }
}


//    func version(){
//        //based on http://matteomanferdini.com/network-requests-rest-apis-ios-swift/
//        let session = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: OperationQueue.main)
//        let url = URL(string: "http://192.168.0.127:8080/Vistival/webresources/huygh.stijn.vistivalversion/1")!
//        let task = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
//            guard let data = data else {
//                return
//            }
//            guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as! NSObject else {
//                return
//            }
//            print("id")
//            print(jsonObject.value(forKey: "id"))
//            print("idArtist")
//            print(jsonObject.value(forKey: "idArtist"))
//            print("idFAQ")
//            print(jsonObject.value(forKey: "idFAQ"))
//            print("idFoodStand")
//            print(jsonObject.value(forKey: "idFoodstand"))
//            print("idStage")
//            print(jsonObject.value(forKey: "idStage"))
//        })
//        task.resume()
//
//    }

//                case self.requestNews:
//                    print(self.requestNews)
//                    for jsonObject  in jsonArray{
//                        let title = jsonObject.value(forKey: "title") as! String;
//                        let body = jsonObject.value(forKey: "body") as! String;
//                        let id = jsonObject.value(forKey: "id") as! Int;
//                        let img = jsonObject.value(forKey: "img") as! String;
//
//                        let newsItem:NewsFeed = NewsFeed.init(title: title, body: body, id: id, img: img);
//                        print(newsItem.title)
//                        self.newsList.append(newsItem);
//
//                    }

//    func makeArtistList(){
//        var time:Date;
//
//        //main stage
//        //Zaterdag
//        //18u15
//        time = Date.init(timeIntervalSince1970: 1533665700);
//        let artist1 = Artist.init(name: "Admiral Freebie", stageID: 0, time: time, image: "test", duration:45, id: 0);
//
//        //17u00
//        time = Date.init(timeIntervalSince1970: 1533661200);
//        let artist2 = Artist.init(name: "Blue Oyster Cult", stageID: 0, time: time, image: "test", duration:30, id: 1)
//
//
//        //19u30
//        time = Date.init(timeIntervalSince1970: 1533670200);
//        let artist3 = Artist.init(name: "Eels", stageID: 0, time: time, image: "test", duration:90, id: 2)
//
//        //Zondag
//        //18u00
//        time = Date.init(timeIntervalSince1970: 1533751200);
//        let artist4 = Artist.init(name: "Reel big Fish", stageID: 0, time: time, image: "test", duration: 45, id: 3)
//
//        //17u00
//        time = Date.init(timeIntervalSince1970: 1533747600);
//        let artist5 = Artist.init(name: "Funky Fish", stageID: 0, time: time, image: "test", duration: 50, id: 4)
//
//        //19u30
//        time = Date.init(timeIntervalSince1970: 1533756600);
//        let artist6 = Artist.init(name: "Moby Dick", stageID: 0, time: time, image: "test", duration: 75, id: 5)
//
//        //The shrimp
//        //Zaterdag
//        //18u15
//        time = Date.init(timeIntervalSince1970: 1533665700);
//        let artist7 = Artist.init(name: "Captain Winokio", stageID: 1, time: time, image: "test", duration: 30, id: 6);
//
//        //17u00
//        time = Date.init(timeIntervalSince1970: 1533661200);
//        let artist8 = Artist.init(name: "The pearl", stageID: 1, time: time, image: "test", duration: 60, id: 7)
//
//
//        //19u30
//        time = Date.init(timeIntervalSince1970: 1533670200);
//        let artist9 = Artist.init(name: "Dory", stageID: 1, time: time, image: "test", duration:50, id: 8)
//
//        //Zondag
//        //18u00
//        time = Date.init(timeIntervalSince1970: 1533751200);
//        let artist10 = Artist.init(name: "Shrimpnation", stageID: 1, time: time, image: "test", duration: 65, id: 9)
//
//        //17u00
//        time = Date.init(timeIntervalSince1970: 1533747600);
//        let artist11 = Artist.init(name: "Deep sea", stageID: 1, time: time, image: "test", duration: 85, id: 10)
//
//        //19u30
//        time = Date.init(timeIntervalSince1970: 1533756600);
//        let artist12 = Artist.init(name: "Harpooners", stageID: 1, time: time, image: "test", duration: 45, id: 11)
//
//        artistList.append(artist1);
//        artistList.append(artist2);
//        artistList.append(artist3);
//        artistList.append(artist4);
//        artistList.append(artist5);
//        artistList.append(artist6);
//        artistList.append(artist7);
//        artistList.append(artist8);
//        artistList.append(artist9);
//        artistList.append(artist10);
//        artistList.append(artist11);
//        artistList.append(artist12);
//
//    }

//    func makeFAQ(){
//
//        let faq1 = FAQ.init(title: "Mag ik zelf drinken meebrengen?", body: "Neen, er zijn foodstands aanwezig op het terein.")
//        let faq2 = FAQ.init(title: "Waar is Vistival?", body: "Havengeul, 8620, Nieuwpoort")
//        let faq3 = FAQ.init(title: "Is het Vistival betalend?", body: "Neen, de toegang is gratis.")
//        let faq4 = FAQ.init(title: "Wanneer vindt het festival plaats?", body: "07/08/2018 - 08/08/2018")
//        let faq5 = FAQ.init(title: "Lorem Ipsum", body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse vel mi malesuada, suscipit lacus vel, finibus nibh. Suspendisse faucibus vehicula facilisis. Morbi sagittis felis vel convallis scelerisque. Proin id auctor nibh, sed iaculis dui. Etiam malesuada urna diam, ac pretium ex varius at. Cras commodo sem eget tellus feugiat, vitae semper libero malesuada. Donec molestie et nisl non pulvinar. Suspendisse pellentesque, mi vel hendrerit bibendum, libero erat placerat dolor, sit amet porttitor enim felis sit amet leo. Integer a elit lectus. Integer eget quam facilisis, efficitur justo viverra, dignissim leo.\n Suspendisse nibh orci, ultrices a turpis quis, auctor sodales ligula. Ut rhoncus ligula eget condimentum vehicula. Integer varius, felis a congue finibus, ex est interdum velit, ut blandit sem neque sed metus. Aliquam viverra ipsum nec dolor finibus, ac tincidunt nunc ultrices. Nam sit amet risus dolor. Suspendisse ac rhoncus orci. Etiam feugiat eu diam feugiat bibendum. Morbi ligula est, aliquet vel euismod quis, malesuada sed enim. Integer at ullamcorper orci. Interdum et malesuada fames ac ante ipsum primis in faucibus. Donec vestibulum urna id porttitor aliquam. Nam euismod eget ligula eu porta.")
//
//        faqList.append(faq1);
//        faqList.append(faq2);
//        faqList.append(faq3);
//        faqList.append(faq4);
//        faqList.append(faq5);
//
//    }
//
//    func makeNewsList(){
//        let news1 = NewsFeed.init(title: "Vistival date announced", body: "Vistival gaat door van 07/08/2018 - 08/08/2018 te Havengeul, 8620, Nieuwpoort", id: 0, img:"placeholder.jpg")
//        let news2 = NewsFeed.init(title: "Admiral Freebie announced", body: "Admiral Freebie zal spelen op zondag 18u15", id: 1, img:"placeholder1.jpg")
//        let news3 = NewsFeed.init(title: "New names announced", body: "Zaterdag: Reel big Fish, Funky Fish \n Zondag: Blue Oyster Cult, Eels, The turtles", id: 2, img:"placeholder2.jpg")
//
//        newsList = [news1, news2, news3];
//    }
//
//    func makeStageList(){
//        let coordinateStage1 = CLLocationCoordinate2DMake(51.1527453940995, 2.72119494119528)
//        let stage1 = Stage.init(coordinate: coordinateStage1, name: "Main Stage", id: 0)
//
//        let coordinateStage2 = CLLocationCoordinate2DMake(51.1523911145087, 2.72000595039555)
//        let stage2 = Stage.init(coordinate: coordinateStage2, name: "The Shrimp", id: 1)
//
//        stageList.append(stage1);
//        stageList.append(stage2);
//
//        stageList.sort(by: {$0.id < $1.id})
//
//    }
//
//    func makeFoodCourt(){
//        let coordinateFoodStand1 = CLLocationCoordinate2DMake(51.1521800410752, 2.72010667319662)
//        let foodstand1 = FoodStand.init(coordinate: coordinateFoodStand1, name: "Shrimps", id: 1, descriptionFood: "Everything shrimp related")
//
//        let coordinateFoodStand2 = CLLocationCoordinate2DMake(51.1521238961145, 2.72022552130431)
//        let foodstand2 = FoodStand.init(coordinate: coordinateFoodStand2, name: "Bar", id: 2, descriptionFood: "Softdrinks, beer, wine, ....")
//
//        let coordinateFoodStand3 = CLLocationCoordinate2DMake(51.152176246496, 2.72035827763361)
//        let foodstand3 = FoodStand.init(coordinate: coordinateFoodStand3, name: "Burgers by John", id: 3, descriptionFood: "Burgers and more")
//
//        let coordinateFoodStand4 = CLLocationCoordinate2DMake(51.1522474374522, 2.72053969486354)
//        let foodstand4 = FoodStand.init(coordinate: coordinateFoodStand4, name: "De Nieuwe poort", id: 4, descriptionFood: "Specialiteiten uit Nieuwpoort")
//
//        let coordinateFoodStand5 = CLLocationCoordinate2DMake(51.1526295910231, 2.72024805522625)
//        let foodstand5 = FoodStand.init(coordinate: coordinateFoodStand5, name: "Bar", id: 5, descriptionFood: "Softdrinks, beer, wine, ....")
//
//        let coordinateFoodStand6 = CLLocationCoordinate2DMake(51.1527202756963, 2.72047071577353)
//        let foodstand6 = FoodStand.init(coordinate: coordinateFoodStand6, name: "Cocktails", id: 6, descriptionFood: "Shrimp cocktails")
//
//        foodCourt.append(foodstand1)
//        foodCourt.append(foodstand2)
//        foodCourt.append(foodstand3)
//        foodCourt.append(foodstand4)
//        foodCourt.append(foodstand5)
//        foodCourt.append(foodstand6)
//
//    }


