//
//  ViewController.swift
//  Vu_Ada_ISP
//
//  Created by Period One on 1/11/18.
//  Copyright © 2018 Period One. All rights reserved.
//

import UIKit

//global variables
var highScoreArray = [Int] ()
var highScoreNameArray = [String] ()
var name = String()

//class for the viewcontroller
class ViewController: UIViewController {

    //outlet for the array of buttons and colours
    @IBOutlet var collectionOfButtons = [UIButton] ()
    var colours = [UIColor] ()
    
    //outlets for the prompt colour for diff game difficulties
    @IBOutlet weak var promptColour: UIButton!
    @IBOutlet weak var promptColour2: UIButton!
    @IBOutlet weak var promptColour3: UIButton!
    
    //outlet for the array to store the colours for the prompt colour (diff difficulties)
    var promptColours = [UIColor] ()
    
    //outlets for buttons
    @IBOutlet weak var rules: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var loseMessage: UILabel!
    @IBOutlet weak var tauntingMessages: UILabel!
    
    //randomizer for different variables needing a random number
    var randomColours: Int = 0
    var randomAppearance: Int = 0
    var randomPromptColour: Int = 0
    var randomTauntMessage: Int = 0
    
    //variables related to time
    var time: Int = 30
    var timer = Timer()
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeText: UILabel!
    
    //scoring variables
    var score = 0
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreText: UILabel!
    
    //leaderboard variables
    @IBOutlet weak var leaderBoardButton: UIButton!
    
    
    //outlets for the diff game modes
    @IBOutlet weak var easyMode: UIButton!
    @IBOutlet weak var mediumMode: UIButton!
    @IBOutlet weak var hardMode: UIButton!
    @IBOutlet weak var promptMessageToPlay: UILabel!
    
    //prompt for name in the beginning of game
    @IBOutlet weak var promptForName: UILabel!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dangerMessage: UILabel!
    
    
    //array for the taunting message after game over shows at the loser screen
    var tauntingArray = [
        "Better luck next time",
        "C'mon is that your best?",
        "Aw man are you too slow?",
        "Well...you tried"
    ]
    
    //variable to determine whether the game is over or not
    var gameOver: Bool = false
    
    //ok button that goes into the game when pressed
    @IBAction func okButtonPressed(_ sender: Any) {
        if nameTextField.text != "" {
            promptMessageToPlay.isHidden = false
            rules.isHidden = false
            promptForName.isHidden = true
            nameTextField.isHidden = true
            okButton.isHidden = true
            easyMode.isHidden = false
            mediumMode.isHidden = false
            hardMode.isHidden = false
            dangerMessage.isHidden = true
        } else {
            dangerMessage.isHidden = false
        }
        
        //assigns the name inputted in the var name
        name = nameTextField.text!
        
    }
    
    //func shows the everything when the app is first loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //loop through all the grid buttons to hide all the grid buttons initially
        for gridButton in collectionOfButtons {
            gridButton.isHidden = true
        }
        
        //initially all the prompt colours are clear and will be given a colour after randomizer
        promptColour.backgroundColor = UIColor.clear
        promptColour2.backgroundColor = UIColor.clear
        promptColour3.backgroundColor = UIColor.clear
        
        //hide necessary buttons
        playAgainButton.isHidden = true
        leaderBoardButton.isHidden = true
        
        //array that stores highscores
        highScoreArray = [
            0,
            0,
            0,
            0,
            0
        ]
        
        //array that stores the names who have highscores
        highScoreNameArray = [
            "empty",
            "empty",
            "empty",
            "empty",
            "empty"
        ]
        
