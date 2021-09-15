//
//  WordsListViewController.swift
//  FlashCards
//
//  Created by Николай on 11.09.2021.
//

import UIKit

class FlashcardsListViewController: UITableViewController {

    var flashcards: [Flashcard]!

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        flashcards.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "flashcard", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        
        let card = flashcards[indexPath.row]
        
        content.text = card.enWord
        content.secondaryText = card.ruTranslation
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let editFlashcardVC = segue.destination as? EditingFlashcardViewController else { return }
        
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        editFlashcardVC.flashcard = flashcards[indexPath.row]
        editFlashcardVC.delegate = self
        
    }
    
}

extension FlashcardsListViewController: FlashcardsUpdateDelegate {
    func updateFlashcards() {
        tableView.reloadData()
    }
}
