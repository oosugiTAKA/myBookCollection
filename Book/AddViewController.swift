//
//  AddViewController.swift
//  Book
//
//  Created by takafumi oosugi on 2016/02/21.
//  Copyright © 2016年 myname. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
   //文書表示用TextField
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var authorTextField: UITextField!
    @IBOutlet var genreTextField: UITextField!
    @IBOutlet var recommendTextField: UITextField!
    @IBOutlet var memoTextField: UITextField!
    
    var bookArray: [AnyObject] = []
    let saveData = NSUserDefaults.standardUserDefaults()
    
    //写真表示用ImageView
    @IBOutlet weak var bookImageView: UIImageView!
    
    
    //カメラ、アルバムの呼び出しメソッド
    func precentPickerController(sourceType: UIImagePickerControllerSourceType) {
        //ライブラリの使用できるか判断
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            
            //UIImagePickerControllerをインスタンス化
            let picker = UIImagePickerController()
            
            //ソースタイプを設定
            picker.sourceType = sourceType
            
            //デリゲートを設定
            picker.delegate = self
            self.presentViewController(picker, animated: true, completion: nil)
        }
    }
    
    //写真が選択されたときのメソッド
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo:
        NSDictionary!) {
            self.dismissViewControllerAnimated(true, completion: nil)
            
            //画像出力
            bookImageView.image = image
    }
    
    //写真を登録してくださいを押したときに呼び出されるメソッド
    @IBAction func selectButtonTapped(sender: UIButton) {
        
        //選択肢の上に表示するタイトル、メッセージ、アラートタイプの設定
        let alertController = UIAlertController(title: "画像の取得先を選択", message: nil,preferredStyle: .ActionSheet)
        
        //選択肢の名前と処理を1つずつ設定
        let firstAction = UIAlertAction(title: "カメラ", style: .Default) {
            action in
            self.precentPickerController(.Camera)
        }
        let secondAction = UIAlertAction(title: "アルバム", style: .Default) {
            action in
            self.precentPickerController(.PhotoLibrary)
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .Cancel, handler: nil)
        
        //設定した選択肢をアラートに登録
        alertController.addAction(firstAction)
        alertController.addAction(secondAction)
        alertController.addAction(cancelAction)
        
        //アラートを表示
        presentViewController(alertController, animated: true, completion: nil)
    }


    
    override func viewDidLoad() {//最初に画面が呼び出された時どんな動作をするか決めるもの
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //NSUserDefaultsから配列の読み込み
        if saveData.arrayForKey("BOOK") != nil {
            bookArray = saveData.arrayForKey("BOOK")!
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //保存ボタンが押された時のsaveWord()メソッドの記述
    @IBAction func saveWord() {
        let bookDictionary =
        //"image":photoImageView.image!,
        ["image":bookImageView.image!, "title":titleTextField.text!, "author":authorTextField.text!, "genre":genreTextField.text!,
            "recommend":recommendTextField.text!, "memo":memoTextField.text!]
        
        bookArray.append (bookDictionary)
        saveData.setObject(bookArray, forKey: "BOOK")
        
        //メッセージの表示
        let alert = UIAlertController(
            title: "保存完了",
            message: "本の登録が完了しました",
            preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: UIAlertActionStyle.Default,
                handler:nil
            )
        )
        //登録し終わった時に画面の表示
        self.presentViewController(alert, animated: true, completion:nil)
        titleTextField.text = ""
        authorTextField.text = ""
        genreTextField.text = ""
        recommendTextField.text = ""
        memoTextField.text = ""

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
