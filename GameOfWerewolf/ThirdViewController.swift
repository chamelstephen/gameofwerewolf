//
//  ThirdViewController.swift
//  GameOfWerewolf
//
//  Created by kento on 2015/03/17.
//  Copyright (c) 2015年 Kento Ohara. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    
    @IBOutlet var mytableview:UITableView!
    
    // Tableで使用する配列を定義する.
    var myPlayerItems: [String] = ["プレイヤー１", "プレーヤー２", "プレイヤー３"]
    
    // Sectionで使用する配列を定義する.
    var myPlayerSections: [String] = ["Players"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let rightButton: UIBarButtonItem = UIBarButtonItem()
        rightButton.title = "編集"
        navigationItem.rightBarButtonItem = rightButton;

        
        mytableview.delegate=self
        mytableview.dataSource=self
        mytableview.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        var width:CGFloat = self.view.bounds.width
        var height:CGFloat = self.view.bounds.height
        
        println("myPlayerSections:\(myPlayerSections)")
        
        println("\(myPlayerSections.count)")
        
        
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
        var cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = "\(indexPath.row)"
        
        var playerimageview = UIImageView (frame: CGRectMake(30, 10, 30, 30))
        playerimageview.userInteractionEnabled = true
        var playerimagetap = UITapGestureRecognizer (target: self, action: "imagetaped:")
        playerimageview.addGestureRecognizer(playerimagetap)
        
        cell.contentView.addSubview(playerimageview)
        
        var nametextfield = UITextField (frame: CGRectMake(60, 10, 200, 30 ))
        nametextfield.delegate = self
        nametextfield.borderStyle = UITextBorderStyle.RoundedRect
        nametextfield.returnKeyType = UIReturnKeyType.Done
        nametextfield.placeholder = "\(myPlayerItems[indexPath.row])"
        
        cell.contentView.addSubview(nametextfield)
        
        return cell
        
    }
    
    func imagetaped(sender: UITapGestureRecognizer) {
        //写真に接続
        println("写真に接続")
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    //行数表示
    //選択不可
    //編集ボタン
        
}