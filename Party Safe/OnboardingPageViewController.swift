//
//  OnboardingPageViewController.swift
//  Party Safe
//
//  Created by Josh Jaslow on 8/20/17.
//  Copyright © 2017 Jaslow Enterprises. All rights reserved.
//
import UIKit

class OnbaordingPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    lazy var VCList: [UIViewController] = {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let onboarding1 = sb.instantiateViewController(withIdentifier: "OnboardingViewController")
        
        return [onboarding1]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        self.setViewControllers([VCList[0]], direction: .forward, animated: true, completion: nil)
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
}
