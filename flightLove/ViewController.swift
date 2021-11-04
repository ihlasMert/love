//
//  ViewController.swift
//  flightLove
//
//  Created by ihlas on 3.11.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var birdArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    
    
//Views
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    
    @IBOutlet weak var bird1: UIImageView!
    @IBOutlet weak var bird2: UIImageView!
    @IBOutlet weak var bird3: UIImageView!
    @IBOutlet weak var bird4: UIImageView!
    @IBOutlet weak var bird5: UIImageView!
    @IBOutlet weak var bird6: UIImageView!
    @IBOutlet weak var bird7: UIImageView!
    @IBOutlet weak var bird8: UIImageView!
    @IBOutlet weak var bird9: UIImageView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //HighScorechek
        let storedHighScore = UserDefaults.standard.object(forKey: "higescore")
        if storedHighScore == nil {
            highScore = 0
            highscoreLabel.text = "highscore: \(highScore)"
        }
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highscoreLabel.text  = "Highscore: \(highScore)"
        }
        
        scoreLabel.text = "Score: \(score)"
        
        
        bird1.isUserInteractionEnabled = true
        bird2.isUserInteractionEnabled = true
        bird3.isUserInteractionEnabled = true
        bird4.isUserInteractionEnabled = true
        bird5.isUserInteractionEnabled = true
        bird6.isUserInteractionEnabled = true
        bird7.isUserInteractionEnabled = true
        bird8.isUserInteractionEnabled = true
        bird9.isUserInteractionEnabled = true
        
        
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        
        
        bird1.addGestureRecognizer(recognizer1)
        bird2.addGestureRecognizer(recognizer2)
        bird3.addGestureRecognizer(recognizer3)
        bird4.addGestureRecognizer(recognizer4)
        bird5.addGestureRecognizer(recognizer5)
        bird6.addGestureRecognizer(recognizer6)
        bird7.addGestureRecognizer(recognizer7)
        bird8.addGestureRecognizer(recognizer8)
        bird9.addGestureRecognizer(recognizer9)
        
        birdArray = [bird1, bird2, bird3, bird4, bird5, bird6, bird7, bird8, bird9]
        
        
        
        //Timer
        counter = 30
        timeLabel.text = "\(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(hideBird), userInfo: nil, repeats: true)
        
        hideBird()
        
        
    }
    
    
    @objc func hideBird(){
        for bird in birdArray {
            bird.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(birdArray.count - 1)))
               birdArray[random].isHidden = false
    }
    
    
    @objc func increaseScore(){
        score  += 1
        scoreLabel.text  = "Score:\(score)"
    }
    @objc func countDown(){
        
        counter -= 1
        
        timeLabel.text = "\(counter)"
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            for bird in birdArray {
                bird.isHidden = true
            }
            
            //HighScore
            if self.score > self.highScore {
                self.highScore = self.score
                highscoreLabel.text = "HighScore:\(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highScore")
            
            //Alert
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
            let ReplayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                //Replay Function

                self.score  = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(self.hideBird), userInfo: nil, repeats: true)


            }
            alert.addAction(okButton)
            alert.addAction(ReplayButton)
            self.present(alert,animated: true, completion: nil)
        }
        
    }
}

}
