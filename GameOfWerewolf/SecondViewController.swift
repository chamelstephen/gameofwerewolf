//
//  SecondViewController.swift
//  GameOfWerewolf
//
//  Created by kento on 2015/03/13.
//  Copyright (c) 2015年 Kento Ohara. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet var playernumberlabel : UILabel!
    @IBOutlet var playerplus : UIButton!
    @IBOutlet var playerminus : UIButton!
    
    var playernumber : Int = 3

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let backButton: UIBarButtonItem = UIBarButtonItem()
        backButton.title = "保存"
        navigationItem.backBarButtonItem = backButton;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playernumberplus(){
        if playernumber == 10 {
            playernumber = playernumber + 0
            
        } else {
            playernumber = playernumber + 1
        }
        
        playernumberlabel.text="\(playernumber)"
    }
    
    @IBAction func playernumberminus(){
        if playernumber == 3 {
            playernumber = playernumber - 0
            
        } else {
            playernumber = playernumber - 1
        }
        
        playernumberlabel.text="\(playernumber)"
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
