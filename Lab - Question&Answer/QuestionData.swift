//
//  QuestionData.swift
//  Lab - Question&Answer
//
//  Created by BVU on 5/27/20.
//  Copyright © 2020 BVU. All rights reserved.
//

import Foundation

struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answers]
}

enum ResponseType {
    case single, multiple, ranged
}

struct Answers {
    var text: String
    var type: AnimalType
}

enum AnimalType: Character {
    case dog = "🐶", cat = "🐱", rabbit = "🐰", turtle = "🐢"
    
    var defination: String {
        switch self {
        case .dog:
            return "You are incredibly outgoing. You surround yourself with the people you love and enjoy activities with your friends."
        case .cat:
            return "YMischievous, yet mild-tempered, you enjoy doing things on your own terms."
        case .rabbit:
            return "You love everthing that's soft. You are healthy and full of energy."
        case .turtle:
            return "You are wise beyond your years, and you focus on the details. Slow and steady wins the race."
        }
    }
}
