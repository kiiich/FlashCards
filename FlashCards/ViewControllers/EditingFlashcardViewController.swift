//
//  EditingFlashcardViewController.swift
//  FlashCards
//
//  Created by Николай on 11.09.2021.
//

import UIKit

class EditingFlashcardViewController: UIViewController {
    
    @IBOutlet var englishWordTF: UITextField!
    @IBOutlet var russianWordTF: UITextField!
    @IBOutlet weak var isLearnedSegmentController: UISegmentedControl!
    
    var flashcard: Flashcard!
    var delegate: FlashcardsUpdateDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValues()
    }
    
    private func setValues() {
        
        englishWordTF.text = flashcard.enWord
        russianWordTF.text = flashcard.ruTranslation
        isLearnedSegmentController.selectedSegmentIndex = flashcard.isLearned ? 0 : 1
        
    }

    @IBAction func saveButtonPressed() {
       
        flashcard.enWord = englishWordTF.text ?? ""
        flashcard.ruTranslation = russianWordTF.text ?? ""
        flashcard.isLearned = isLearnedSegmentController.selectedSegmentIndex == 0 ? true : false
        
        delegate.updateFlashcards()
        dismiss(animated: true)
    }
    
    @IBAction func cancelButtonPressed() {
        
        dismiss(animated: true)
        
    }
    
}
