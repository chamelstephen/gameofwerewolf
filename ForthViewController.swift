//
//  ForthViewController.swift
//  GameOfWerewolf
//
//  Created by kento on 2015/04/18.
//  Copyright (c) 2015年 Kento Ohara. All rights reserved.
//

import UIKit

class ForthViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var worktableview:UITableView!
    var countplayer: Int!
    
    /*
    var werewolfnumber: Int = 1
    var citizennumber: Int = 0
    var kaitounumber: Int = 1
    var uranainumber: Int = 1
    var teruterunumber: Int = 0

    var werewolfnumberitems: NSArray = []
    var citizennumberitems: NSArray = []
    var teruterunumberitems: NSArray = []
    */
    //不使用のためコメントアウト（２月６日）
    
    var rolenumberArray: [Int] = []//役職ごとの人数を入れる
    
    var worksections: [String] = ["人狼", "市民", "てるてる"]
    var werewolfitems: [String] = ["人狼"]
    var citizenitems: [String] = ["村人", "怪盗", "占い師"]
    var teruteruitems: [String] = ["てるてる"]
    
    var allroleitems: [String] = ["人狼", "村人", "怪盗", "占い師", "てるてる"]
    
    let saveData = NSUserDefaults.standardUserDefaults()//諸々のNSUserDefaults
    
    var activeroleArray: [String] = []//アクティブな役職＊人数を表示
    var roleofplayerArray: [String] = []//ランダムに役職を並び替え、indexで役職を決定

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("プレイヤー人数:\(countplayer)")
        
        worktableview.delegate=self
        worktableview.dataSource=self
        worktableview.registerClass(UITableViewCell.self, forCellReuseIdentifier: "WorkCell")
        
        let roleallnumberArray: NSArray = [[1,0,1,1,0], [1,1,1,1,0], [1,1,1,1,1], [2,1,1,1,1], [2,2,1,1,1], [2,3,1,1,1], [3,3,1,1,1], [3,4,1,1,1]]
        
        rolenumberArray = roleallnumberArray[countplayer - 3] as! [Int]
        saveData.setObject(rolenumberArray, forKey: "RoleData")//役職の人数を保存
        
        
        let rolexib = UINib(nibName: "RolenumberTableViewCell", bundle: nil)
        worktableview.registerNib(rolexib, forCellReuseIdentifier: "WorkCell")
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return worksections [section]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return werewolfitems.count
        } else if section == 1 {
            return citizenitems.count
        } else if section == 2 {
            return teruteruitems.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WorkCell", forIndexPath: indexPath) as! RolenumberTableViewCell
        
        if indexPath.section == 0 {
            cell.roleLabel!.text = "\(werewolfitems[indexPath.row])"
        } else if indexPath.section == 1 {
            cell.roleLabel!.text = "\(citizenitems[indexPath.row])"
        } else if indexPath.section == 2 {
            cell.roleLabel!.text = "\(teruteruitems[indexPath.row])"
        }
        //役職名を表示

        
        if indexPath.section == 0 {
            cell.workernumberlabel!.text = "\(rolenumberArray[indexPath.row])"
        } else if indexPath.section == 1 {
            cell.workernumberlabel!.text = "\(rolenumberArray[indexPath.row + 1])"//indexPath.rowはsectionごとに数えられるため
        } else if indexPath.section == 2 {
            cell.workernumberlabel!.text = "\(rolenumberArray[indexPath.row + 4])"
        }
        //人数を表示
        
        return cell
    }
    
    @IBAction func role(){
        var copyrolenumberArray: [Int] = rolenumberArray
        
        while rolenumberArray[0] > 0 {
            activeroleArray.append("人狼")
            rolenumberArray[0] = (rolenumberArray[0] - 1)
        }
        
        while rolenumberArray[1] > 0 {
            activeroleArray.append("村人")
            rolenumberArray[1] = (rolenumberArray[1] - 1)
        }
        
        while rolenumberArray[2] > 0 {
            activeroleArray.append("怪盗")
            rolenumberArray[2] = (rolenumberArray[2] - 1)
        }
        
        while rolenumberArray[3] > 0 {
            activeroleArray.append("占い師")
            rolenumberArray[3] = (rolenumberArray[3] - 1)
        }
        
        while rolenumberArray[4] > 0 {
            activeroleArray.append("てるてる")
            rolenumberArray[4] = (rolenumberArray[4] - 1)
        }
        //activeroleArrayに役職＊人数を挿入
        print("長い方:\(activeroleArray)")
        
        saveData.setObject(activeroleArray, forKey: "ActiveRole")
        
        /*
        var anotheractiveroleArray: [String] = []
        //var copyrolenumberArray: [Int] = rolenumberArray
        var copyallroleitems: [String] = allroleitems
        
        print("\(copyrolenumberArray)")
        
        while copyrolenumberArray.count != 0 /*役職ごとの人数が示された配列のコピーが要素数0になるまで繰り返される*/ {
            while copyrolenumberArray[0] != 0 /*[0]が0になるまで繰り返される*/ {
                print("\(copyallroleitems)")
                anotheractiveroleArray.append(copyallroleitems[0])//役職＊人数の配列に役職を挿入
                print("\(anotheractiveroleArray)")
                let opeopenumber: Int = copyrolenumberArray[0]
                copyrolenumberArray[0] = opeopenumber - 1//役職が1回配列に挿入されたので、1減らす
                print("\(copyrolenumberArray)")
            }
            copyrolenumberArray.removeFirst()//[0]の役職が配列に挿入し終わったので消去
            print("\(copyrolenumberArray)")
            copyallroleitems.removeFirst()//[0]の役職が配列に挿入し終わったので消去
            print("\(copyallroleitems)")
            //次の役職に続く
            //ただし、次の役職(さらに次の次の役職が)の人数が0の場合・・・
            while copyrolenumberArray[0] == 0 && copyrolenumberArray.isEmpty == false {
                copyrolenumberArray.removeFirst()
                copyallroleitems.removeFirst()
                print("\(copyrolenumberArray)")
                print("\(copyallroleitems)")
            }
        }
        print("スマートな方:\(anotheractiveroleArray)")
        */
        //copyrolenumberArray==[],copyallroleitems==[]の時、copyrolenumberArray[0] == 0のところで落ちる(2月6日)
        
        var copycountplayer: Int = countplayer
        while activeroleArray.count != 0 {
            let random = Int(arc4random_uniform(UInt32(copycountplayer)))
            
            roleofplayerArray.append(activeroleArray[random])
            activeroleArray.removeAtIndex(random)
            copycountplayer = copycountplayer - 1
        }
        //ランダムに役職を並び替える
        
        print("\(roleofplayerArray)")//インデックスのプレイヤーがその役職
        saveData.setObject(roleofplayerArray, forKey: "RolePlayerData")//nsuserdefaultsに保存
        
    }
}
