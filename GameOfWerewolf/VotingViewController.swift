//
//  VotingViewController.swift
//  GameOfWerewolf
//
//  Created by kento on 2015/06/27.
//  Copyright (c) 2015年 Kento Ohara. All rights reserved.
//

import UIKit

class VotingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var myPlayerItems: [String] = []//投票済みのプレイヤーから削除していく
    var votedplayerItems: [String] = []//投票中のプレイヤーのみ削除。投票候補の表示に使う
    var votingplayer: NSString = ""//投票中のプレイヤー名を挿入
    
    var allPlayerItems: [String] = []//全プレイヤーを表示
    
    
    var appdelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    let playerData3 = NSUserDefaults.standardUserDefaults()
    
    var VotedCountDataArray: [String] = []//？？目的不明。不使用。
    var playerVotedDataArray = NSUserDefaults.standardUserDefaults()//VotedCountArrayを代入し、保存
    
    var VotedCountArray: [String] = []//ここに投票した相手の名前を入れる[①が投票した人,②が投票した人,,]
    var VotedCountIntArray: [Int] = [0,0,0,0,0,0,0,0,0,0] //[①に入った票数,②に入った票数,,]
    
    var voteCheckArray: [String] = []//print用
    
    @IBOutlet var votingplayertable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        allPlayerItems = playerData3.arrayForKey("player")! as! [String]
        playerData3.setObject(allPlayerItems, forKey: "allPlayers")//次の画面に継承
        print ("プレイヤー一覧：\(allPlayerItems)")
        votedplayerItems = allPlayerItems
        
        myPlayerItems = appdelegate.votercounterarray
        //votedplayerItems = appdelegate.votetableviewarray
        
        if myPlayerItems.count == 0 {
            myPlayerItems = playerData3.arrayForKey("player")! as! [String]
            
        }//初回はここでNSDefaultsからプレイヤーの名前を配列に入れる。次回からは投票を済ませたプレイヤーの名前が削除されたappdelegate.voterarrayが挿入される。→→投票しているプレイヤーをプレイヤー一覧から削除する。
        
        print("myPlayerItems==\(myPlayerItems)")
        print("votedplayerItems==\(votedplayerItems)")
        
        
        votingplayertable.delegate = self
        votingplayertable.dataSource = self
        votingplayertable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "VotingCell")
        
        let votingxib = UINib(nibName: "VotingTableViewCell", bundle: nil)
        votingplayertable.registerNib(votingxib, forCellReuseIdentifier: "VotingCell")
        
        votingplayer = myPlayerItems[0] as NSString//投票している人
        
        myPlayerItems.removeAtIndex(0)//投票している人を削除
        
        votedplayerItems.removeAtIndex((allPlayerItems.count)-(myPlayerItems.count)-1)//([0]=votingplayer)投票しているプレイヤーを削除
        //votedplayerItemsの削除対象はmyPlayerItems.countの数から割り出せばよい。[allplayerItems.count-myplayerItems.count-1]番目を削除するのだ。
        
        appdelegate.votercounterarray = myPlayerItems//次回のmyPlayerItemsには一人減らされた状態で挿入される。
        
        if myPlayerItems.count == 0 {
            
        } else {
            print("次の投票者:\(myPlayerItems[0])")
        }
        
        
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
        
        let votecheckalert = UIAlertController(title: "投票確認", message: "あなたは\(votedplayerItems[indexPath.row])さんに投票しますか？", preferredStyle: .Alert)
        
        print("投票選択者：\(votedplayerItems[indexPath.row])")
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "いいえ", style: .Cancel, handler: {(action: UIAlertAction)
            -> Void in
            
            print("キャンセル")
        })
        
        let defaltAction: UIAlertAction = UIAlertAction(title: "はい", style: .Default, handler: {(action: UIAlertAction) -> Void in
            
            
            //VotedCountDataArray = playerVotedDataArray.objectForKey("CountDataArray")! as! [String]//エラー解除？
            
            if self.allPlayerItems[0] == self.votingplayer {
                //初回はこっち
                //初回は"votedPlayer"が定義されない
            } else {
            self.VotedCountArray = self.playerVotedDataArray.arrayForKey("votedPlayer")! as! [String]//前回までのプレイヤーの投票情報をVotedCountArrayに挿入
                //初回以外はこっち。
                
            self.VotedCountIntArray = self.playerVotedDataArray.arrayForKey("votedIntPlayer")! as! [Int]//[Int]配列の保存情報をVotedCountIntArrayに入れる
            }
            
            self.VotedCountArray.append("\(self.votedplayerItems[indexPath.row])")//プレイヤーの被投票者名を追加
            print("投票が決定しました。対象は：\(self.votedplayerItems[indexPath.row])")
            print("投票履歴：\(self.VotedCountArray)")
            
            self.playerVotedDataArray.setObject(self.VotedCountArray, forKey: "votedPlayer")//前回まで+今回の投票情報をplayerVotedDataArrayに保存
            
            //Int配列の投票情報をチェック
            print("\(self.VotedCountIntArray)")
            
            //Int配列の投票情報を操作
            let playernumbercount: Int = (self.allPlayerItems.count - self.myPlayerItems.count - 1)
            if playernumbercount > indexPath.row {
                let votenumbercount: Int = self.VotedCountIntArray[indexPath.row]
                self.VotedCountIntArray[indexPath.row] = (votenumbercount + 1)
            } else {
                let votenumbercount: Int = self.VotedCountIntArray[indexPath.row+1]
                self.VotedCountIntArray[indexPath.row+1] = (votenumbercount + 1)
            }
            
            self.playerVotedDataArray.setObject(self.VotedCountIntArray, forKey: "votedIntPlayer")//Intの投票情報の配列を保存
            print("\(self.VotedCountIntArray)")
            print("\(self.playerVotedDataArray.arrayForKey("votedIntPlayer"))")
            
            /*
            self.playerVotedDataArray.synchronize()
            */
            self.voteCheckArray = self.playerVotedDataArray.arrayForKey("votedPlayer")! as! [String]
            print("NSDefaultに保存された投票履歴：\(self.voteCheckArray)")

            
            if self.myPlayerItems.count == 0 {
                let targetView = self.storyboard?.instantiateViewControllerWithIdentifier("gopunishing")
                self.presentViewController(targetView!, animated: true, completion: nil)
                    
                self.votedplayerItems.append("\(self.votingplayer)")
                
            } else {
                let targetView = self.storyboard?.instantiateViewControllerWithIdentifier("prevoting")
                self.presentViewController(targetView!, animated: true, completion: nil)
                
                /*
                self.votedplayerItems.append("\(self.votingplayer)")
                self.appdelegate.votercounterarray = self.myPlayerItems
                */
                //viewDidLoadで似た処理をしているので、コメントアウト（１月９日）
                //defaultAction error:unexpectedly found nil while unwrapping an Optional value
                
            }
            
            
            print("オッケー")
        })
        
        votecheckalert.addAction(cancelAction)
        votecheckalert.addAction(defaltAction)
        
        presentViewController(votecheckalert, animated: true, completion: nil)
    
    }
    
    /*
    テーブルに表示する配列の総数を返す.
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("tableviewcellの総数=\(votedplayerItems.count)")
        return (votedplayerItems.count)
        
    }
    
    /*
    Cellに値を設定する.
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("VotingCell", forIndexPath: indexPath) as! VotingTableViewCell
        
        cell.numberLabel!.text = "\(indexPath.row+1)"
        
        cell.NameLabel!.text = "\(votedplayerItems[indexPath.row])さん"
        
        return cell
        
    }

}
