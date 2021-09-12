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
    
    // TODO - mok
    
    var flashcards = Flashcard.getDictionary()
        .filter { !$0.isLearned }
        .shuffled()
    
    private var currentIndex = 0
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        setupUI()
        
        updateUIElements(currentFlashcard())
        
    }
    

    @IBAction func nextButtonPressed(_ sender: UIButton) {
    
        if flashcards.count == 1 {
            allStudiedLabel.isHidden = false
            imageFlashcardView.isHidden = true
            wordLabel.isHidden = true
            countLabel.isHidden = true
            showAnswerButton.isHidden = true
            buttonsStack.isHidden = true
            return
        }
        
        if currentIndex == flashcards.count - 1 {
            currentIndex = 0
        }
        
        flashcards[currentIndex].isLearned = true
        
        flashcards.remove(at: currentIndex)
        
        updateUIElements(currentFlashcard())
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
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
    
    private func updateUIElements(_ currentFlashcard: Flashcard) {
        
        wordLabel.text = currentFlashcard.enWord
        imageFlashcardView.image = UIImage(named: currentFlashcard.imageName)
        countLabel.text = "\(currentIndex + 1) / \(flashcards.count)"
        showAnswerButton.setTitle("Show answer", for: .normal)
        
    }
    
    private func setupUI() {
        
        imageFlashcardView.layer.cornerRadius = 30
        knowButton.layer.cornerRadius = 10
        dontKnowButton.layer.cornerRadius = 10
        
    }
    
    private func currentFlashcard() -> Flashcard {
        flashcards[currentIndex]
    }
    
}
