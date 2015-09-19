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
    var myPlayerItems: NSMutableArray = ["プレイヤー１", "プレーヤー２", "プレイヤー３"]
    
    // Sectionで使用する配列を定義する.
    var myPlayerSections: [String] = ["Players"]
    
    var appdelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        mytableview.delegate = self
        mytableview.dataSource = self
        mytableview.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        
        var width: CGFloat = self.view.bounds.width
        var height: CGFloat = self.view.bounds.height
        
        /*
        
        println("myPlayerSections:\(myPlayerSections)")
        
        println("\(myPlayerSections.count)")
*/
        
        print("プレイヤー人数:\(myPlayerItems.count)")
        
        let playerxib = UINib(nibName: "PlayerItemsTableViewCell", bundle: nil)
        mytableview.registerNib(playerxib, forCellReuseIdentifier: "MyCell")
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
    /*
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
            if indexPath.section == 0 {
                return nil
            } else if indexPath.section == 1 {
                return nil
            } else if indexPath.section == 2 {
                return nil
            }
        
    }
    */
    
    /*
    テーブルに表示する配列の総数を返す.
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPlayerItems.count
        
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
        cell.NameTextField!.text = "プレイヤー\(indexPath.row+1)"
        cell.NameTextField!.layer.borderColor = UIColor.blackColor().CGColor
        //文字数制限
        
        cell.PlayerImageView.userInteractionEnabled = true
        let PlayerImagetap = UITapGestureRecognizer (target: self, action: "imagetaped:")
        cell.PlayerImageView.addGestureRecognizer(PlayerImagetap)
        
        return cell
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
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
        
        myPlayerItems.addObject("プレイヤー")
        
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
            myPlayerItems.removeObjectAtIndex(indexPath.row)
            
            // TableViewを再読み込み.
            mytableview.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        // 削除
        let delete = UITableViewRowAction(style: .Default, title: "削除") {
            (action, indexPath) in
            
            self.myPlayerItems.removeObjectAtIndex(indexPath.row)
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
        let tmp: AnyObject = myPlayerItems[sourceIndexPath.row]
        myPlayerItems.removeObjectAtIndex(sourceIndexPath.row)
        myPlayerItems.insertObject(tmp, atIndex: destinationIndexPath.row)
        
        mytableview.reloadData()
    }
    
    @IBAction func next()  {
        if myPlayerItems.count < 11 && myPlayerItems.count > 2 {
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
            
            appdelegate.arraydefault = myPlayerItems
            appdelegate.playerarray = myPlayerItems
            
            print("プレイヤー人数:\(myPlayerItems.count)")
            print("appdelegate.playerarray:\(appdelegate.playerarray.count)")
            print("appdelegate.arraydefault:\(appdelegate.arraydefault.count)")
            
            let param: Int = myPlayerItems.count
            // SecondViewControllerクラスをインスタンス化してsegue（画面遷移）で値を渡せるようにバンドルする
            let workView : ForthViewController = segue.destinationViewController as! ForthViewController
            // secondView（バンドルされた変数）に受け取り用の変数を引数とし_paramを渡す（_paramには渡したい値）
            // この時SecondViewControllerにて受け取る同型の変数を用意しておかないとエラーになる
            workView.countplayer = param
        }
    }
    
    //選択不可
    //セル追加後に名前が消える
    
        
}