//
//  EditTodoViewController.swift
//  TodoApp
//
//  Created by 이정은 on 8/16/25.
//

import UIKit

protocol EditTodoDelegate: AnyObject {
    func didEditTodo(text: String, at index: Int)  // 몇 번째가 수정이 되어야하는지 필요
}


class EditTodoViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    var originText: String?
    var index: Int?
    weak var delegate: EditTodoDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = originText
    }
    
    @IBAction func didTapUpdate(_ sender: Any) {
        guard let newText = textField.text, !newText.isEmpty,
              let index = index else { return }
        delegate?.didEditTodo(text: newText, at: index)
        dismiss(animated: true)
    }

}
