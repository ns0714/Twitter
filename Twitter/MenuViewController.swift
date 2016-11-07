//
//  MenuViewController.swift
//  Twitter
//
//  Created by Neha Samant on 11/3/16.
//  Copyright © 2016 Neha Samant. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var viewControllers = [UIViewController]()
    var menuItems = [MenuItem]()
    
    var hamburgerViewController: HamburgerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // Do any additional setup after loading the view.
        let timelineNavigationController = storyboard.instantiateViewController(withIdentifier: "TweetsNavigationController") as! UINavigationController
        let profileNavigationViewController = storyboard.instantiateViewController(withIdentifier: "ProfileNavigationController") as! UINavigationController
        let mentionsNavigationController = storyboard.instantiateViewController(withIdentifier: "TweetsNavigationController") as! UINavigationController
        
        (mentionsNavigationController.topViewController as! TweetsViewController).isMentionsTimeline = true
        
        viewControllers.append(timelineNavigationController)
        viewControllers.append(profileNavigationViewController)
        viewControllers.append(mentionsNavigationController)
        
        menuItems.append(MenuItem(title: "Home"))
        menuItems.append(MenuItem(title: "Profile"))
        menuItems.append(MenuItem(title: "Mentions"))
        
        hamburgerViewController.contentViewController = timelineNavigationController
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
    extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewControllers.count
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            
            hamburgerViewController.contentViewController = viewControllers[indexPath.row]
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as! MenuCell
            cell.menuItem = menuItems[indexPath.row]
            return cell                                                                                                         
        }

}
