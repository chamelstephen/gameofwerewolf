//
//  ThirdViewController.swift
//  GameOfWerewolf
//
//  Created by kento on 2015/03/17.
//  Copyright (c) 2015年 Kento Ohara. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet var mytableview : UITableView!
    @IBOutlet var playerset : UIButton!
    
    // Tableで使用する配列を定義する.
    //var myPlayerItems: NSMutableArray = ["プレイヤー1", "プレーヤー2", "プレイヤー3"]
    var myPlayerArray: [String] = ["プレイヤー1", "プレイヤー2", "プレイヤー3"]
    
    // Sectionで使用する配列を定義する.
    var myPlayerSections: [String] = ["Players"]
    
    let appdelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    //var VotedCountDataArray: [String] = []
    
    //var VotedCountDataInt: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        mytableview.delegate = self
        mytableview.dataSource = self
        mytableview.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        
        var width: CGFloat = self.view.bounds.width
        var height: CGFloat = self.view.bounds.height
        
        //print("プレイヤー人数:\(myPlayerItems.count)")
        print("プレイヤー人数:\(myPlayerArray.count)")
        
        let playerxib = UINib(nibName: "PlayerItemsTableViewCell", bundle: nil)
        mytableview.registerNib(playerxib, forCellReuseIdentifier: "MyCell")
        
        //let playerdata = NSUserDefaults.standardUserDefaults()
        
        //print("\(myPlayerItems)")
        print("\(myPlayerArray)")
        
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
    
    /*
    Cellが選択された際に呼び出される.
    */
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
            if indexPath.section == 0 {
                print("0")
            } else if indexPath.section == 1 {
                print("1")
            } else if indexPath.section == 2 {
                print("2")
            }
        
    }

    
    /*
    テーブルに表示する配列の総数を返す.
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return myPlayerItems.count
        return myPlayerArray.count
        
    }
    
    /*
    Cellに値を設定する.
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as! PlayerItemsTableViewCell
        
        cell.RowNumberLabel?.text = "\(indexPath.row+1)"
        
        
        cell.NameTextField!.delegate = self
        cell.NameTextField!.borderStyle = UITextBorderStyle.RoundedRect
        cell.NameTextField!.returnKeyType = UIReturnKeyType.Done
        //cell.NameTextField!.text = "\(myPlayerItems[indexPath.row])"
        cell.NameTextField!.text = "\(myPlayerArray[indexPath.row])"
        cell.NameTextField!.layer.borderColor = UIColor.blackColor().CGColor
        //文字数制限
        
        cell.NameTextField!.tag = indexPath.row //textfieldにtagをつけることで、何番目のtextfieldかがわかる
        
        cell.PlayerImageView.userInteractionEnabled = true
        let PlayerImagetap = UITapGestureRecognizer (target: self, action: "imagetaped:")
        cell.PlayerImageView.addGestureRecognizer(PlayerImagetap)
        
        return cell
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        //myPlayerItems[textField.tag] = "\(textField.text!)"
        myPlayerArray[textField.tag] = "\(textField.text!)"
        
        //print("\(myPlayerItems)")
        print("\(myPlayerArray)")
        
        return
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print(textField.text)
        //配列myPlayerItemsに入力したテキストを入れかえる
        
        //selectedのcellを把握＞textをmyplayeritemsに代入して入れ替え
        //myPlayerItems[textField.tag] = "\(textField.text!)"
        myPlayerArray[textField.tag] = "\(textField.text!)"
        
        //print("\(myPlayerItems)")
        print("\(myPlayerArray)")
        
        return true
        
    }
    
    
    
    func imagetaped(sender: UITapGestureRecognizer) {
        //写真に接続
        print("写真に接続")
    }
    
    /*
    編集ボタンが押された際に呼び出される
    */
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        // TableViewを編集可能にする
        mytableview.setEditing(editing, animated: true)
        
        // 編集中のときのみaddButtonをナビゲーションバーの左に表示する
        if editing {
            print("編集中")
            let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addCell:")
            self.navigationItem.setLeftBarButtonItem(addButton, animated: true)
        } else {
            print("通常モード")
            self.navigationItem.setLeftBarButtonItem(nil, animated: true)
        }
        
    }
    
    /*
    addButtonが押された際呼び出される
    */
    func addCell(sender: AnyObject) {
        print("追加")
        
        // myItemsに追加.
        
        //myPlayerItems.addObject("プレイヤー")
        myPlayerArray.append("プレイヤー")
        
        // TableViewを再読み込み.
        mytableview.reloadData()
        
    }
    
    /*
    Cellを挿入または削除しようとした際に呼び出される
    */
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        // 削除のとき.
        if editingStyle == UITableViewCellEditingStyle.Delete {
            print("削除")
            
            // 指定されたセルのオブジェクトをmyItemsから削除する.
            //myPlayerItems.removeObjectAtIndex(indexPath.row)
            myPlayerArray.removeAtIndex(indexPath.row)
            
            // TableViewを再読み込み.
            mytableview.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        // 削除
        let delete = UITableViewRowAction(style: .Default, title: "削除") {
            (action, indexPath) in
            
            //self.myPlayerItems.removeObjectAtIndex(indexPath.row)
            self.myPlayerArray.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        
        delete.backgroundColor = UIColor.redColor()
        
        return [delete]
    }
    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        /*
        let tmp: AnyObject = myPlayerItems[sourceIndexPath.row]
        myPlayerItems.removeObjectAtIndex(sourceIndexPath.row)
        myPlayerItems.insertObject(tmp, atIndex: destinationIndexPath.row)
        */
        
        let tmpString: String = myPlayerArray[sourceIndexPath.row]
        myPlayerArray.removeAtIndex(sourceIndexPath.row)
        myPlayerArray.insert(tmpString, atIndex: destinationIndexPath.row)
        
        mytableview.reloadData()
    }
    
    @IBAction func next()  {
        //print("myPlayerItems:\(myPlayerItems)")
        print("myPlayerArray:\(myPlayerArray)")
        
        appdelegate.arraydefault = myPlayerArray
        //appdelegate.playerarray = myPlayerArray
        
        //appdelegate.arraydefault = myPlayerItems as! [String]
        //appdelegate.playerarray = myPlayerItems as! [String]
        
        //print("プレイヤー人数:\(myPlayerItems.count)")
        print("プレイヤー人数:\(myPlayerArray.count)")
        
        //print("appdelegate.playerarray:\(appdelegate.playerarray.count)")
        print("appdelegate.arraydefault:\(appdelegate.arraydefault.count)")
        
        let playerData = NSUserDefaults.standardUserDefaults()
        playerData.setObject(myPlayerArray, forKey: "player")
        //playerData.setObject(myPlayerItems, forKey: "player")
        
        /*
        let playervotedDataArray = NSUserDefaults.standardUserDefaults()
        playervotedDataArray.setObject((myPlayerItems), forKey: "voterDataArray")
        */
        
        /*
        VotedCountDataInt = myPlayerItems.count
        
        while VotedCountDataInt > 0 {
            
            VotedCountDataArray.append("VotedDataNumberInt Player(\(VotedCountDataInt))")
            
            VotedCountDataInt = VotedCountDataInt - 1
        }
        
        print("\(VotedCountDataArray)")
        
        let playerVotedDataArray = NSUserDefaults.standardUserDefaults()
        playerVotedDataArray.setObject((VotedCountDataArray), forKey: "CountDataArray")//ここで保存している。名前を保存。

        */
        
        
        
        if /*myPlayerItems.count < 11 && myPlayerItems.count > 2*/ myPlayerArray.count < 11 && myPlayerArray.count > 2 {
            performSegueWithIdentifier("toyakushoku", sender: nil)
        } else {
            let alert = UIAlertController(title: "注意", message: "プレイヤーの数を３以上１０以下にしてください", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(defaultAction)
            
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "toyakushoku") {
            
           // let param: Int =
            // SecondViewControllerクラスをインスタンス化してsegue（画面遷移）で値を渡せるようにバンドルする
            let workView : ForthViewController = segue.destinationViewController as! ForthViewController
            // secondView（バンドルされた変数）に受け取り用の変数を引数とし_paramを渡す（_paramには渡したい値）
            // この時SecondViewControllerにて受け取る同型の変数を用意しておかないとエラーになる
            workView.countplayer = myPlayerArray.count
            //workView.countplayer = myPlayerItems.count
        }
    }
    
    //セル追加後に名前が消える
    
    
    //storyboardでtableviewを選択〜ベースからselection〜no selectionを選択〜cellが選択されない
}