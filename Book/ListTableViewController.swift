//
//  ViewController.swift
//  Book
//
//  Created by takafumi oosugi on 2016/02/21.
//  Copyright © 2016年 myname. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    var bookArray: [AnyObject] = []
    let saveData = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "ListTableViewCell", bundle:
            nil), forCellReuseIdentifier: "cell")
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if saveData.arrayForKey("BOOK") != nil {
            bookArray = saveData.arrayForKey("BOOK")!
        }
        tableView.reloadData()
    }
    
    //セクション数の設定
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //セルの個数指定
    override func tableView(tableView: UITableView, numberOfRowsInSection section:
        Int) -> Int {
            return bookArray.count
    }
    
    //セルの中身の表示の仕方
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:
        NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath:
                indexPath) as! ListTableViewCell
            
            let nowIndexPathDictionary: (AnyObject) = bookArray[indexPath.row]
            
            cell.titleLabel.text = nowIndexPathDictionary["title"] as? String
            cell.authorLabel.text = nowIndexPathDictionary["author"] as? String
            cell.genreLabel.text = nowIndexPathDictionary["genre"] as? String
//            cell.recommendLabel.text = nowIndexPathDictionary["recommend"] as? String
            
            return cell
    }
    

    // Cell が選択された場合
    override func tableView(table: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
                    // SubViewController へ遷移するために Segue を呼び出す
            performSegueWithIdentifier("toSubViewController",sender: nil)
        
    }
    
    // Segue 準備
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "toSubViewController") {
                }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}




























