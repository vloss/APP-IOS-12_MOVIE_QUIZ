//
//  ViewController.swift
//  Movie Quiz
//
//  Created by Vinicius Loss on 17/02/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viSoundBar: UIView!
    @IBOutlet weak var slMusic: UISlider!
    @IBOutlet var btOptions: [UIButton]!
    @IBOutlet weak var ivQuiz: UIImageView!
    @IBOutlet weak var viTimer: UIView!
    
    var quizManager: QuizManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        quizManager = QuizManager()
        
        getNewQuiz()
    }
    
    func getNewQuiz(){
        let round = quizManager.generateRandomQuiz()
        
        for i in 0..<round.options.count {
            btOptions[i].setTitle(round.options[i].name, for: .normal)
        }
    }

    @IBAction func showHideSoundBar(_ sender: UIButton) {
        viSoundBar.isHidden = !viSoundBar.isHidden
    }
    
    @IBAction func changeMusicStatus(_ sender: UIButton) {
    }
    
    
    @IBAction func changeMusicTime(_ sender: UISlider) {
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        quizManager.checkAnswer(sender.title(for: .normal)!)
        getNewQuiz()
    }
}

