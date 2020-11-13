//
//  ViewController.swift
//  ScrollAnimation
//
//  Created by RoH!T on 12/11/20.
//  Copyright © 2020 RoH!T. All rights reserved.
//

import UIKit

/// Manage the slider image view binding and pagecontroller actions
class AnimationController: UIViewController {

    // MARK: - Outlets
    ///
    @IBOutlet weak var smallImageSlider: iCarousel!
    ///
    @IBOutlet weak var bgImageSlider: iCarousel!
    ///
    @IBOutlet weak var pageController: UIPageControl!
    
    // MARK: - Variable
    
    /// Image slider data source object
    var dataSource: ImageSilderDS?
    
    // MARK: - Controller life-cycle
    ///
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup UI with variable initializing
        setupUI()
    }
    ///
    override func viewDidLayoutSubviews() {
        // Set the page controller indicator
        pageController.subviews.forEach {
            $0.transform = CGAffineTransform(scaleX: 10, y: 0.2)
            $0.layer.cornerRadius = 1
        }
    }
    ///
    deinit {
        dataSource = nil
    }
    
    // MARK: - UI helper methods
    
    /// Setup Image Slider UI
    func setupUI() {
        // set the animation type for small and back-ground ImageSlider
        smallImageSlider.type = .linear
        bgImageSlider.type = .linear
        // set the bounce value with false for stop the bouncing effect for small and back-ground ImageSlider
        smallImageSlider.bounces = false
        bgImageSlider.bounces = false
        // set the UserInteraction with false for remove the user intration from back-ground ImageSlider
        bgImageSlider.isUserInteractionEnabled = false
        // set the small ImageSlider to top of the supper view
        smallImageSlider.superview?.bringSubviewToFront(smallImageSlider)
        // Initializ the object of ImageSilderDS with small and back-ground ImageSlider
        dataSource = ImageSilderDS.init(smallImageSlider, bgImageSlider)
        // assing ImageSilderDataSource delete to AnimationController
        dataSource?.delegate = self
        // set the total pages of page-controller
        pageController.numberOfPages = dataSource?.smallImages.count ?? 1
        // set page-controller background color alpha with 0.0
        pageController.currentPageIndicatorTintColor = UIColor.darkGray.withAlphaComponent(0.0)
    }
}

// MARK: - ViewController extension for handle the ImageSlider Delegate callback
extension AnimationController: ImageSliderDelegate {
    // MARK: ViewController extension for handle the ImageSlider Delegate callback methods
    
    /// Help manage the current index of page-controller
    /// - Parameter index: curent index of small image slider item
    func imageSliderChange(_ currentPage: Int) {
        // set the current page of page-controller
        pageController.subviews.forEach {
            $0.transform = CGAffineTransform(scaleX: 20, y: 0.2)
            $0.layer.cornerRadius = 1
        }
        UIView.animate(withDuration: 0.5, animations: {
            self.pageController.currentPage = currentPage
            self.pageController.currentPageIndicatorTintColor = UIColor.darkGray.withAlphaComponent(1.0)
        })
    }
    /// Help to manage the page-controller animation
    func sliderDragingEnd() {
        // Set animation for draging end
        UIView.animate(withDuration: 0.1, animations: {
            self.pageController.currentPageIndicatorTintColor = UIColor.darkGray.withAlphaComponent(1.0)
        }) { (success) in
            if success {
            self.pageController.currentPageIndicatorTintColor = UIColor.darkGray.withAlphaComponent(0.0)
            }
        }
    }
}
