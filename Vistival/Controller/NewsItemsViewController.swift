//
//  NewsItemsViewController.swift
//  Vistival
//
//  Created by Daan Demeulemeester on 30/01/2018.
//  Copyright © 2018 Stijn Huygh. All rights reserved.
//

import UIKit

class NewsItemsViewController: UIViewController {

    @IBOutlet weak var lblImage: UIImageView!
    @IBOutlet weak var lblDetailTxt: UITextView!
    @IBOutlet weak var lblTitle: UILabel!
    var currentItem:NewsFeed?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblTitle.text = currentItem?.title
        lblDetailTxt.text = currentItem?.body
        lblImage.image = UIImage.init(named: (currentItem?.img)!)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func dismiss() {
        dismiss(animated: true, completion: nil)

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
