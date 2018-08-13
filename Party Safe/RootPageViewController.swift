//
//  RootPageViewController.swift
//  Party Safe
//
//  Created by Josh Jaslow on 8/18/17.
//  Copyright © 2017 Jaslow Enterprises. All rights reserved.
//

import UIKit

class RootPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    lazy var VCList: [UIViewController] = {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let speedDial = sb.instantiateViewController(withIdentifier: "speedDialVC")
        let settings = sb.instantiateViewController(withIdentifier: "settingsVC")
        let drinkCounter = sb.instantiateViewController(withIdentifier: "drinkCounterVC")
        
        return [speedDial, drinkCounter, settings]
    }()
    
    var pageControl = UIPageControl()
    
    func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
        self.pageControl.numberOfPages = VCList.count
        self.pageControl.currentPage = 1
        self.pageControl.pageIndicatorTintColor = UIColor.gray
        self.pageControl.currentPageIndicatorTintColor = UIColor.white
        self.view.addSubview(pageControl)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = VCList.index(of: pageContentViewController)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        configurePageControl()
        
        self.setViewControllers([VCList[1]], direction: .forward, animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for view in self.view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds
            }
            else if view is UIPageControl {
                view.backgroundColor = UIColor.clear
            }
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = VCList.index(of: viewController) else {return nil}
        
        let previousIndex = vcIndex - 1
        
        guard previousIndex >= 0 else {return nil}
        
        guard VCList.count > previousIndex else {return nil}
        
        return VCList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = VCList.index(of: viewController) else {return nil}
        
        let nextIndex = vcIndex + 1
        
        guard VCList.count != nextIndex else {return nil}
        
        guard VCList.count > nextIndex else {return nil}
        
        return VCList[nextIndex]
    }
    
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        return VCList.count
//    }
//
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        guard let firstVC = viewControllers?.first, let firstVCIndex = VCList.index(of: firstVC) else{return 0}
//        
//        return firstVCIndex
//    }
}
