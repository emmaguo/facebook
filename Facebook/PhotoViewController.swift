//
//  PhotoViewController.swift
//  Facebook
//
//  Created by Emma Guo on 3/6/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var actionsButton: UIImageView!
    @IBOutlet weak var doneButton: UIImageView!
    var image: UIImage!
    let maxWidth: CGFloat! = 320
    let maxHeight: CGFloat! = 464

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let originalCenter = imageView.center
        imageView.image = image
        if (image.size.width > image.size.height) {
            // Wide picture
            let height = maxWidth * image.size.height / image.size.width
            imageView.frame.size = CGSize(width: maxWidth, height: height)
        } else {
            // Tall picture
            let width = maxHeight * image.size.width / image.size.height
            imageView.frame.size = CGSize(width: width, height: maxHeight)
        }
        imageView.center = originalCenter        
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: 320, height: 700)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickDone(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // This method is called as the user scrolls
        
        let alpha = 1 - CGFloat(scrollView.contentOffset.y / -120)
        view.backgroundColor = UIColor(white: 0, alpha: alpha)
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        UIView.animateWithDuration(0.3) { () -> Void in
            self.actionsButton.alpha = 0
            self.doneButton.alpha = 0
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // This method is called right as the user lifts their finger
            
        if (scrollView.contentOffset.y < -100) {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.actionsButton.alpha = 1
                self.doneButton.alpha = 1
            })
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        // This method is called when the scrollview finally stops scrolling.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
