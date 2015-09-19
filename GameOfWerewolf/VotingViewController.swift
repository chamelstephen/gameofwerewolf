//
//  VotingViewController.swift
//  GameOfWerewolf
//
//  Created by kento on 2015/06/27.
//  Copyright (c) 2015年 Kento Ohara. All rights reserved.
//

import UIKit

class VotingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var myPlayerItems: NSMutableArray = []
    var votedplayerItems: NSMutableArray = []
    var votingplayer: NSString = ""
    
    var appdelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet var votingplayertable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        myPlayerItems = appdelegate.playerarray
        votedplayerItems = appdelegate.arraydefault
        
        votingplayertable.delegate = self
        votingplayertable.dataSource = self
        votingplayertable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "VotingCell")
        
        let votingxib = UINib(nibName: "VotingTableViewCell", bundle: nil)
        votingplayertable.registerNib(votingxib, forCellReuseIdentifier: "VotingCell")
        
        votingplayer = myPlayerItems[0] as! NSString
        votedplayerItems.removeObject("\(myPlayerItems[0])")
        
        myPlayerItems.removeObjectAtIndex(0)
        if myPlayerItems.count == 0 {
            
        } else {
            appdelegate.playerarray = myPlayerItems
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
        
        var votecheckalert = UIAlertController(title: "投票確認", message: "あなたは\(votedplayerItems[indexPath.row])さんに投票しますか？", preferredStyle: .Alert)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "いいえ", style: .Cancel, handler: {(action: UIAlertAction)
            -> Void in
            
            print("キャンセル")
        })
        
        let defaltAction: UIAlertAction = UIAlertAction(title: "はい", style: .Default, handler: {(action: UIAlertAction) -> Void in
            
            if self.myPlayerItems.count == 0 {
                var targetView = self.storyboard?.instantiateViewControllerWithIdentifier("gopunishing")as! UIViewController
                self.presentViewController(targetView, animated: true, completion: nil)
                    
                self.votedplayerItems.addObject("\(self.votingplayer)")
                self.appdelegate.arraydefault = self.votedplayerItems
                self.appdelegate.playerarray = self.votedplayerItems
                
            } else {
                var targetView = self.storyboard?.instantiateViewControllerWithIdentifier("prevoting")as! UIViewController
                self.presentViewController(targetView, animated: true, completion: nil)
                
                self.votedplayerItems.addObject("\(self.votingplayer)")
                self.appdelegate.arraydefault = self.votedplayerItems
                
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
        return (votedplayerItems.count - 1)
        
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
