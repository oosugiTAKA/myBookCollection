//
//  SubViewController.swift
//  Book
//
//  Created by takafumi oosugi on 2016/02/23.
//  Copyright © 2016年 myname. All rights reserved.
//

import UIKit

class SubViewController: UIViewController {
    
   
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var recommendLabel: UILabel!
    @IBOutlet weak var memoLabel: UILabel!
    
    var bookArray: [AnyObject] = []



    var cellNumber: Int = 0
    let saveData = NSUserDefaults.standardUserDefaults()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        bookArray = saveData.arrayForKey("BOOK")!
        
        //letのところでappDelegate変数定義？
//        let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
//        cellNumber = appDelegate.cellNum
        self.titleLabel.text = self.bookArray[cellNumber]["title"] as? String
        self.authorLabel.text = self.bookArray[cellNumber]["author"] as? String
        self.genreLabel.text = self.bookArray[cellNumber]["genre"] as? String
        self.recommendLabel.text = self.bookArray[cellNumber]["recommend"] as? String
        self.memoLabel.text = self.bookArray[cellNumber]["memo"] as? String
        
//        titleLabel.text = bookArray[cellNumber]["title"] as? String
//        authorLabel.text = bookArray[cellNumber]["author"] as? String
//        genreLabel.text = bookArray[cellNumber]["genre"] as? String
//        recommendLabel.text = bookArray[cellNumber]["recommend"] as? String
//        memoLabel.text = bookArray[cellNumber]["memo"] as? String

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
