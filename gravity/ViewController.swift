//
//  ViewController.swift
//  gravity
//
//  Created by Aditya Jayaraman on 3/23/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate {

    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: self.view)
        collision = UICollisionBehavior()
        animator.addBehavior(collision)
        
        
        //collision.addBoundaryWithIdentifier("boundary", fromPoint: <#CGPoint#>, toPoint: <#CGPoint#>)
        collision.translatesReferenceBoundsIntoBoundary = true
        
        gravity = UIGravityBehavior()
        animator.addBehavior(gravity)
        
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "onTimer:", userInfo: nil, repeats: true)

        collision.collisionDelegate = self
        
    }

    func onTimer() {
        let x = arc4random_uniform(UInt32(self.view.frame.size.width))
        let y = arc4random_uniform(10) + 50
        let frame = CGRect(x: Int(x), y: Int(y), width: 10, height: 10)
        let uiView = UIView(frame: frame)
        uiView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(uiView)
        gravity.addItem(uiView)
        collision.addItem(uiView)
    }
    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying, atPoint p: CGPoint) {
        let view = item as! UIView
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            view.alpha = 0
        }) { (finished) -> Void in
            self.gravity.removeItem(item)
            self.collision.removeItem(item)
            view.removeFromSuperview()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

