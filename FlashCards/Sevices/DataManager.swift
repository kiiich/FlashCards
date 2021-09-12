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
        ("antiseptic", "антисептик", true),
        ("amber", "янтарь", true),
        ("parliament", "парламент", false),
        ("surgeon", "хирург", false),
        ("wavy", "волнистый", false),
        ("pilot", "пилот", false),
        ("straw hat", "соломенная шляпа", false),
        ("scrupulous", "скрупулезный", false),
        ("catch", "ловить", false),
        ("sophisticated", "утонченный", false),
        ("weekend", "выходные", false),
        ("carry", "нести", false),
        ("else", "ещё", false),
        ("danger", "опасность", false),
        ("number", "число", false),
        ("ratio", "соотношение", false),
        ("slightly", "слегка", false),
        ("perhaps", "возможно", false),
        ("later", "позже", false),
        ("never", "никогда", false)
    ]
    
    private init() {}
}
