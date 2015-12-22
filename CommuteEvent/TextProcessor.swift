//
//  TextProcessor.swift
//  CommuteEvent
//
//  Created by Alfredo Luco on 21-12-15.
//  Copyright © 2015 Alfredo Luco. All rights reserved.
//

import Foundation
import Parsimmon

class TextProcessor {
    private var Text: String
    private var tagger = Tagger()
    private var keywords: [String] = ["Lunes","Martes", "Miercoles", "Jueves", "Viernes", "Sabado", "Domingo", "Hoy", "desfile", "diciembre", "fiesta"]
    private var tokens: [TaggedToken] = []
    private var Naive = NaiveBayes.getInstance()
    internal var isEvent: Bool = false
    init(text: String){
        self.Text = text
        self.getTagsFromString()
    }
    
    internal func tokenizerFromText(){
        let taggedTokens = self.tagger.tagWordsInText(self.Text)
        self.tokens = taggedTokens
        
        for i in taggedTokens{
            print(i)
        }
    }
    
    internal func getTagsFromString(){
        let tokenizer = Tokenizer()
        let tokens = tokenizer.tokenize(self.Text)
        
        for i in tokens{
            for j in keywords{
                if(i == j){
                    Naive.categorizeString(self.Text, category: "event")
                    self.isEvent = true
                }
            }
        }
    }
}