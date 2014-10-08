//
//  FullScreenImageViewController.swift
//  Facebook 2
//
//  Created by Kyle Pickering on 10/3/14.
//  Copyright (c) 2014 Kyle Pickering. All rights reserved.
//

import UIKit

class FullScreenImageViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageControls: UIImageView!
    @IBOutlet weak var doneButton: UIButton!
    
    var image: UIImage!
    var imageArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = image
        imageView.alpha = 0
        scrollView.delegate = self
        scrollView.alwaysBounceVertical = true

        /*var count:CGFloat = 0
        for imageElement in imageArray {
            var newImageView = UIImageView(image: imageElement as UIImage)
            newImageView.frame = CGRect(x: count * 320, y: 50, width: 320, height: 480)
            newImageView.image = imageElement.image
            newImageView.contentMode = UIViewContentMode.ScaleAspectFit
            scrollView.addSubview(newImageView)
            count++
        }
        
        scrollView.contentSize.width = count * 320
        
        count = 0
        for imageElement in imageArray {
            if imageElement.image == image {
                scrollView.contentOffset.x = count * 320
            }
            count++
        }*/

    }
    
    override func viewDidAppear(animated: Bool) {
        imageView.alpha = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onDoneButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
        return imageView
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var offset = Float(scrollView.contentOffset.y)
        var alpha: CGFloat = 1
        
        if offset < 0 {
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.doneButton.alpha = 0
                self.imageControls.alpha = 0
            })
            
            alpha = CGFloat(convertValue(offset, r1Min: -100, r1Max: 0, r2Min: 0, r2Max: 1))
            
            
        } else if offset > 0 {
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.doneButton.alpha = 0
                self.imageControls.alpha = 0
            })
            
            alpha = CGFloat(convertValue(offset, r1Min: 0, r1Max: 100, r2Min: 1, r2Max: 0))
        } else {
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.doneButton.alpha = 1
                self.imageControls.alpha = 1
            })
        }
        
        view.backgroundColor = UIColor(white: 0, alpha: alpha)
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        var offset = Float(scrollView.contentOffset.y)
        if offset < -20 || offset > 20 {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }

    func convertValue(value: Float, r1Min: Float, r1Max: Float, r2Min:
        Float, r2Max: Float) -> Float {
            var ratio = (r2Max - r2Min) / (r1Max - r1Min)
            return value * ratio + r2Min - r1Min * ratio
    }
}
