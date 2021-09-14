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
    
    var delegate: FlashcardsUpdateDelegate!
    var flashCard: Flashcard!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func studiedSwitcher() {
    }
    
    
    @IBAction func saveButtonPressed() {
        dismiss(animated: true)
    }
    
}
