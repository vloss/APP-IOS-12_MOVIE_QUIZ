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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func showHideSoundBar(_ sender: UIButton) {
    }
    
    @IBAction func changeMusicStatus(_ sender: UIButton) {
    }
    
    
    @IBAction func changeMusicTime(_ sender: UISlider) {
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
    }
}

