//
//  ViewController.swift
//  ceiba soft
//
//  Created by Crhistian Vergara Gomez on 1/07/20.
//  Copyright © 2020 Crhistian Vergara Gomez. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    
    @IBOutlet weak var userstableView: UITableView!
    @IBOutlet weak var searchtextField: UITextField!
    @IBOutlet weak var listEmptyLabel: UILabel!

    var users: [UserModel]? {
        willSet { usersToShow = newValue }
    }
    var usersToShow: [UserModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Storage.loadUserFromLocal { [weak self] in
            do {
                self?.users = try $0.get()
            } catch {
                // TODO: Handler Error Type
                // Se debe detectar el tipo de error y determinar si
                // Es por falta de datos o es por el decode del json.
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Si no se logran cargar usuarios en el viewDidLoad
        // Los trae desde el servidor
        if (users?.count ?? 0) == 0 { loadUsersFromServer() }
    }
    
    func loadUsersFromServer(){
        let progressIndicatorView: ProgressIndicatorViewController = StoryboardService.getViewController(.ProgressIndicatorView)
        present(progressIndicatorView, animated: true)
        
        Fetch().get(endpoint: .Users) { [weak self] in
            do{
                let rawData = try $0.get()
                self?.users = try JSONDecoder().decode([UserModel].self, from: rawData )
                Storage.saveUsersDataInLocal(userData:rawData)
                self?.userstableView.reloadData()
            } catch {
                // TODO: Handler Error Type
                // Se debe detectar el tipo de error y mostrar
                // el boton de reintentar la carga de los datos
                print(error)
            }
            progressIndicatorView.dismiss(animated: true)
        }
    }
    
    func filterUsers(text: String) {
        usersToShow = text.isEmpty ? users : users?.filter({ $0.name.contains(text) })
        userstableView.reloadData()
    }

    func messageListIsEmpty(show: Bool){
        userstableView.isHidden = show
        listEmptyLabel.isHidden = !show
    }

    func seePost(user: UserModel){
        let postsView: PostsViewController = StoryboardService.getViewController(.PostsView)
        postsView.user = user
        present(postsView, animated: true)
    }
}

extension UsersViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var text = textField.text ?? ""

        if !string.isEmpty {
            let index = String.Index(utf16Offset: range.location, in: text)
            text.insert(contentsOf: string, at: index)
        } else {
            let _range = Range(range, in: text)!
            text.removeSubrange(_range)
        }
        filterUsers(text: text)
        return true
    }

}

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let countUsers = usersToShow?.count ?? 0
        messageListIsEmpty(show: countUsers < 1)
        return countUsers
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UsersCell.CELL_ID, for: indexPath) as! UsersCell
        cell.setData(user: usersToShow![indexPath.row], seePostAction: seePost)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
}

