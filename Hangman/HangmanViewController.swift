//
//  ViewController.swift
//  Hangman
//
//  Created by Gene Yoo on 10/13/15.
//  Copyright © 2015 cs198-ios. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {
    var game : Hangman = Hangman()
    var winfail : Int = 0
    var failedGuesses : Int = 0

    @IBOutlet weak var currentString: UILabel!
    @IBOutlet weak var pastGuesses: UILabel!
    @IBOutlet weak var charTextField: UITextField!
    @IBOutlet weak var drawing: UIImageView!

    @IBAction func guess(sender: UIButton){ // guess button
        if (winfail == 0) {
            if (charTextField.text! == "") {
                self.view.endEditing(true)
                return
            }
            let guessedLetter = game.guessLetter(charTextField.text!)
            if (guessedLetter == false) {
                failedGuesses += 1
                // extenddrawing
                let hangmanFile = "basic-hangman-img/hangman" + String(failedGuesses+1) + ".gif"
                drawing.image = UIImage(named: hangmanFile)
                if (failedGuesses == 6) {
                    failAlert()
                }
            }
            self.view.endEditing(true)
            charTextField.text! = ""
            pastGuesses.text = game.guesses()
//        print(game.guesses())
//        print(game.guessedLetters)
            currentString.text = game.knownString
            if (game.knownString == game.answer) {
                winAlert()
            }
        }
//        self.tabBarController?.selectedIndex = 0
    }
    
    @IBAction func newGame(sender: UIButton) {
        game.start() // get new word
        print (game.answer)
        charTextField.text! = "" // reset character field
        pastGuesses.text = "" // reset past guesses
        currentString.text = game.knownString
        drawing.image = UIImage(named: "basic-hangman-img/hangman1.gif")
        winfail = 0
        failedGuesses = 0
    }
    
    @IBAction func startOver(sender: UIButton) {
        if (winfail == 0) {
            drawing.image = UIImage(named: "basic-hangman-img/hangman1.gif")
            pastGuesses.text = ""
            game.guessedLetters = NSMutableArray()
            charTextField.text! = ""
            currentString.text = ""
            game.knownString = ""
            for (var i = 0; i < game.answer!.characters.count; i += 1) {
                if (game.answer! as NSString).substringWithRange(NSMakeRange(i, 1)) == " " {
                    game.knownString = game.knownString! + " "
                } else {
                    game.knownString = game.knownString! + "_"
                }
            }
            failedGuesses = 0
        }
    }
    
    func winAlert() {
        let alertController = UIAlertController(title: "Game Result", message:
            "WIN", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Default,handler: nil))
        winfail = 1
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func failAlert() {
        let alertController = UIAlertController(title: "Game Result", message:
            "FAIL", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Default,handler: nil))
        winfail = 1
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    override func viewDidAppear(animated: Bool) {
        game.start()
        print (game.answer)
        drawing.image = UIImage(named: "basic-hangman-img/hangman1.gif")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

