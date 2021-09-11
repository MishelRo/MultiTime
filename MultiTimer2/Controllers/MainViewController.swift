//
//  MainViewController.swift
//  MultiTimer2
//
//  Created by User on 10.09.2021.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    var model: MainViewModel{
        return MainViewModel()
    }

    var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = L10n.Text.enterTimerName
        textField.layer.borderWidth = 0.3
        textField.textAlignment = .center
        textField.layer.cornerRadius = 15
        return textField
    }()
    
    var timeField: UITextField = {
        let textField = UITextField()
        textField.placeholder = L10n.Text.enterTimerTime
        textField.layer.borderWidth = 0.3
        textField.textAlignment = .center
        textField.layer.cornerRadius = 15
        return textField
    }()
    
    var startButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.green
        button.layer.cornerRadius = 40
        button.setTitle(L10n.Button.Name.start, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.addTarget(self, action: #selector(addTimer), for: .touchUpInside)
        return button
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        tableViewConfigure()
        setUpBackground()
        title = L10n.Item.title
    }
    
    private func setUpBackground() {
        view.backgroundColor = .white
    }
    
    private func tableViewConfigure() {
        tableView.dataSource = self
        tableView.register(TimerCell.self, forCellReuseIdentifier: TimerCell.id)
        tableView.tableFooterView = UIView()
    }
    
    private func layout() {
        let sizeTextField = view.bounds.width - 50
        
        view.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(view).inset(120)
            make.left.equalTo(view).inset(25)
            make.height.equalTo(32)
            make.width.equalTo(sizeTextField)
        }
        
        view.addSubview(timeField)
        timeField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField).inset(55)
            make.left.equalTo(view).inset(25)
            make.height.equalTo(32)
            make.width.equalTo(sizeTextField)
        }
        
        view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.top.equalTo(timeField).inset(70)
            make.left.equalTo(view).inset(15)
            make.centerX.equalTo(view)
            make.height.equalTo(70)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(startButton).inset(100)
            make.left.equalTo(view).inset(0)
            make.right.equalTo(view).inset(0)
            make.bottom.equalTo(view).inset(15)
        }
    }
    
    func insertNewTimer() {
        let indexPath = IndexPath(row: MainViewModel.timers.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .none)
    }
    
    @objc func addTimer(sender: UIButton!) {
        let time = timeField.getInt()
        let name = nameTextField.getText()
        guard time != 0, name != "" else {
            UIAlertController().getAlert(type: .error, title: L10n.Item.wrongValue) { alert in
                self.present(alert, animated: true, completion: nil) } OkComplession: {};
            return }
        model.createNewTimer(name: nameTextField.getText(), time: Int(exactly: timeField.getInt())!) {
            self.timeField.text = ""
            self.nameTextField.text = ""
            self.insertNewTimer()
        }
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MainViewModel.timers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TimerCell.id) as! TimerCell
        let timer = MainViewModel.timers[indexPath.row]
        cell.fill(timer: timer) {
            MainViewModel.timers.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            UIAlertController().getAlert(type: .deleted, title: L10n.Item.completed) { alert in
                self.present(alert, animated: true, completion: nil) } OkComplession: {}
        }
        return cell
    }
}
