//
//  ImageTransition.swift
//  Facebook
//
//  Created by Emma Guo on 3/6/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class ImageTransition: BaseTransition {
    
    var tempImageView: UIImageView!
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {

        let photoViewController = toViewController as! PhotoViewController
        let tabBarViewController = fromViewController as! UITabBarController
        let navigationController = tabBarViewController.selectedViewController as! UINavigationController
        let newsFeedViewController = navigationController.topViewController as! NewsFeedViewController
        
        tempImageView = UIImageView()
        tempImageView.contentMode = photoViewController.imageView.contentMode
        tempImageView.bounds = newsFeedViewController.tappedImageView.bounds
        tempImageView.center = newsFeedViewController.tappedImageView.center
        tempImageView.image = newsFeedViewController.tappedImageView.image
        containerView.addSubview(tempImageView)
        photoViewController.view.alpha = 0
        photoViewController.imageView.alpha = 0
        
        UIView.animateWithDuration(duration, animations: {
                self.tempImageView.bounds = photoViewController.imageView.bounds
                self.tempImageView.center = photoViewController.imageView.center
                photoViewController.view.alpha = 1
            }) { (finished: Bool) -> Void in
                photoViewController.imageView.alpha = 1
                self.tempImageView.removeFromSuperview()
                self.finish()
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        fromViewController.view.alpha = 1
        UIView.animateWithDuration(duration, animations: {
            fromViewController.view.alpha = 0
            }) { (finished: Bool) -> Void in
                self.finish()
        }
    }
}
