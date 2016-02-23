//
//  SubViewController.swift
//  Book
//
//  Created by takafumi oosugi on 2016/02/23.
//  Copyright © 2016年 myname. All rights reserved.
//

import UIKit

class SubViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var recommendLabel: UILabel!
    @IBOutlet var memoLabel: UILabel!
    
    var cellNumber: Int = 0
    let saveData = NSUserDefaults.standardUserDefaults()
    var bookArray: [AnyObject] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        bookArray = saveData.arrayForKey("BOOK")!
        
        titleLabel.text = bookArray[cellNumber]["title"] as? String
        authorLabel.text = bookArray[cellNumber]["author"] as? String
        genreLabel.text = bookArray[cellNumber]["genre"] as? String
        recommendLabel.text = bookArray[cellNumber]["recommend"] as? String
        memoLabel.text = bookArray[cellNumber]["memo"] as? String

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
