//
//  ViewController.swift
//  TextEditor
//
//  Created by azamat on 3/4/20.
//  Copyright © 2020 azamat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    private var viewModel : TextEditorViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addToolbar()
        
        viewModel = TextEditorViewModel()
        viewModel.delegate = self
        
        textView.delegate = self
        textView.becomeFirstResponder()
    }

    private func addToolbar(){
        let toolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(image: #imageLiteral(resourceName: "ic_indent"), style: .plain, target: self, action: #selector(tabPressed)),
            UIBarButtonItem(image: #imageLiteral(resourceName: "ic_list"), style: .plain, target: self, action: #selector(listPressed)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneWithNumberPad))]
        toolbar.sizeToFit()
        textView.inputAccessoryView = toolbar
    }
    
    @objc private func tabPressed() {
        viewModel.addTab(cursorPosition: textView.selectedRange.location)
    }
    
    @objc private func listPressed() {
        viewModel.makeList(cursorPosition: textView.selectedRange.location)
    }
    
    @objc private func doneWithNumberPad() {
        view.endEditing(true)
    }
}

extension ViewController : UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        viewModel.textChanged(text: textView.text, cursorPosition: textView.selectedRange.location)
    }
}

extension ViewController : TextEditorViewModelDelegate{
    func didChangeText(viewModel: TextEditorViewModel, text: String, cursorPosition: Int) {
        let range = textView.selectedRange
        textView.text = text
        textView.selectedRange = NSRange(location: cursorPosition, length: range.length)
    }
    
    
}

