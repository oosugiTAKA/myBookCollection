//
//  AddViewController.swift
//  Book
//
//  Created by takafumi oosugi on 2016/02/21.
//  Copyright © 2016年 myname. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextFieldDelegate {
    
   //文書表示用TextField
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var authorTextField: UITextField!
    @IBOutlet var genreTextField: UITextField!
    @IBOutlet var recommendTextField: UITextField!
    @IBOutlet var memoTextField: UITextField!
    @IBOutlet weak var bookImageView: UIImageView!
    
    @IBOutlet weak var scvBackGround: UIScrollView!
    
    var txtActiveField = UITextField()
    var image: UIImage!
    var bookArray: [AnyObject] = []
    let bookDictionary: [Any] = []
    let saveData = NSUserDefaults.standardUserDefaults()
    
    
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


    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        txtActiveField = textField
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    
    
    func handleKeyboardWillShowNotification(notification: NSNotification) {
        
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let myBoundSize: CGSize = UIScreen.mainScreen().bounds.size
        
        let txtLimit = txtActiveField.frame.origin.y + txtActiveField.frame.height + 8.0
        let kbdLimit = myBoundSize.height - keyboardScreenEndFrame.size.height
        
        print("テキストフィールドの下辺：\(txtLimit)")
        print("キーボードの上辺：\(kbdLimit)")
        
        if txtLimit >= kbdLimit {
            scvBackGround.contentOffset.y = txtLimit - kbdLimit
        }
    }
    
    func handleKeyboardWillHideNotification(notification: NSNotification) {
        scvBackGround.contentOffset.y = 0
    }
    
    
    override func viewDidLoad() {//最初に画面が呼び出された時どんな動作をするか決めるもの
        super.viewDidLoad()
        
        
        titleTextField.delegate = self
        authorTextField.delegate = self
        genreTextField.delegate = self
        recommendTextField.delegate = self
        memoTextField.delegate = self
        
        // Do any additional setup after loading the view.
        
        //NSUserDefaultsから配列の読み込み
        if saveData.arrayForKey("BOOK") != nil {
            bookArray = saveData.arrayForKey("BOOK")!
        }
    }
    
    
    
//    func textFieldShouldReturn(textField: UITextField) -> Bool{
//        
//        // キーボードを閉じる
//        textField.resignFirstResponder()
//        
//        return true
//    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //保存ボタンが押された時のsaveWord()メソッドの記述
    @IBAction func saveWord() {
        
        let imageData = bookImageView.image
        let data = UIImagePNGRepresentation(imageData!)
        
        saveData.setObject(data, forKey:"image")
        saveData.synchronize()
        print(saveData.arrayForKey("image"))
        
        let bookDictionary = ["title":titleTextField.text!, "author":authorTextField.text!, "genre":genreTextField.text!,"recommend":recommendTextField.text!,"memo":memoTextField.text!, "image":data! as NSData]
        
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
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "handleKeyboardWillShowNotification:", name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: "handleKeyboardWillHideNotification:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
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
