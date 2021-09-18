//
//  DataManager.swift
//  FlashCards
//
//  Created by Николай on 11.09.2021.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    let words = [
        ("antiseptic", "антисептик", false, "antiseptic.jpg"),
        ("amber", "янтарь", true, "amber.jpg"),
        ("parliament", "парламент", false, "parliament.jpg"),
        ("surgeon", "хирург", false, "surgeron.jpg"),
        ("wavy", "волнистый", false, "wavy.jpg"),
        ("pilot", "пилот", false, "pilot.jpg"),
        ("straw hat", "соломенная шляпа", false, "straw_hat.jpg"),
        ("catch", "ловить", false, "catch.jpg"),
        ("sophisticated", "утонченный", false, "sophisticated.jpg"),
        ("weekend", "выходные", false, "weekend.jpg"),
        ("carry", "нести", false, "carry.jpg"),
        ("else", "ещё", true, "else.jpg"),
        ("danger", "опасность", false, "danger.jpg"),
        ("number", "число", false, "number.jpg"),
        ("ratio", "соотношение", false, "ratio.jpg"),
        ("together", "вместе", false, "together.jpg"),
        ("later", "позже", false, "later.jpg"),
        ("flamingo", "фламинго", false, "flamingo.jpg")
    ]
    
    private init() {}
}
