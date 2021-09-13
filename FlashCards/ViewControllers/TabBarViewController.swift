//
//  TabBarViewController.swift
//  FlashCards
//
//  Created by Nechaev Sergey  on 13.09.2021.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        passData()
    }

    private func passData() {
        let flashcards = Flashcard.getDictionary()
        
        guard let viewControllers = viewControllers else { return }

        viewControllers.forEach {
            guard let navigationVC = $0 as? UINavigationController else { return }
            
            if let cardsListVC = navigationVC.topViewController as? FlashcardsListViewController {
                cardsListVC.flashcards = flashcards
            } else if let showcardsVC = navigationVC.topViewController as? FlashcardsViewController {
                showcardsVC.flashcards = flashcards.shuffled().filter{ !$0.isLearned }
            }
        }

    }

}
