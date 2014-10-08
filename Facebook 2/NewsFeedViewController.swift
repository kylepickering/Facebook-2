//
//  NewsFeedViewController.swift
//  Facebook 2
//
//  Created by Kyle Pickering on 9/17/14.
//  Copyright (c) 2014 Kyle Pickering. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var wedding1Image: UIImageView!
    @IBOutlet weak var wedding2Image: UIImageView!
    @IBOutlet weak var wedding3Image: UIImageView!
    @IBOutlet weak var wedding4Image: UIImageView!
    @IBOutlet weak var wedding5Image: UIImageView!
    
    var isPresenting: Bool = true
    var tappedView: UIImageView!
    var imageArray: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageArray = [
            UIImage(named: "wedding1"),
            UIImage(named: "wedding2"),
            UIImage(named: "wedding3"),
            UIImage(named: "wedding4"),
            UIImage(named: "wedding5")]
        
        scrollView.contentSize = feedImage.frame.size
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showFullScreen(sender: UITapGestureRecognizer) {
        performSegueWithIdentifier("imageSegue", sender: sender)
    }
    
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        if segue.identifier == "imageSegue" {
            var destinationVC = segue.destinationViewController as UIViewController
            destinationVC.modalPresentationStyle = UIModalPresentationStyle.Custom
            destinationVC.transitioningDelegate = self
            
            var destinationViewController = segue.destinationViewController as FullScreenImageViewController
            
            tappedView = sender.view as UIImageView
            var imageToPass: UIImage! = tappedView.image

            destinationViewController.image = imageToPass
            destinationViewController.imageArray = imageArray
        }
    }
    
    @IBAction func onWedding1Tap(sender: UITapGestureRecognizer) {
        showFullScreen(sender)
    }
    
    @IBAction func onWedding2Tap(sender: UITapGestureRecognizer) {
        showFullScreen(sender)
    }
    
    @IBAction func onWedding3Tap(sender: UITapGestureRecognizer) {
        showFullScreen(sender)
    }
    
    @IBAction func onWedding4Tap(sender: UITapGestureRecognizer) {
        showFullScreen(sender)
    }
    
    @IBAction func onWedding5Tap(sender: UITapGestureRecognizer) {
        showFullScreen(sender)
    }
    
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = false
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return 0.3
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        println("animating transition")
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        var window = UIApplication.sharedApplication().keyWindow
        var frame = window.convertRect(tappedView.frame, fromView: tappedView.superview)
        var newImageView: UIImageView = UIImageView(frame: frame)
        var finalFrame = CGRect(x: 0, y: 50, width: 320, height: 480)
        newImageView.image = tappedView.image
        println(newImageView.image?.size)
        newImageView.contentMode = UIViewContentMode.ScaleAspectFit

        if (isPresenting) {
            
            window.addSubview(newImageView)
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                newImageView.frame = finalFrame
                toViewController.view.alpha = 1
                }) { (finished: Bool) -> Void in
                    newImageView.removeFromSuperview()
                    transitionContext.completeTransition(true)
            }
        } else {
            newImageView.frame = finalFrame
            window.addSubview(newImageView)
            fromViewController.view.alpha = 0
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                newImageView.frame = frame
                newImageView.contentMode = UIViewContentMode.ScaleAspectFit
                
                }) { (finished: Bool) -> Void in
                    newImageView.removeFromSuperview()
                    transitionContext.completeTransition(true)
                    fromViewController.view.removeFromSuperview()
            }
        }
    }
}
