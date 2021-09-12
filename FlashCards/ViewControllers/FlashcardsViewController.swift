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
    
    // TODO - mok
    
    var flashcards = Word.getDictionary()
        .filter { !$0.isLearned }
        .shuffled()
    
    private var currentIndex = 0
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        updateUIElements(flashcards[currentIndex])
        
    }
    
    @IBAction func pressButton(_ sender: UIButton) {
    
        if currentIndex == flashcards.count - 1 {
            currentIndex = 0
        } else {
            currentIndex += 1
        }
    
        updateUIElements(flashcards[currentIndex])
        
    }
    
    private func updateUIElements(_ currentFlashcard: Word) {
        
        wordLabel.text = currentFlashcard.enWord
        imageFlashcardView.image = UIImage(imageLiteralResourceName: currentFlashcard.imageName)
        countLabel.text = "\(currentIndex + 1) / \(flashcards.count)"
        
    }
    
}
