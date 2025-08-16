//
//  AddTodoViewController.swift
//  TodoApp
//
//  Created by 이정은 on 8/14/25.
//

import UIKit

protocol AddTodoDelegate: AnyObject {
    func didAddNewTodo(_ todo: String)
}

class AddTodoViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    weak var delegate: AddTodoDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func didTapSave(_ sender: Any) {
        guard let text = textField.text, !text.isEmpty else {
            return
        }
        delegate?.didAddNewTodo(text)
        dismiss(animated: true)
    }

}
