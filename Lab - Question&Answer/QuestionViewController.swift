//
//  QuestionViewController.swift
//  Lab - Question&Answer
//
//  Created by BVU on 5/27/20.
//  Copyright © 2020 BVU. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    
    
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var muiltipleLable1: UILabel!
    @IBOutlet weak var muiltipleLable2: UILabel!
    @IBOutlet weak var muiltipleLable3: UILabel!
    @IBOutlet weak var muiltipleLable4: UILabel!
    
    @IBOutlet var multiSwitch1: UISwitch!
    @IBOutlet var multiSwitch2: UISwitch!
    @IBOutlet var multiSwitch3: UISwitch!
    @IBOutlet var multiSwitch4: UISwitch!
    
    
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedLable1: UILabel!
    @IBOutlet weak var rangedLable2: UILabel!
    
    @IBOutlet var rangedSlider: UISlider!
    
    
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    
    var questionIndex = 0
    var answersChosen: [Answers] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        switch sender {
        case singleButton1:
            answersChosen.append(currentAnswers[0])
        case singleButton2:
            answersChosen.append(currentAnswers[1])
        case singleButton3:
            answersChosen.append(currentAnswers[2])
        case singleButton4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        
        if multiSwitch1.isOn {
            answersChosen.append(currentAnswers[0])
        }
        if multiSwitch2.isOn {
            answersChosen.append(currentAnswers[1])
        }
        if multiSwitch3.isOn {
            answersChosen.append(currentAnswers[2])
        }
        if multiSwitch4.isOn {
            answersChosen.append(currentAnswers[3])
        }
        
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        
        answersChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    
    func updateMultipleStack (using answers: [Answers]) {
        multipleStackView.isHidden = false
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        muiltipleLable1.text = answers[0].text
        muiltipleLable2.text = answers[1].text
        muiltipleLable3.text = answers[2].text
        muiltipleLable4.text = answers[3].text
    }
    
    func updateRangedStack (using answers: [Answers]) {
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLable1.text = answers.first?.text
        rangedLable2.text = answers.last?.text
    }
    
    
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        navigationItem.title = "Question #\(questionIndex+1)"
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            updateRangedStack(using: currentAnswers)
        }
    }
    
    func updateSingleStack (using answers: [Answers]) {
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    

    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    
    var questions: [Question] = [
        Question(text: "Which food do you like the most?",
                 type: .single,
                 answers: [
                    Answers(text: "Steak", type: .dog),
                    Answers(text: "Fish", type: .cat),
                    Answers(text: "Carrots", type: .rabbit),
                    Answers(text: "Corn", type: .turtle)
                            ]),
        Question(text: "Which activities do you enjoy?",
                 type: .multiple,
                 answers: [
                   Answers(text: "Swimming", type: .turtle),
                   Answers(text: "Sleeping", type: .cat),
                   Answers(text: "Cuddling", type: .rabbit),
                   Answers(text: "Eating", type: .dog)
                           ]),
        Question(text: "How much do you enjoy car rides?",
                type: .ranged,
                answers: [
                   Answers(text: "I dislike them", type: .cat),
                   Answers(text: "I get a little nervous", type: .rabbit),
                   Answers(text: "I barely notice them", type: .turtle),
                   Answers(text: "I love them", type: .dog)
                           ])
    ]
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.responses = answersChosen
        }
    }
    

}
