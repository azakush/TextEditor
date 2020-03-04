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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addToolbar()
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
        print("tab pressed")
    }
    
    @objc private func listPressed() {
        print("list pressed")
    }
    
    @objc private func doneWithNumberPad() {
        view.endEditing(true)
    }
}

