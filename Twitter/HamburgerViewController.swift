//
//  HamburgerViewController.swift
//  Twitter
//
//  Created by Neha Samant on 11/3/16.
//  Copyright © 2016 Neha Samant. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {


    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var leftMarginConstraint: NSLayoutConstraint!
    var originalLeftMargin: CGFloat!

    var menuViewController: UIViewController! {
        didSet {
            view.layoutIfNeeded()
            menuView.addSubview(menuViewController.view)
        }
    }

    var contentViewController: UIViewController! {
        didSet (oldContentViewController){
            view.layoutIfNeeded()
            
            if oldContentViewController != nil {
                oldContentViewController.willMove(toParentViewController: nil)
                oldContentViewController.view.removeFromSuperview()
                oldContentViewController.didMove(toParentViewController: nil)
            }
            
            contentViewController.willMove(toParentViewController: self)
            contentView.addSubview(contentViewController.view)
            contentViewController.didMove(toParentViewController: self)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.leftMarginConstraint.constant = 0
                self.view.layoutIfNeeded()
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPanGesture(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        
        if sender.state == .began {
            originalLeftMargin = leftMarginConstraint.constant
        }else if sender.state == .changed {
            
            leftMarginConstraint.constant = originalLeftMargin + translation.x
            
        }else if sender.state == .ended {
            
            UIView.animate(withDuration: 0.5, animations: {
                if velocity.x > 0 {
                    self.leftMarginConstraint.constant =  self.view.frame.size.width - 50
                }else{
                    self.leftMarginConstraint.constant = 0
                }
                self.view.layoutIfNeeded()
            })
        }
    }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
