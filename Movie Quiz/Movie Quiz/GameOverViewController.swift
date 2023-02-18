//
//  GameOverViewController.swift
//  Movie Quiz
//
//  Created by Vinicius Loss on 17/02/23.
//

import UIKit

class GameOverViewController: UIViewController {

    
    @IBOutlet weak var lbScore: UILabel!
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbScore.text = "\(score)"
    }
    
    @IBAction func playAgain(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