        //save data
        let defaults = UserDefaults.standard
        let scoresArray = defaults.array(forKey: "highscores")
        if scoresArray != nil {
            let namesArray = defaults.stringArray(forKey: "names") ?? [String]()
            
            //save data
            highScoreArray = scoresArray as? [Int] ?? [Int]()
            highScoreNameArray = namesArray
        }
        
    }
    
    
    
    //func to generate a random colour for all the prompt colours
    func generateRandomColours(_ difficulty: Int) {
        
        //cannot press these buttons
        easyMode.isUserInteractionEnabled = false
        mediumMode.isUserInteractionEnabled = false
        hardMode.isUserInteractionEnabled = false
        rules.isHidden = true
        
        //the buttons will continue to be hidden at one point therefore have to make them all appear again
        for gridButton in collectionOfButtons {
            gridButton.isHidden = false
            gridButton.isUserInteractionEnabled = true
        }
        
        //array for the colours for the prompt colours
        promptColours = [UIColor.clear, UIColor.clear, UIColor.clear]
        
        //list of all possible colours
        var colours: [UIColor] = [UIColor.black, UIColor.brown, UIColor.blue, UIColor.purple, UIColor.green, UIColor.red, UIColor.yellow, UIColor.orange]
        
        //loop through all the difficulties and assign a random colour for all the prompt colours
        for i in 0...difficulty {
            
            //randomize a colour for each prompt colour
            randomPromptColour = Int ((arc4random_uniform(UInt32(colours.count))))
            promptColours[i] = colours[randomPromptColour]
            colours.remove(at: randomPromptColour)
        }
        
        //assign the random colour to the back colour of each of the three prompt colour
        promptColour.backgroundColor = promptColours[0]
        promptColour2.backgroundColor = promptColours[1]
        promptColour3.backgroundColor = promptColours[2]
        
        //hide necessary button
        playAgainButton.isHidden = true
        leaderBoardButton.isHidden = true
        
        //call up this func to create a new level of randomly placed colours on the grid
        setupNewLevel()
        
    }
    
    //button for the easy mode - execute necessary things, such is hiding buttons, when button is pressed
    @IBAction func easyModePressed(_ sender: Any) {
        generateRandomColours(0)
        
        //hide all the game mode button
        easyMode.isHidden = true
        mediumMode.isHidden = true
        hardMode.isHidden = true
        
        promptMessageToPlay.isHidden = true
        
        //start timer
        time = 31
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.timeAction), userInfo: nil, repeats: true)
    }
    
    //button for medium mode - execute necessary things, such is hiding buttons, when button is pressed
    @IBAction func mediumModePressed(_ sender: Any) {
        generateRandomColours(1)
        
        //hide all the game mode button
        easyMode.isHidden = true
        mediumMode.isHidden = true
        hardMode.isHidden = true
        
        promptMessageToPlay.isHidden = true
        
        //start timer
        time = 21
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.timeAction), userInfo: nil, repeats: true)
    }
    
    //button for hard mode - execute necessary things, such is hiding buttons, when button is pressed
    @IBAction func hardModePressed(_ sender: Any) {
        generateRandomColours(2)
        
        //hide all the game mode button
        easyMode.isHidden = true
        mediumMode.isHidden = true
        hardMode.isHidden = true
        
        promptMessageToPlay.isHidden = true
        
        //start timer
        time = 11
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.timeAction), userInfo: nil, repeats: true)
    }
    
    //func that sets up randomized colour and randomized appearance after all the colours have been removed from the other level
    func setupNewLevel() {
        
        //array of colours
        var colours: [UIColor] = [UIColor.black, UIColor.brown, UIColor.blue, UIColor.purple, UIColor.green, UIColor.red, UIColor.yellow, UIColor.orange]
        
        //assign a random colour for each button in diff locations
        for eachGridButton in collectionOfButtons {
            
            //make all the grid buttons clickable
            eachGridButton.isUserInteractionEnabled = true
            
            //assign a random colour to each grid button
            randomColours = Int ((arc4random_uniform(8)))
            eachGridButton.backgroundColor = colours[randomColours]
            
            //randomize whether each of the grid button will be shown or not
            randomAppearance = Int ((arc4random_uniform(2)))
            if randomAppearance == 0 {
                eachGridButton.isHidden = true
            } else if randomAppearance == 1 {
                eachGridButton.isHidden = false
            }
            
        }
        
        //if there is no colour that matches the prompt colour force a colour in the grid to be the prompt colour
        if isCompleted() {
            randomAppearance = Int ((arc4random_uniform(24)))
            collectionOfButtons[randomAppearance].backgroundColor = promptColour.backgroundColor
        }
        
        //allows the grid to have at least one grid that is the prompt colour
        for gridButton in collectionOfButtons {
            
            //do not hide the grid button that is the same as the prompt colour
            if promptColours.contains(gridButton.backgroundColor!) {
                gridButton.isHidden = false
                
            }
        }
      
    }
    
    //all the buttons are in array and this will execute if any button is pressed
    @IBAction func buttonPressed(_ sender: Any) {
        
        //allows other buttons to be pressed
        guard let button = sender as? UIButton  else {
            return
        }
        
        //if the game is not over (false) compare whether the button pressed is the sme as the prompt
        if !gameOver {
            checkColour(button.tag)
        }
    }
    
    //checks the button pressed to see if it is the same as the prompt colour
    func checkColour(_ tag: Int) {
        
        //if the button clicked is the same as prompt colour
        if promptColours.contains(collectionOfButtons[tag].backgroundColor!) {
            
            //increase time by a constant
            time += 5
            //cap the time - limit = 30
            if time >= 30 {
                time = 30
                timeLabel.text = String(time)
            }
            
            //implement scoring system - each correct colour pressed increase score by 1
            scoring()
            
            //change the colour to a diff colour so that the tag pressed is not equal to any of the colours in the prompt colour array then hide
            collectionOfButtons[tag].backgroundColor =  UIColor.magenta // Because it will never be used
            collectionOfButtons[tag].isUserInteractionEnabled = false
            collectionOfButtons[tag].isHidden = true

            //if there are no more colours in the grid that are the same as the colours in the prompt array then set up level of randomized colours
            if isCompleted() {
                setupNewLevel()
            }
            
            //if the grid pressed is not equal to one of the prompt colours lose
        } else if collectionOfButtons[tag].backgroundColor != promptColour {
            showLoserScreen()
        }
        
    }
    
    //func to find if there are anymore colours in the grid that are the same as the ones in the prompt colour array
    func isCompleted() -> Bool {
        //found is not yet found
        var found: Bool = false
        //if there is a colour in the grid that equals one of the prompt colours found is found
        for gridButton in collectionOfButtons {
            if promptColours.contains(gridButton.backgroundColor!) {
                found = true
            }
        }
        //return not found
        return !found
    }
    

    //the screen shown when user presses the wrong colour
    func showLoserScreen() {
        gameOver = true
        timer.invalidate()
        
        //hide all grid buttons
        for gridButtons in collectionOfButtons {
            gridButtons.isHidden = true
            gridButtons.isUserInteractionEnabled = false
        }
        
        //hide the prompt colours by making the buttons transparent
        promptColour.backgroundColor = UIColor.clear
        promptColour2.backgroundColor = UIColor.clear
        promptColour3.backgroundColor = UIColor.clear
        
        //loop through 1-5 top 5 on leaderboard
        for i in 0...4 {
            //highscore is equal to the element(that the iteration is currently on) in the highscore array
            let highscore = highScoreArray[i]
            //condition to see whether the score you got is higher than the high score
            if score > highscore {
                
                //insert the score from acore array at which the loop is currently iterating
                highScoreArray.insert(score, at: i)
                //insert the name from name array that was inputted at which loop is currently iterating
                highScoreNameArray.insert(nameTextField.text!, at: i)
                
                //remove the lowest value to have only top 5
                highScoreArray.remove(at: 5)
                highScoreNameArray.remove(at: 5)
                
                //when the value has found its position stop iterating
                break
            }
        }
        
        //save the values in the array
        let defaults = UserDefaults.standard
        defaults.set(highScoreArray, forKey: "highscores")
        defaults.set(highScoreNameArray, forKey: "names")
        
        //show necessary loser messages
        randomTauntMessage = Int ((arc4random_uniform(4)))
        tauntingMessages.text = String(tauntingArray[randomTauntMessage])
        
        //if time's out you lose or if you choose a wrong colour you lose
        if time <= 0 {
            loseMessage.isHidden = false
            loseMessage.text = String("TIME'S OUT")
        } else {
            loseMessage.isHidden = false
            loseMessage.text = String("WRONG COLOUR")
        }
        
        //show necessary loser messages
        tauntingMessages.isHidden = false
        playAgainButton.isHidden = false
        leaderBoardButton.isHidden = false
    }
    
    //the func for scoring - for every correct colour pressed increase score by 1
    func scoring() {
        score += 1
        scoreLabel.text = String(score)
    }
    
    //multiplier variable to use as the variable to exponentially decrease
    var multiplier: Double = 1
    
    //time action that decreases the time exponentially
    @objc func timeAction() {
        time -= Int(multiplier)
        
        //time will equal 0 if time is below 0
        if time < 0 {
            time = 0
        }
        
        //multiplier multiply increases to exponentially decrease time
        multiplier *= 1.1
        
        //preset the time in the time label
        timeLabel.text = String(time)
        
        //if time = 0 show loser screen and messages
        if time <= 0 {
            showLoserScreen()
        }
    }
    
    //when user loses play again wil pop up and the button will reset everything back to the beginning
    @IBAction func playAgainPressed(_ sender: Any) {
        //not game over
        gameOver = false
        
        //hide necessary button
        playAgainButton.isHidden = true
        leaderBoardButton.isHidden = true
        tauntingMessages.isHidden = true
        loseMessage.isHidden = true
        
        //reset necessary variables to its inital value and present it to its respective labels
        multiplier = 1
        time = 0
        timeLabel.text = String(time)
        score = 0
        scoreLabel.text = String(score)
        
        //reenable the modes so it is clickable
        easyMode.isUserInteractionEnabled = true
        mediumMode.isUserInteractionEnabled = true
        hardMode.isUserInteractionEnabled = true
        
        //show the starting screen
        promptForName.isHidden = false
        nameTextField.isHidden = false
        okButton.isHidden = false
        
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


