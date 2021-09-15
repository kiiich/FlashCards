//
//  WordsListViewController.swift
//  FlashCards
//
//  Created by Николай on 11.09.2021.
//

import UIKit

class FlashcardsListViewController: UITableViewController {

    var flashcards: [Flashcard]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        flashcards.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "flashcard", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        
        let card = flashcards[indexPath.row]
        
        content.text = card.enWord
        content.secondaryText = card.ruTranslation
        content.image = UIImage(named: card.imageName)
        content.imageProperties.cornerRadius = tableView.rowHeight / 2
        
        cell.contentConfiguration = content
        
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsVC = segue.destination as? EditingFlashcardViewController else {return}
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        let card = flashcards[indexPath.row]
        detailsVC.flashcard = card
    }
}
