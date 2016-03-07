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
        let frame = newsFeedViewController.view.convertRect(
            newsFeedViewController.tappedImageView.frame, fromView: newsFeedViewController.scrollView)

        tempImageView = UIImageView()
        tempImageView.image = newsFeedViewController.tappedImageView.image
        tempImageView.contentMode = newsFeedViewController.tappedImageView.contentMode
        tempImageView.frame = frame
        containerView.addSubview(tempImageView)
        photoViewController.imageView.alpha = 0
        photoViewController.view.alpha = 0

        UIView.animateWithDuration(duration, animations: {
                self.tempImageView.frame = photoViewController.imageView.frame
                photoViewController.view.alpha = 1
            }) { (finished: Bool) -> Void in
                photoViewController.imageView.alpha = 1
                self.tempImageView.removeFromSuperview()
                self.finish()
        }
    }

    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        let photoViewController = fromViewController as! PhotoViewController
        let tabBarViewController = toViewController as! UITabBarController
        let navigationController = tabBarViewController.selectedViewController as! UINavigationController
        let newsFeedViewController = navigationController.topViewController as! NewsFeedViewController
        let endFrame = newsFeedViewController.view.convertRect(
            newsFeedViewController.tappedImageView.frame, fromView: newsFeedViewController.scrollView)
        
        tempImageView = UIImageView()
        tempImageView.image = photoViewController.image
        tempImageView.contentMode = newsFeedViewController.tappedImageView.contentMode
        tempImageView.frame = photoViewController.imageView.frame
        containerView.addSubview(tempImageView)
        photoViewController.view.alpha = 0

        UIView.animateWithDuration(duration, animations: {
                self.tempImageView.frame = endFrame
            }) { (finished: Bool) -> Void in
                self.tempImageView.removeFromSuperview()
                self.finish()
        }
    }
}
