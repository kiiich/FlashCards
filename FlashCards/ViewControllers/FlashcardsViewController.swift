//
//  FlashcardsViewController.swift
//  FlashCards
//
//  Created by Николай on 11.09.2021.
//

import UIKit

class FlashcardsViewController: UIViewController {

    @IBOutlet weak var showAnswerButton: UIButton!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var imageFlashcardView: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var knowButton: UIButton!
    @IBOutlet weak var dontKnowButton: UIButton!
    @IBOutlet weak var buttonsStack: UIStackView!
    @IBOutlet weak var allStudiedLabel: UILabel!
    
    var flashcards: [Flashcard]!
    private var currentIndex = 0
    private var filteredFlashcards: [Flashcard] = []
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
                
        prepareForFlashcards()
        setupButtonsStyle()
        updateUIElements(currentFlashcard())
        adaptUIForPhoneModels()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if filteredFlashcards.count == 0 {
            hideNavigationElements()
            allStudiedLabel.isHidden = false
            return
        }
        
        updateUIElements(currentFlashcard())
    }
    
    override func viewWillLayoutSubviews() {
        imageFlashcardView.layer.cornerRadius = (imageFlashcardView.frame.height / 10) * 1.5
    }

    @IBAction func knowButtonPressed() {
    
        if filteredFlashcards.count == 1 {
            hideNavigationElements()
            allStudiedLabel.isHidden = false
            filteredFlashcards[0].isLearned = true
            filteredFlashcards.remove(at: 0)
            return
        }
        
        if currentIndex == filteredFlashcards.count - 1 {
            currentIndex = 0
        }
        
        filteredFlashcards[currentIndex].isLearned = true
        
        filteredFlashcards.remove(at: currentIndex)
        
        updateUIElements(currentFlashcard())
        
    }
    
    @IBAction func dontKnowButtonPressed() {
        
        if currentIndex == filteredFlashcards.count - 1 {
            currentIndex = 0
        } else {
            currentIndex += 1
        }
    
        updateUIElements(currentFlashcard())

    }
    
    @IBAction func showAnswerPressed(_ sender: UIButton) {
        showAnswerButton.setTitle(currentFlashcard().ruTranslation, for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationVC = segue.destination as? UINavigationController {
            guard let editFlashcardVC = navigationVC.topViewController as? EditingFlashcardViewController else { return }
            
            editFlashcardVC.flashcard = currentFlashcard()
            editFlashcardVC.delegate = self
        }
    }
        
    private func prepareForFlashcards() {
        
        currentIndex = 0
        
        filteredFlashcards = flashcards
            .filter{ !$0.isLearned }
            .shuffled()
        
    }
    
    private func updateUIElements(_ currentFlashcard: Flashcard) {
        
        wordLabel.text = currentFlashcard.enWord
        imageFlashcardView.image = UIImage(named: currentFlashcard.imageName)
        countLabel.text = "\(currentIndex + 1) / \(filteredFlashcards.count)"
        showAnswerButton.setTitle("Show answer", for: .normal)
        
    }
    
    private func setupButtonsStyle() {
        
        knowButton.layer.cornerRadius = 10
        dontKnowButton.layer.cornerRadius = 10
        
    }
    
    private func currentFlashcard() -> Flashcard {
        filteredFlashcards[currentIndex]
    }
    
    private func hideNavigationElements() {
        
        imageFlashcardView.isHidden = true
        wordLabel.isHidden = true
        countLabel.isHidden = true
        showAnswerButton.isHidden = true
        buttonsStack.isHidden = true
        
    }
    
    private func adaptUIForPhoneModels() {
        
        if UIDevice().name != "iPhone SE (1st generation)" {
            return
        }
        
        for constraint in view.constraints {
            if (constraint.identifier ?? "") == "showAnswerUp" {
                constraint.constant = 15
                return
            }
        }
    }
}

extension FlashcardsViewController: FlashcardsUpdateDelegate {
    
    func updateFlashcards() {
        updateUIElements(currentFlashcard())
    }
    
}
