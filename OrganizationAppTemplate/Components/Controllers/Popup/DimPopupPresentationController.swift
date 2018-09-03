//
//  DimPopupPresentationController.swift
//  OrganizationAppTemplate
//
//  Created by Daniel Yo on 9/1/18.
//  Copyright © 2018 Daniel Yo. All rights reserved.
//

import UIKit

class DimPopupPresentationController: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    // MARK: - Properties
    public var presenting:Bool = false
    // MARK: - Initialization
    private func customInit() {
        
    }
    override init() {
        super.init()
        self.customInit()
    }
    
    // MARK: - Private API
    
    // MARK: - Public API
    
    // MARK: - Delegates
    // MARK: UIViewControllerTransitioningDelegate
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
    
    // MARK - UIViewControllerAnimatedTransitioning
    func animationEnded(_ transitionCompleted: Bool) {
        self.presenting = false
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to)
            else {
                return
        }
        let containerView:UIView = transitionContext.containerView
        let bounds:CGRect = UIScreen.main.bounds
        let finalFrameForVC:CGRect = transitionContext.finalFrame(for: toViewController)
        
        if (self.presenting) {
            // appear
            toViewController.view.frame = finalFrameForVC.offsetBy(dx: 0, dy: bounds.size.height)
            containerView.addSubview(toViewController.view)
            // animate
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
                toViewController.view.frame = finalFrameForVC
                fromViewController.view.alpha = 0.5
            }) { (finished:Bool) in
                transitionContext.completeTransition(true)
            }
        } else {
            // dismiss
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
                fromViewController.view.frame = finalFrameForVC.offsetBy(dx: 0, dy: bounds.size.height)
                toViewController.view.alpha = 1
            }) { (finished:Bool) in
                transitionContext.completeTransition(true)
                fromViewController.view.removeFromSuperview()
            }
        }
    }
}
