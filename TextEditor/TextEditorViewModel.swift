//
//  TextEditorViewModel.swift
//  TextEditor
//
//  Created by azamat on 3/4/20.
//  Copyright © 2020 azamat. All rights reserved.
//

import UIKit

protocol TextEditorViewModelDelegate {
    func didChangeText(viewModel: TextEditorViewModel, text: String, cursorPosition: Int)
}

class TextEditorViewModel: NSObject {
    private var text = ""
    private var lastCursorPosition = 0
    
    var delegate: TextEditorViewModelDelegate?
    
    func setText(text: String){
        self.text = text
    }
    
    func getText() -> String{
        return text
    }
    
    func addTab(cursorPosition: Int){
        text.addTab(cursorPosition: cursorPosition)
        lastCursorPosition = cursorPosition + 1
        delegate?.didChangeText(viewModel: self, text: text, cursorPosition: lastCursorPosition)
    }
    
    func makeList(cursorPosition: Int){
        if !text.isCurrentLineList(cursorPosition: cursorPosition){
            text.makeList(cursorPosition: cursorPosition)
            lastCursorPosition = cursorPosition + 2
            delegate?.didChangeText(viewModel: self, text: text, cursorPosition: lastCursorPosition)
        }
    }
    
    func textChanged(text: String, cursorPosition: Int){
        let isSymbolAdded = text.count > self.text.count
        self.text = text
        lastCursorPosition = cursorPosition
        
        if text.isNewLine(cursorPosition: lastCursorPosition) && isSymbolAdded{
            let isList = text.isCurrentLineList(cursorPosition: lastCursorPosition - 1)
            let tabsCount = text.getTabsCountInCurrentLine(cursorPosition: lastCursorPosition - 1)
            for _ in 0..<tabsCount{
                self.text.addTab(cursorPosition: lastCursorPosition)
                lastCursorPosition = lastCursorPosition + 1
            }
            
            if isList{
                makeList(cursorPosition: lastCursorPosition)
            }
        }
        
        delegate?.didChangeText(viewModel: self, text: self.text, cursorPosition: lastCursorPosition)
    }
}
