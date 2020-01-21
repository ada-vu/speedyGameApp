//
//  LeaderBoardViewController.swift
//  Vu_Ada_ISP
//
//  Created by Period One on 2018-01-23.
//  Copyright © 2018 Period One. All rights reserved.
//

import UIKit

class LeaderBoardViewController: UIViewController {
    
    //outlets for all the highscore labels in the leader board
    @IBOutlet weak var highScore1Label: UILabel!
    @IBOutlet weak var highScore2Label: UILabel!
    @IBOutlet weak var highScore3Label: UILabel!
    @IBOutlet weak var highScore4Label: UILabel!
    @IBOutlet weak var highScore5Label: UILabel!
    
    //outlets for all the names in the leader board
    @IBOutlet weak var name1: UILabel!
    @IBOutlet weak var name2: UILabel!
    @IBOutlet weak var name3: UILabel!
    @IBOutlet weak var name4: UILabel!
    @IBOutlet weak var name5: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //the name will be assigned the name accordingly that was in the highscore name array
        name1.text = String(highScoreNameArray[0])
        name2.text = String(highScoreNameArray[1])
        name3.text = String(highScoreNameArray[2])
        name4.text = String(highScoreNameArray[3])
        name5.text = String(highScoreNameArray[4])
        
        //the highscore will be assigned accordingly the highscore that was in the high score array
        highScore1Label.text = String(highScoreArray[0])
        highScore2Label.text = String(highScoreArray[1])
        highScore3Label.text = String(highScoreArray[2])
        highScore4Label.text = String(highScoreArray[3])
        highScore5Label.text = String(highScoreArray[4])
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
