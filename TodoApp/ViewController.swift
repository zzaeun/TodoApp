//
//  ViewController.swift
//  TodoApp
//
//  Created by 이정은 on 8/14/25.
//

import UIKit

struct Todo: Codable {
    var title: String
    var isDone: Bool
    var isFavorite: Bool
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddTodoDelegate, EditTodoDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var todos: [Todo] = [
        Todo(title: "운동하기", isDone: false, isFavorite: false),
        Todo(title: "책 읽기", isDone: false, isFavorite: false),
        Todo(title: "빨래하기", isDone: false, isFavorite: false),
        Todo(title: "영화하기", isDone: false, isFavorite: true)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadTodos()  // 앱이 껐다 켜졌을 때 불러오는 자리
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todo = todos[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell") as! TodoTableViewCell
        cell.titleLabel.text = todo.title
        let doneImage = todo.isDone ? "checkmark.circle.fill" : "circle"
        let favImage = todo.isFavorite ? "star.fill" : "star"
        cell.doneButton.setImage(UIImage(systemName: doneImage), for: .normal)
        cell.favoriteButton.setImage(UIImage(systemName: favImage), for: .normal)
        
        cell.toggleDone = { [weak self] in
            self?.todos[indexPath.row].isDone.toggle()
            self?.saveTodos()
            self?.animateCell(cell)
        }
        
        cell.toggleFavorite = { [weak self] in
            self?.todos[indexPath.row].isFavorite.toggle()
            self?.saveTodos()
            self?.animateCell(cell)
        }
        
        return cell
    }
    
    func animateCell (_ cell: UITableViewCell) {
        UIView.animate(withDuration: 0.2, animations: {
            cell.contentView.alpha = 0.5
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                cell.contentView.alpha = 1.0
            }
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editVC = storyboard.instantiateViewController(withIdentifier: "EditTodoViewController") as! EditTodoViewController
        editVC.originText = todos[indexPath.row].title
        editVC.index = indexPath.row
        editVC.delegate = self
        
        present(editVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            saveTodos()  // 삭제 후 저장하는 위치
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func didAddNewTodo (_ todo: String) {
        todos.append(Todo(title: todo, isDone: false, isFavorite: false))
        saveTodos()
        tableView.reloadData()
    }
    
    func didEditTodo(text: String, at index: Int) {
        todos[index].title = text
        saveTodos()
        tableView.reloadData()
    }
    
    
    // 버튼이 하는 일 (버튼 누르면 할 일 입력하세요 화면으로 넘어가게)
    @IBAction func didTapAddTodo(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addVC = storyboard.instantiateViewController(identifier: "AddTodoViewController") as! AddTodoViewController
        addVC.delegate = self
        present(addVC, animated: true)
    }
    
    func saveTodos() {
        let encoder = JSONEncoder() // 저장하기 위해
        if let encoded = try? encoder.encode(todos) {
            UserDefaults.standard.set(encoded, forKey: "todoList")
        }
    }
    
    func loadTodos() {
        let decoder = JSONDecoder()  // 해석하기 위해
        if let savedData = UserDefaults.standard.data(forKey: "todoList"),  // {title:"운동하기",isDone:false,isFavorite}
           let decoded = try? decoder.decode([Todo].self, from: savedData) { // Todo(title: "운동하기", isDone: false, ifFavorite: false)]
            todos = decoded
            
        }
    }
}

