//
//  PostsViewController.swift
//  ceiba soft
//
//  Created by Crhistian Vergara Gomez on 2/07/20.
//  Copyright © 2020 Crhistian Vergara Gomez. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {
    
    @IBOutlet weak var postsTableView: UITableView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userPhoneLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var listEmptyLabel: UILabel!

    var user: UserModel!
    var posts: [PostsModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userNameLabel.text = user.name
        userPhoneLabel.text = user.phone
        userEmailLabel.text = user.email
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
                
        let progressIndicatorView: ProgressIndicatorViewController = StoryboardService.getViewController(.ProgressIndicatorView)
        
        present(progressIndicatorView, animated: true)
        
        Fetch().get(endpoint: .Post, parameters: user.id.description) { [weak self] in
            
            progressIndicatorView.dismiss(animated: true)
            
            do{
                let rawPostsData = try $0.get()
                self?.posts = try JSONDecoder().decode([PostsModel].self, from: rawPostsData)
                self?.postsTableView.reloadData()
            } catch {
                
            }
        }
    }
    
    @IBAction func closeView(){
        dismiss(animated: true)
    }
    
    func messageListIsEmpty(show: Bool){
        postsTableView.isHidden = show
        listEmptyLabel.isHidden = !show
    }

}

extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let countPosts = posts?.count ?? 0
        messageListIsEmpty(show: countPosts < 1)
        return countPosts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.CELL_ID, for: indexPath) as! PostCell
        cell.setData(post: posts![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
}
