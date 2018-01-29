//
//  ImportData.swift
//  Vistival
//
//  Created by Stijn Huygh on 29/01/2018.
//  Copyright © 2018 Stijn Huygh. All rights reserved.
//

import Foundation

public class ImportData{
    
    var faqList:[FAQ] = [FAQ]();
    var newsList:[NewsFeed] = [NewsFeed]();
    var artistList:[Artist] = [Artist]();
    var stageList:[Stage] = [Stage]();
    var foodCourt:[FoodStand] = [FoodStand]();
    
    static let data:ImportData = ImportData();
    
    init() {
        
    }
    
    func fillAllData(){
        self.makeFAQ();
        self.makeNewsList();
        self.makeFoodCourt();
        self.makeStageList();
        self.makeArtistList();
    }
    
    func makeFAQ(){
        
        let faq1 = FAQ.init(title: "Mag ik zelf drinken meebrengen?", body: "Neen, er zijn foodstands aanwezig op het terein.")
        let faq2 = FAQ.init(title: "Waar is Vistival?", body: "Havengeul, 8620, Nieuwpoort")
        let faq3 = FAQ.init(title: "Is het Vistival betalend?", body: "Neen, de toegang is gratis.")
        let faq4 = FAQ.init(title: "Wanneer vindt het festival plaats?", body: "07/08/2018 - 08/08/2018")
        let faq5 = FAQ.init(title: "Lorem Ipsum", body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse vel mi malesuada, suscipit lacus vel, finibus nibh. Suspendisse faucibus vehicula facilisis. Morbi sagittis felis vel convallis scelerisque. Proin id auctor nibh, sed iaculis dui. Etiam malesuada urna diam, ac pretium ex varius at. Cras commodo sem eget tellus feugiat, vitae semper libero malesuada. Donec molestie et nisl non pulvinar. Suspendisse pellentesque, mi vel hendrerit bibendum, libero erat placerat dolor, sit amet porttitor enim felis sit amet leo. Integer a elit lectus. Integer eget quam facilisis, efficitur justo viverra, dignissim leo.\n Suspendisse nibh orci, ultrices a turpis quis, auctor sodales ligula. Ut rhoncus ligula eget condimentum vehicula. Integer varius, felis a congue finibus, ex est interdum velit, ut blandit sem neque sed metus. Aliquam viverra ipsum nec dolor finibus, ac tincidunt nunc ultrices. Nam sit amet risus dolor. Suspendisse ac rhoncus orci. Etiam feugiat eu diam feugiat bibendum. Morbi ligula est, aliquet vel euismod quis, malesuada sed enim. Integer at ullamcorper orci. Interdum et malesuada fames ac ante ipsum primis in faucibus. Donec vestibulum urna id porttitor aliquam. Nam euismod eget ligula eu porta.")
        
        faqList.append(faq1);
        faqList.append(faq2);
        faqList.append(faq3);
        faqList.append(faq4);
        faqList.append(faq5);
        
    }
    
    func makeNewsList(){
        let news1 = NewsFeed.init(title: "Vistival date announced", body: "Vistival gaat door van 07/08/2018 - 08/08/2018 te Havengeul, 8620, Nieuwpoort", id: 0)
        let news2 = NewsFeed.init(title: "Admiral Freebie announced", body: "Admiral Freebie zal spelen op zondag 18u15", id: 1)
        let news3 = NewsFeed.init(title: "New names announced", body: "Zaterdag: Reel big Fish, Funky Fish \n Zondag: Blue Oyster Cult, Eels, The turtles", id: 2)
        
        newsList = [news1, news2, news3];
    }
    
    func makeArtistList(){
        var time:Date;
        
        //main stage
        //Zaterdag
        //18u15
        time = Date.init(timeIntervalSince1970: 1533665700);
        let artist1 = Artist.init(name: "Admiral Freebie", stageID: 1, time: time, image: "test", duration:45);
        
        //17u00
        time = Date.init(timeIntervalSince1970: 1533661200);
        let artist2 = Artist.init(name: "Blue Oyster Cult", stageID: 1, time: time, image: "test", duration:30)
        
        
        //19u30
        time = Date.init(timeIntervalSince1970: 1533670200);
        let artist3 = Artist.init(name: "Eels", stageID: 1, time: time, image: "test", duration:90)
        
        //Zondag
        //18u00
        time = Date.init(timeIntervalSince1970: 1533751200);
        let artist4 = Artist.init(name: "Reel big Fish", stageID: 1, time: time, image: "test", duration: 45)
        
        //17u00
        time = Date.init(timeIntervalSince1970: 1533747600);
        let artist5 = Artist.init(name: "Funky Fish", stageID: 1, time: time, image: "test", duration: 50)
        
        //19u30
        time = Date.init(timeIntervalSince1970: 1533756600);
        let artist6 = Artist.init(name: "Moby Dick", stageID: 1, time: time, image: "test", duration: 75)
        
        //The shrimp
        //Zaterdag
        //18u15
        time = Date.init(timeIntervalSince1970: 1533665700);
        let artist7 = Artist.init(name: "Captain Winokio", stageID: 2, time: time, image: "test", duration: 30);
        
        //17u00
        time = Date.init(timeIntervalSince1970: 1533661200);
        let artist8 = Artist.init(name: "The pearl", stageID: 2, time: time, image: "test", duration: 60)
        
        
        //19u30
        time = Date.init(timeIntervalSince1970: 1533670200);
        let artist9 = Artist.init(name: "Dory", stageID: 2, time: time, image: "test", duration:50)
        
        //Zondag
        //18u00
        time = Date.init(timeIntervalSince1970: 1533751200);
        let artist10 = Artist.init(name: "Shrimpnation", stageID: 2, time: time, image: "test", duration: 65)
        
        //17u00
        time = Date.init(timeIntervalSince1970: 1533747600);
        let artist11 = Artist.init(name: "Deep sea", stageID: 2, time: time, image: "test", duration: 85)
        
        //19u30
        time = Date.init(timeIntervalSince1970: 1533756600);
        let artist12 = Artist.init(name: "Harpooners", stageID: 2, time: time, image: "test", duration: 45)
        
        artistList.append(artist1);
        artistList.append(artist2);
        artistList.append(artist3);
        artistList.append(artist4);
        artistList.append(artist5);
        artistList.append(artist6);
        artistList.append(artist7);
        artistList.append(artist8);
        artistList.append(artist9);
        artistList.append(artist10);
        artistList.append(artist11);
        artistList.append(artist11);
        
    }
    
    func makeStageList(){
        
    }
    
    func makeFoodCourt(){
        
    }
}

