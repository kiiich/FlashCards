//
//  Word.swift
//  FlashCards
//
//  Created by Николай on 11.09.2021.
//

import Foundation

struct Flashcard {
    var enWord: String
    var ruTranslation: String
    var isLearned: Bool
    let imageName: String
    
    var enRuTranslation: String {
        "\(enWord) - \(ruTranslation)"
    }
}

extension Flashcard {
    mutating func editCardData(enWord: String, ruTranslation: String, isLearned: Bool) {
        self.enWord = enWord
        self.ruTranslation = ruTranslation
        self.isLearned = isLearned
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
    static func < (lhs: Flashcard, rhs: Flashcard) -> Bool {
        lhs.enWord < rhs.enWord
    }
}
