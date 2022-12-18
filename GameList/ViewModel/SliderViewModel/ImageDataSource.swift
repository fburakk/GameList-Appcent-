//
//  ImageDataSource.swift
//  GameList
//
//  Created by Burak Köse on 14.12.2022.
//

import UIKit

class ImageDataSource: NSObject, UIPageViewControllerDataSource {
    
    var imageList:[String] = [String]()
    var contentMode:UIView.ContentMode = .scaleAspectFill
    var shouldLoop:Bool = true
    
    convenience init(withImages images:[String]) {
        self.init()
        imageList = images
    }
    
    func indexOfViewController(_ viewController: ImageViewModel) -> Int {
        
        return imageList.index(of: viewController.image) ?? NSNotFound
    }
    
    func viewControllerAtIndex(_ index: Int) -> ImageViewModel? {
        if (self.imageList.count == 0) || (index >= self.imageList.count) {
            return nil
        }
        
        let imageViewController = ImageViewModel()
        imageViewController.image = self.imageList[index]
        imageViewController.contentMode = contentMode
        return imageViewController
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! ImageViewModel)
        if (index == NSNotFound) {
            return nil
        }
        
        if (index == 0) {
            if (shouldLoop) {
                index = imageList.count
            } else {
                return nil
            }
        }
        index -= 1
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! ImageViewModel)
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        if index == self.imageList.count {
            if (shouldLoop) {
                index = 0
            } else {
                return nil
            }
        }
        return self.viewControllerAtIndex(index)
    }
    
}
