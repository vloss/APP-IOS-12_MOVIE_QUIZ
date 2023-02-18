//
//  QuizManager.swift
//  Movie Quiz
//
//  Created by Vinicius Loss on 17/02/23.
//

import Foundation

typealias Round = (quiz: Quiz, options: [QuizOption])

class QuizManager {
    
    let quizes: [Quiz]
    let quizOptions: [QuizOption]
    var score: Int
    var round: Round?
    
    init() {
        score = 0

        // captura a URL do file json
        let quizesURL = Bundle.main.url(forResource: "quizes", withExtension: ".json")!
        
        //do catch
        do{
            
            let quizesData = try Data(contentsOf: quizesURL)
            quizes = try JSONDecoder().decode([Quiz].self, from: quizesData)
            
            // captura a URL do file json
            let quizOptionsURL  = Bundle.main.url(forResource: "options", withExtension: ".json")!
            let quizOptionsData = try! Data(contentsOf: quizOptionsURL)
            quizOptions = try! JSONDecoder().decode([QuizOption].self, from: quizOptionsData)
        } catch {
            print(error.localizedDescription)
            quizes = []
            quizOptions = []
        }
    }
    
    func generateRandomQuiz() -> Round {
        
        // Pega um numero aleatorio de 0 até quantidade total dentro do array quizes[]
        let quizIndex = Int(arc4random_uniform(UInt32(quizes.count)))
        let quiz = quizes[quizIndex]
        
        //Set - coleção não ordenada que não repete elementos
        var indexes: Set<Int> = [quizIndex]
        
        while indexes.count < 4 {
            var index = Int(arc4random_uniform(UInt32(quizes.count)))
            indexes.insert(index)
        }
        // verrando o objeto Set de indexes e pegando os itens do array de options
        let options = indexes.map({quizOptions[$0]})
        
        round = (quiz, options)
        
        return round!
    }
    
    func checkAnswer(_ answer: String){
        guard let round = round else { return }
        if answer == round.quiz.name{
            score += 1
        }
    }
}

struct Quiz: Codable{
    let name: String
    let number: Int
}


struct QuizOption: Codable{
    let name: String
}
