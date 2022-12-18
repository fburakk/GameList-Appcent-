//
//  SliderViewModel.swift
//  GameList
//
//  Created by Burak Köse on 14.12.2022.
//


import UIKit
import SDWebImage

public class SliderViewModel:UIViewController {
    
    var imageList:[String] = [String]()
    var pageController:UIPageViewController!
    var pageControl:UIPageControl!
    var pageDelegate:PageViewDelegate!
    
    public var contentMode:UIView.ContentMode = .scaleAspectFill
    public var transitionStyle:UIPageViewController.TransitionStyle = .scroll
    public var direction:UIPageViewController.NavigationDirection = .forward
    public var orientation:UIPageViewController.NavigationOrientation = .horizontal
    public var options:[UIPageViewController.OptionsKey:Any]? = nil
    public var animated = true
    public var pageControlActiveTint:UIColor = UIColor.black
    public var pageControlInactiveTint:UIColor = UIColor.lightGray
    
    public convenience init(withImages images:[Any] = [Any](), andOptions options:[UIPageViewController.OptionsKey:Any]? = nil) {
        self.init()
        self.options = options
        loadImages(images)
    }
    
    private func loadImages(_ images:[Any]) {
        for (_, image) in images.enumerated() {
            switch(image) {
                
            case is String:
                guard
                    let newImage = image as? String
                        
                else { break }
                imageList.append(newImage)
                break
                
            default:
                break
            }
        }
    }
    
    override public func loadView() {
        view = UIView()
        
        pageController = UIPageViewController(
            transitionStyle: transitionStyle,
            navigationOrientation: orientation,
            options: options)
        
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: view.bounds.width/2,height: 50))
        pageControl.numberOfPages = imageList.count
        pageControl.currentPage = 0
        pageControl.tintColor = view.tintColor
        pageControl.pageIndicatorTintColor = pageControlInactiveTint
        pageControl.currentPageIndicatorTintColor = pageControlActiveTint
        pageControl.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        pageControl.layer.masksToBounds = true
        pageControl.layer.cornerRadius = 12
        
        pageDelegate = PageViewDelegate(withImages: imageList, andControl: pageControl)
        pageController!.delegate = pageDelegate
        
        let startingViewController: ImageViewModel = dataSource.viewControllerAtIndex(0)!
        let viewControllers = [startingViewController]
        pageController!.setViewControllers(
            viewControllers,
            direction: direction,
            animated: animated,
            completion: {done in }
        )
        
        pageController!.dataSource = dataSource
        
        addChild(pageController!)
        view.addSubview(pageController!.view)
        
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        pageController!.view.expandToParent(view)
        
        pageController!.didMove(toParent: self)
    }
    
    var dataSource: ImageDataSource {
        
        if _dataSource == nil {
            _dataSource = ImageDataSource(withImages: imageList)
            _dataSource?.contentMode = contentMode
        }
        return _dataSource!
    }
    
    var _dataSource: ImageDataSource? = nil
    
}
