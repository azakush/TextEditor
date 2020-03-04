//
//  TextEditorViewModelTest.swift
//  TextEditorViewModelTest
//
//  Created by azamat on 3/5/20.
//  Copyright © 2020 azamat. All rights reserved.
//

import XCTest
@testable import TextEditor

class TextEditorViewModelTest: XCTestCase {

    var viewModel = TextEditorViewModel()
    
    func testAddTab(){
        viewModel.setText(text: "Hello world")
        viewModel.addTab(cursorPosition: viewModel.getText().count)
        XCTAssertEqual(viewModel.getText(), "\tHello world")
    }
    
    func testAddList(){
        viewModel.setText(text: "Hello world")
        viewModel.makeList(cursorPosition: viewModel.getText().count)
        XCTAssertEqual(viewModel.getText(), "- Hello world")
    }
    
    func textChangeTextAndPressEnter(){
        viewModel.setText(text: "- Hello world. Text\n")
        viewModel.makeList(cursorPosition: viewModel.getText().count)
        XCTAssertEqual(viewModel.getText(), "- Hello world. Text\n- ")
    }
    
    func testAddTabAndMakeList(){
        viewModel.setText(text: "Hello world.")
        viewModel.addTab(cursorPosition: viewModel.getText().count)
        viewModel.makeList(cursorPosition: viewModel.getText().count)
        XCTAssertEqual(viewModel.getText(), "\t- Hello world.")
    }
    
    func testPressEnterAndMakeList(){
        viewModel.setText(text: "\n")
        viewModel.makeList(cursorPosition: viewModel.getText().count)
        XCTAssertEqual(viewModel.getText(), "\n- ")
    }

}
