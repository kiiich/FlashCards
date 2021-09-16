//
//  WordsListViewController.swift
//  FlashCards
//
//  Created by Николай on 11.09.2021.
//

import UIKit

class FlashcardsListViewController: UITableViewController {

    var flashcards: [Flashcard]!

    private let titleSortByAbc = "Sort by abc"
    private let titleSortByState = "Sort by state"
    
    @IBAction func changeSortType(_ sender: UIBarButtonItem) {

        if sender.title == titleSortByAbc {
            
            flashcards.sort()
            
            sender.title = titleSortByState
            
        } else if sender.title == titleSortByState {
            
            flashcards.sort {
                if $0.isLearned && $1.isLearned {
                    return $0 > $1
                } else if !$0.isLearned && $1.isLearned {
                    return true
                } else {
                    return false
                }
            }
            
            sender.title = titleSortByAbc
        }
    
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flashcards.sort()
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
        
        if let navigationVC = segue.destination as? UINavigationController {
            guard let editFlashcardVC = navigationVC.topViewController as? EditingFlashcardViewController else { return }
            
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            editFlashcardVC.flashcard = flashcards[indexPath.row]
            editFlashcardVC.delegate = self
        }
    }
    
    private func setupUI() {
        
        if UIDevice().name == "iPhone SE (1st generation)" {
            tableView.rowHeight = 70
        } else {
            tableView.rowHeight = 80
        }
        
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
