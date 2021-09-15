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
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        flashcards = flashcards
            .filter{ !$0.isLearned }
            .shuffled()
        
        setupButtonsStyle()
        updateUIElements(currentFlashcard())
        adaptUIForPhoneModels()
        
    }
    
    override func viewWillLayoutSubviews() {
        imageFlashcardView.layer.cornerRadius = (imageFlashcardView.frame.height / 10) * 1.5
    }

    @IBAction func knowButtonPressed() {
    
        if flashcards.count == 1 {
            hideNavigationElements()
            allStudiedLabel.isHidden = false
            return
        }
        
        if currentIndex == flashcards.count - 1 {
            currentIndex = 0
        }
        
        flashcards[currentIndex].isLearned = true
        
        flashcards.remove(at: currentIndex)
        
        updateUIElements(currentFlashcard())
        
    }
    
    @IBAction func dontKnowButtonPressed() {
        
        if currentIndex == flashcards.count - 1 {
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
        
        guard let editFlashcardVC = segue.destination as? EditingFlashcardViewController else { return }
        
        editFlashcardVC.flashcard = currentFlashcard()
        editFlashcardVC.delegate = self
    }
        
    private func updateUIElements(_ currentFlashcard: Flashcard) {
        
        wordLabel.text = currentFlashcard.enWord
        imageFlashcardView.image = UIImage(named: currentFlashcard.imageName)
        countLabel.text = "\(currentIndex + 1) / \(flashcards.count)"
        showAnswerButton.setTitle("Show answer", for: .normal)
        
    }
    
    private func setupButtonsStyle() {
        
        knowButton.layer.cornerRadius = 10
        dontKnowButton.layer.cornerRadius = 10
        
    }
    
    private func currentFlashcard() -> Flashcard {
        flashcards[currentIndex]
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
