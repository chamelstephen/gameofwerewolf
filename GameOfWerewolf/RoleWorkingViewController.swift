//
//  RoleWorkingViewController.swift
//  OneNight
//
//  Created by kento on 2016/02/20.
//  Copyright © 2016年 Kento Ohara. All rights reserved.
//

import UIKit

class RoleWorkingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var DirectionLabel: UILabel!
    @IBOutlet var myTableView: UITableView!
    @IBOutlet var nextButton: UIButton!
    
    //var RoleCheckViewTableView: UITableView!
    
    var RoleString: String!
    var NameString: String!
    
    var savedData = NSUserDefaults.standardUserDefaults()
    
    var myRoleItems: [String] = []
    var myPlayerItems: [String] = []
    var mywerewolfItems: [String] = []
    var myUranaiItems: [String] = []
    var myKaitouItems: [String] = []
    
    var copymyRoleItems: [String] = []
    var copymyPlayerItems: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)//navigationbarを非表示
        if RoleString != "人狼" {
             nextButton.hidden = true
        }
        
        //DirectionLabel.text
        if RoleString == "人狼" {
            DirectionLabel.text = "他の人狼のプレイヤーを確認しましょう"
        } else if RoleString == "占い師" {
            DirectionLabel.text = "占うプレイヤーを選びましょう"
        } else if RoleString == "怪盗" {
            DirectionLabel.text = "入れ替わるプレイヤーを選びましょう"
        }
        
        myRoleItems = savedData.arrayForKey("RolePlayerData")! as! [String]
        myPlayerItems = savedData.arrayForKey("player")! as! [String]
        
        //このプレイヤーのインデックスを取得したい
        let index = myPlayerItems.indexOf(NameString)
        print("このプレイヤーのインデックスは\(index)")
        
        //人狼の場合の表示する配列をつくる
        copymyRoleItems = myRoleItems
        copymyPlayerItems = myPlayerItems
        if RoleString == "人狼" {
            copymyRoleItems.removeAtIndex(index!)//役職の配列のこのプレイヤーのインデックスを削除
            
            //次のwhile文が機能するように(インデックスを役職配列と合わせるために)、プレイヤー本人のインデックスを削除
            copymyPlayerItems.removeAtIndex(index!)
            
            if copymyRoleItems.contains("人狼") == true {
                //他に人狼がいる場合
                while copymyRoleItems.contains("人狼") == false {
                    mywerewolfItems.append(copymyPlayerItems[copymyRoleItems.indexOf("人狼")!])//人狼のプレイヤーのインデックス
                    copymyRoleItems.removeAtIndex(copymyRoleItems.indexOf("人狼")!)
                    copymyPlayerItems.removeAtIndex(copymyRoleItems.indexOf("人狼")!)
                }
                print("プレイヤー以外の人狼は:\(mywerewolfItems)")
            } else {
                mywerewolfItems.append("他の人狼はいません")
                print("\(mywerewolfItems)")
            }
        }
        
        //占い師の場合に表示する配列
        if RoleString == "占い師" {
            myUranaiItems = myPlayerItems
            myUranaiItems.removeAtIndex(index!)
            myUranaiItems.append("中置きを占う")
        }
        
        //怪盗の場合に表示する配列
        if RoleString == "怪盗" {
            myKaitouItems = myPlayerItems
            myKaitouItems.removeAtIndex(index!)
            myKaitouItems.append("誰とも入れ替わらない")
        }
        
        copymyRoleItems = myRoleItems
        copymyRoleItems.removeAtIndex(index!)
        let nakaoki: [String] = savedData.arrayForKey("NakaOkiRole")! as! [String]
        
        //中置きを占いたい。
        if RoleString == "占い師" {
            copymyRoleItems.append("\(nakaoki[0])")//[プレイヤー１の役職, プレイヤー２の役職, , , 中置き１]
            copymyRoleItems.append("\(nakaoki[1])")
            print("\(copymyRoleItems)")
        }
        
        if RoleString == "怪盗" {
            copymyRoleItems.append("怪盗")
            print("\(copymyRoleItems)")
        }
        
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "RoleWorkingCell")
        
        let rolexib = UINib(nibName: "RoleWorkingTableViewCell", bundle: nil)
        myTableView.registerNib(rolexib, forCellReuseIdentifier: "RoleWorkingCell")
        
        // Do any additional setup after loading the view.
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
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if RoleString != "占い師" {
            var displaytext: String = copymyRoleItems[indexPath.row]
            if indexPath.row == myPlayerItems.count - 1 {
                displaytext = "\(copymyRoleItems[indexPath.row]),\(copymyRoleItems[indexPath.row + 1])"
            }
            print("\(displaytext)")
            
            let alert: UIAlertController = UIAlertController(title:"確認", message: "本当にこのプレイヤーを占いますか？", preferredStyle: UIAlertControllerStyle.Alert)
            //Cancel 一つだけしか指定できない
            let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.Cancel,
                handler: {
                    (action: UIAlertAction!) -> Void in
                    print("Cancel")
            })
            
            //Default 複数指定可
            let defaultAction: UIAlertAction = UIAlertAction(title: "はい、占います", style: UIAlertActionStyle.Default,
                handler: {
                    (action: UIAlertAction!) -> Void in
                    print("Yes")
                    
                    let AlertUranai: UIAlertController = UIAlertController(title: "占いの結果", message: "結果は\(displaytext)でした", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    let cancelAction: UIAlertAction = UIAlertAction(title: "確認しました", style: UIAlertActionStyle.Cancel,
                        handler: {
                            (action: UIAlertAction!) -> Void in
                            let targetView = self.storyboard!.instantiateViewControllerWithIdentifier( "roleprecheck" )
                            self.presentViewController( targetView, animated: true, completion: nil)
                    })
                    
                    AlertUranai.addAction(cancelAction)
                    
                    self.presentViewController(alert, animated: true, completion: nil)
            })
        
            //AlertもActionSheetも同じ
            alert.addAction(cancelAction)
            alert.addAction(defaultAction)
            
            //表示。UIAlertControllerはUIViewControllerを継承している。
            presentViewController(alert, animated: true, completion: nil)
            
        } else if RoleString == "怪盗" {
            let displaytext: String = copymyRoleItems[indexPath.row]
            print("\(displaytext)")
            
            let alert: UIAlertController = UIAlertController(title:"確認", message: "本当にこのプレイヤーと入れ替わりますか？", preferredStyle: UIAlertControllerStyle.Alert)
            //Cancel 一つだけしか指定できない
            let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.Cancel,
                handler: {
                    (action: UIAlertAction!) -> Void in
                    print("Cancel")
            })
            
            //Default 複数指定可
            let defaultAction: UIAlertAction = UIAlertAction(title: "はい、入れ替わります", style: UIAlertActionStyle.Default,
                handler: {
                    (action: UIAlertAction!) -> Void in
                    print("Yes")
                    
                    let AlertUranai: UIAlertController = UIAlertController(title: "変装の結果", message: "あなたは\(displaytext)に変装しました", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    let cancelAction: UIAlertAction = UIAlertAction(title: "確認しました", style: UIAlertActionStyle.Cancel,
                        handler: {
                            (action: UIAlertAction!) -> Void in
                            
                            let index = self.myPlayerItems.indexOf(self.NameString)
                            self.myRoleItems[index!] = displaytext
                            
                            if indexPath.row != self.myPlayerItems.count - 1 {
                                //他のプレイヤーと入れ替わった場合、その入れ替わられたプレイヤーの役職は怪盗になる
                                let rolechangedplayer: String = self.myKaitouItems[indexPath.row]
                                let index2 = self.myPlayerItems.indexOf(rolechangedplayer)
                                self.myRoleItems[index2!] = "怪盗"
                            }
                            
                            if displaytext != "怪盗" {
                                //役職が変更になったとき
                                let changeString: String = "怪盗→\(displaytext)"
                                let changeString2: String = "\(displaytext)→怪盗"
                                
                                let changingrole: [String] = [changeString, changeString2, displaytext, self.NameString, self.myKaitouItems[indexPath.row]]//myKaitouItems[indexPath.row]は変更後、怪盗
                                print("\(changingrole)")
                                self.savedData.setObject(changingrole, forKey: "ChangingofRole")
                            }
                            self.savedData.setObject(self.myRoleItems, forKey: "ChangedRoleArray")//変更後の役職配列を保存
                            
                            let targetView = self.storyboard!.instantiateViewControllerWithIdentifier( "roleprecheck" )
                            self.presentViewController( targetView, animated: true, completion: nil)
                    })
                    
                    AlertUranai.addAction(cancelAction)
                    
                    self.presentViewController(alert, animated: true, completion: nil)
            })
            
            //AlertもActionSheetも同じ
            alert.addAction(cancelAction)
            alert.addAction(defaultAction)
            
            //表示。UIAlertControllerはUIViewControllerを継承している。
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if RoleString == "人狼" {
            return mywerewolfItems.count
        } else if RoleString == "占い師"{
            return myUranaiItems.count
        } else if RoleString == "怪盗" {
            return myKaitouItems.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RoleWorkingCell", forIndexPath: indexPath) as! RoleWorkingTableViewCell
        
        cell.myNumberLabel!.text = "\(indexPath.row)"
        
        if RoleString == "人狼" {
            cell.mytTextLabel!.text = "\(mywerewolfItems[indexPath.row])"
        } else if RoleString == "占い師" {
            cell.mytTextLabel!.text = "\(myUranaiItems[indexPath.row])"
        } else if RoleString == "怪盗" {
            cell.mytTextLabel!.text = "\(myKaitouItems[indexPath.row])"
        }
        
        return cell
    }
    
    @IBAction func next() {
        let targetView = self.storyboard!.instantiateViewControllerWithIdentifier( "roleprecheck" )
        self.presentViewController( targetView, animated: true, completion: nil)
    }
}
