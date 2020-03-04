//
//  Extensions.swift
//  TextEditor
//
//  Created by azamat on 3/4/20.
//  Copyright © 2020 azamat. All rights reserved.
//

import UIKit

extension String{
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, count) ..< count]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(count, r.lowerBound)),
                                            upper: min(count, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    func index(index: Int) -> Index{
        guard !self.isEmpty else { return self.index(startIndex, offsetBy: 0) }
        return self.index(startIndex, offsetBy: index)
    }
    
    func isNewLine(cursorPosition: Int) -> Bool{
        guard !isEmpty else { return true }
        if self[cursorPosition - 1] == "\n" { return true }
        
        return false
    }
    
    func getTabsCountInCurrentLine(cursorPosition: Int) -> Int{
        var count = 0
        for i in stride(from: cursorPosition - 1, to: -1, by: -1){
            guard self[i] != "\n" else { return count }
            if self[i] == "\t"{
                count += 1
            }
        }
        
        return count
    }
    
    func getCurrentLineStartPosition(cursorPosition: Int) -> Int{
        for i in stride(from: cursorPosition - 1, to: -1, by: -1){
            if self[i] == "\n"{
                return i
            }
        }
        
        return 0
    }
    
    func getCurrentLineInsertPostion(cursorPosition: Int) -> Int{
        for i in stride(from: cursorPosition - 1, to: -1, by: -1){
            if self[i] == "\n"{
                return i + 1
            }
            
            if self[i] == "\t"{
                return i + 1
            }
        }
        
        return 0
    }
    
    func isCurrentLineList(cursorPosition: Int) -> Bool{
        for i in stride(from: cursorPosition - 1, to: -1, by: -1){
            guard self[i] != "\n" else { return false }
            if self[i] == "-" && (self[i-1] == "" || self[i-1] == "\n" || self[i-1] == "\t") {
                return true
            }
        }
        
        return false
    }
    
    mutating func makeList(cursorPosition: Int){
        let currentListTabPosition = getCurrentLineInsertPostion(cursorPosition: cursorPosition)
        self.insert(contentsOf: "- ", at: index(index: currentListTabPosition))
    }
    
    mutating func addTab(cursorPosition: Int){
        let currentListStartPosition = getCurrentLineStartPosition(cursorPosition: cursorPosition)
        self.insert(contentsOf: "\t", at: index(index: currentListStartPosition > 0 ?  currentListStartPosition + 1 : 0))
    }
}
