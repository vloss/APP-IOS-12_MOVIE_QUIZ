//
//  ViewController.swift
//  Movie Quiz
//
//  Created by Vinicius Loss on 17/02/23.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var viSoundBar: UIView!
    @IBOutlet weak var slMusic: UISlider!
    @IBOutlet var btOptions: [UIButton]!
    @IBOutlet weak var ivQuiz: UIImageView!
    @IBOutlet weak var viTimer: UIView!
    
    var quizManager: QuizManager!
    var quizPlayer: AVAudioPlayer!
    var playerItem: AVPlayerItem!
    var backgroundMusciPlayer: AVPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playBackgroundMusic()
        viSoundBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        quizManager = QuizManager()
        
        getNewQuiz()
        startTimer()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! GameOverViewController
        vc.score = quizManager.score
    }
    
    func playBackgroundMusic(){
        
        // captura a URL do file
        let musicURL = Bundle.main.url(forResource: "MarchaImperial", withExtension: ".mp3")!
        playerItem = AVPlayerItem(url: musicURL)
        backgroundMusciPlayer = AVPlayer(playerItem: playerItem)
        backgroundMusciPlayer.volume = 0.1
        backgroundMusciPlayer.play()
        backgroundMusciPlayer.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: nil) { (time) in
            
            let percent = time.seconds / self.playerItem.duration.seconds
            self.slMusic.setValue(Float(percent), animated: true)
        }
    }
    
    func getNewQuiz(){
        let round = quizManager.generateRandomQuiz()
        
        for i in 0..<round.options.count {
            btOptions[i].setTitle(round.options[i].name, for: .normal)
        }
        
        playQuiz()
    }
    
    func startTimer(){
        viTimer.frame = view.frame
        UIView.animate(withDuration: 60.0, delay: 0.0, options: .curveLinear) {
            self.viTimer.frame.size.width = 0
            self.viTimer.frame.origin.x = self.view.center.x // para continuar no centro da tela
        } completion: { (sucess) in
            self.gameOver()
        }
    }
    
    func gameOver(){
        performSegue(withIdentifier: "gameOverSegue", sender: nil)
        quizPlayer.stop()
    }
    
    @IBAction func playQuiz(){
        guard let round = quizManager.round else { return }
        ivQuiz.image = UIImage(named: "movieSound")
        
        if let url = Bundle.main.url(forResource: "quote\(round.quiz.number)", withExtension: ".mp3"){
            do{
                quizPlayer =  try AVAudioPlayer(contentsOf: url)
                quizPlayer.volume = 1
                quizPlayer.delegate = self
                quizPlayer.play()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    @IBAction func showHideSoundBar(_ sender: UIButton) {
        viSoundBar.isHidden = !viSoundBar.isHidden
    }
    
    @IBAction func changeMusicStatus(_ sender: UIButton) {
        if backgroundMusciPlayer.timeControlStatus == .paused {
            backgroundMusciPlayer.play()
            sender.setImage(UIImage(named: "pause"), for: .normal)
        } else {
            backgroundMusciPlayer.pause()
            sender.setImage(UIImage(named: "play"), for: .normal)
        }
    }
    
    @IBAction func changeMusicTime(_ sender: UISlider) {
        backgroundMusciPlayer.seek(to: CMTime(seconds: Double(sender.value) * playerItem.duration.seconds, preferredTimescale: 1))
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        quizManager.checkAnswer(sender.title(for: .normal)!)
        getNewQuiz()
    }
}

extension ViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        ivQuiz.image = UIImage(named: "movieSoundPause")
    }
}
