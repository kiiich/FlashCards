//
//  Word.swift
//  FlashCards
//
//  Created by Николай on 11.09.2021.
//

import Foundation

struct Word {
    let enWord: String
    var ruTranslation: String
    var learnStatus: Bool
    
    var enRuTranslation: String {
        "\(enWord) - \(ruTranslation)"
    }
    
}

extension Word {
    static func getDictionary() -> [Word] {
        var wordsList: [Word] = []
        
        for rawWord in DataManager.shared.words {
            let wordData = Word(enWord: rawWord.0, ruTranslation: rawWord.1, learnStatus: rawWord.2)
            wordsList.append(wordData)
        }
        
        return wordsList
    }
}

extension Word: Comparable {
    static func < (lhs: Word, rhs: Word) -> Bool {
        lhs.enWord < rhs.enWord
    }
}
