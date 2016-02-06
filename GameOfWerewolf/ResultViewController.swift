//
//  ResultViewController.swift
//  OneNight
//
//  Created by kento on 2016/02/06.
//  Copyright © 2016年 Kento Ohara. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var mytableview : UITableView!
    
    var rolenumberArray: NSArray = []//役職ごとの人数を入れる
    
    var worksections: [String] = ["人狼", "市民", "てるてる"]
    var werewolfitems: [String] = ["人狼"]
    var citizenitems: [String] = ["村人", "怪盗", "占い師"]
    var teruteruitems: [String] = ["てるてる"]
    
    var myPlayerItems: [String] = []//プレイヤーの名前
    let saveData = NSUserDefaults.standardUserDefaults()//諸々のNSUserDefaults

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "勝敗結果"
        
        mytableview.delegate = self
        mytableview.dataSource = self
        mytableview.registerClass(UITableViewCell.self, forCellReuseIdentifier: "ResultCell")
        
        myPlayerItems = saveData.arrayForKey("allPlayers")! as! [String]//プレイヤーの名前を取得して[String]に代入
        rolenumberArray = saveData.arrayForKey("RoleData")! as NSArray //役職の人数を取得してNSArrayに代入
        print("プレイヤー:\(myPlayerItems)")
        print("役職の人数:\(rolenumberArray)")
        
        let rolexib = UINib(nibName: "ResultTableViewCell", bundle: nil)
        mytableview.registerNib(rolexib, forCellReuseIdentifier: "ResultCell")
        
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
        let cell = tableView.dequeueReusableCellWithIdentifier("ResultCell", forIndexPath: indexPath) as! ResultTableViewCell
        
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
}
