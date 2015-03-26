//
//  ThirdViewController.swift
//  GameOfWerewolf
//
//  Created by kento on 2015/03/17.
//  Copyright (c) 2015年 Kento Ohara. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var mySegcon:UISegmentedControl!
    @IBOutlet var mytableview:UITableView!
    //@IBOutlet var myscrollview:UIScrollView!
    
    
    // Tableで使用する配列を定義する.
    let myWerewolfItems: NSArray = ["人狼"]
    let myCitizenItems: NSArray = ["市民", "占い師", "怪盗"]
    let myFoxItems: NSArray = ["きつね"]
    
    let myPlayerItems: NSArray = ["プレイヤー１", "プレーヤー２", "プレイヤー３"]
    
    // Sectionで使用する配列を定義する.
    let mySections: NSArray = ["WereWolf Side", "Citizen Side", "Fox Side"]
    
    let myPlayerSections: NSArray = ["Players"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        mySegcon.addTarget(self, action: "segconChanged:", forControlEvents: UIControlEvents.ValueChanged)
        
        mytableview.delegate=self
        mytableview.dataSource=self
        mytableview.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        var width:CGFloat = self.view.bounds.width;
        var height:CGFloat = self.view.bounds.height
        
        //myscrollview.contentSize = CGSizeMake(width,height*2)
        //myscrollview.pagingEnabled = false
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
    セクションの数を返す.
    */
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        
        switch mySegcon.selectedSegmentIndex{
        case 0:
            println("役職設定を選択しました")
            return mySections.count
            
        case 1:
            println("プレイヤー設定を選択しました")
            return myPlayerSections.count
            
        default:
            println("役職設定を選択しました")
            return mySections.count
        }
        
    }
    
    /*
    セクションのタイトルを返す.
    */
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch mySegcon.selectedSegmentIndex{
        case 0:
            return mySections[section] as? String
            
        case 1:
            return myPlayerSections[section] as? String
            
        default:
            return mySections[section] as? String
        }
        
    }
    
    /*
    Cellが選択された際に呼び出される.
    */
    /*
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
            if indexPath.section == 0 {
                println("Value: \(myWerewolfItems[indexPath.row])")
            } else if indexPath.section == 1 {
                println("Value: \(myCitizenItems[indexPath.row])")
            } else if indexPath.section == 2 {
                println("Value: \(myFoxItems[indexPath.row])")
            }
        
    }
    */
    /*
    テーブルに表示する配列の総数を返す.
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch mySegcon.selectedSegmentIndex{
        case 0:
            if section == 0 {
                return myWerewolfItems.count
            } else if section == 1 {
                return myCitizenItems.count
            } else if section == 2 {
                return myFoxItems.count
            } else {
                return 0
            }
            
        case 1:
            self.mytableview.reloadData()
            
            if section == 0 {
                return myPlayerItems.count
            } else {
                return 0
            }
            
        default:
            if section == 0 {
                return myWerewolfItems.count
            } else if section == 1 {
                return myCitizenItems.count
            } else if section == 2 {
                return myFoxItems.count
            } else {
                return 0
            }
            
        }
        
    }
    
    /*
    Cellに値を設定する.
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as UITableViewCell
        
        switch mySegcon.selectedSegmentIndex{
        case 0:
            if indexPath.section == 0 {
                cell.textLabel?.text = "\(myWerewolfItems[indexPath.row])"
            } else if indexPath.section == 1 {
                cell.textLabel?.text = "\(myCitizenItems[indexPath.row])"
            } else if indexPath.section == 2 {
                cell.textLabel?.text = "\(myFoxItems[indexPath.row])"
            }
            
        case 1:
            self.mytableview.reloadData()
            
            if indexPath.section == 0 {
                cell.textLabel?.text = "\(myPlayerItems[indexPath.row])"
            }
            
        default:
            if indexPath.section == 0 {
                cell.textLabel?.text = "\(myWerewolfItems[indexPath.row])"
            } else if indexPath.section == 1 {
                cell.textLabel?.text = "\(myCitizenItems[indexPath.row])"
            } else if indexPath.section == 2 {
                cell.textLabel?.text = "\(myFoxItems[indexPath.row])"
            }
        }
        return cell
        
    }

    @IBAction func segconChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            println("0")
            
        case 1:
            println("1")
            
        default:
            println("2")
        }
    }
        
}