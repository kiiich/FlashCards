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
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateFlashcards()
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
        
        if card.isLearned {
            content.imageProperties.tintColor = .orange
            content.textProperties.color = .lightGray
            content.text = (content.text ?? "") + " ✓"
            content.secondaryTextProperties.color = .lightGray
        }
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let editFlashcardVC = segue.destination as? EditingFlashcardViewController else { return }
        
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        editFlashcardVC.flashcard = flashcards[indexPath.row]
        editFlashcardVC.delegate = self
        
    }
    
    private func setupUI() {
        tableView.rowHeight = 70
        setTitle()
    }
    
    private func setTitle() {
        let countLearned = flashcards.filter({ $0.isLearned }).count
        title = "Studied: \(countLearned) of \(flashcards.count)"
    }
    
}

extension FlashcardsListViewController: FlashcardsUpdateDelegate {
    func updateFlashcards() {
        tableView.reloadData()
        setTitle()
    }
}
