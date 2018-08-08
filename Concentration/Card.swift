//
//  Card.swift
//  Concentration
//
//  Created by Michael Zeng on 7/26/18.
//  Copyright © 2018 Michael Zeng. All rights reserved.
//

import Foundation

struct Card: Hashable
{
    var hashValue: Int {return identifier}
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    //Purely internal implmentation
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
