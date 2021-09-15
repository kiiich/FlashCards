//
//  Word.swift
//  FlashCards
//
//  Created by Николай on 11.09.2021.
//

import Foundation

class Flashcard {
    var enWord: String
    var ruTranslation: String
    var isLearned: Bool
    let imageName: String
    
    var enRuTranslation: String {
        "\(enWord) - \(ruTranslation)"
    }
    
    init(enWord: String, ruTranslation: String, isLearned: Bool, imageName: String) {
        self.enWord = enWord
        self.ruTranslation = ruTranslation
        self.isLearned = isLearned
        self.imageName = imageName
    }
}

extension Flashcard {
    func updateWith(editedFlashcard:  Flashcard) {
        self.enWord = editedFlashcard.enWord
        self.ruTranslation = editedFlashcard.ruTranslation
        self.isLearned = editedFlashcard.isLearned
    }
}

extension Flashcard {
    static func getDictionary() -> [Flashcard] {
        var wordsList: [Flashcard] = []
        
        for rawWord in DataManager.shared.words {
            let wordData = Flashcard(
                enWord: rawWord.0,
                ruTranslation: rawWord.1,
                isLearned: rawWord.2,
                imageName: rawWord.3
            )
            wordsList.append(wordData)
        }
        
        return wordsList
    }
}

extension Flashcard: Comparable {
    static func == (lhs: Flashcard, rhs: Flashcard) -> Bool {
        lhs.enWord == rhs.enWord
    }
    
    static func < (lhs: Flashcard, rhs: Flashcard) -> Bool {
        lhs.enWord < rhs.enWord
    }
}
