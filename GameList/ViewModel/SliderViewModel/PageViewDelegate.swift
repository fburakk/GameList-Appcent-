//
//  PageViewDelegate.swift
//  GameList
//
//  Created by Burak Köse on 14.12.2022.
//


import UIKit

class PageViewDelegate: NSObject, UIPageViewControllerDelegate {
    
    var imageList: [String]?
    var pageControl: UIPageControl?
    
    init(withImages images:[String], andControl control:UIPageControl) {
        super.init()
        imageList = images
        pageControl = control
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0] as! ImageViewModel
        pageControl?.currentPage = (imageList?.index(of: pageContentViewController.image)) ?? 0
    }
    
}
