//
//  ViewController.swift
//  PageViewController1
//
//  Created by 廣部貴徳 on 2018/05/19.
//  Copyright © 2018 廣部貴徳. All rights reserved.
//

import UIKit

class YellowViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
    }
}

class RedViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }
}

class GreenViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
    }
}

class ViewController: UIViewController {
    
    var pageViewController: UIPageViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.lightGray
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("tap me", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(buttonDidTap(_:)), for: .touchUpInside)
        view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.addChildViewController(pageViewController)
        pageViewController.view.frame = CGRect(x: 10, y: 100, width: 300, height: 300)
        self.view.addSubview(pageViewController.view)
        pageViewController.didMove(toParentViewController: self)
        
        
        pageViewController.setViewControllers([YellowViewController()], direction: .forward, animated: false, completion: nil)
        self.pageViewController = pageViewController
        pageViewController.dataSource = self
    }

    @objc private func buttonDidTap(_ sender: UIButton) {
        let animator = UIViewPropertyAnimator(duration: 1.0, curve: .easeInOut)
        animator.addAnimations {
            self.pageViewController.view.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        }
        

        animator.startAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            animator.pauseAnimation()
            animator.isReversed = true
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 1.0)
        })
    }

}

extension ViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        switch viewController {
        case viewController as? YellowViewController:
            return RedViewController()
        case viewController as? RedViewController:
            return GreenViewController()
        case viewController as? GreenViewController:
            return nil
        default:
            preconditionFailure()
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        switch viewController {
        case viewController as? YellowViewController:
            return nil
        case viewController as? RedViewController:
            return YellowViewController()
        case viewController as? GreenViewController:
            return RedViewController()
        default:
            preconditionFailure()
        }
    }
}
