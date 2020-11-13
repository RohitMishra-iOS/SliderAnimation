//
//  ImageSilderDS.swift
//  ScrollAnimation
//
//  Created by RoH!T on 12/11/20.
//  Copyright © 2020 RoH!T. All rights reserved.
//

import UIKit

/// ImageSliderDelegate protocol
protocol ImageSliderDelegate: class {
    /// Help manage the current index of page-controller
    /// - Parameter index: curent index of small image slider item
    func imageSliderChange(_ currentPage: Int)
    
    /// mange the end of draging
    func sliderDragingEnd()
}

/// Manage the image sliders animations and filling the image 
class ImageSilderDS: NSObject {
    
    // MARK: - Variable
    
    /// small images object as array of UIImage
    let smallImages: [UIImage] = [#imageLiteral(resourceName: "0_front.jpg"), #imageLiteral(resourceName: "1_front.jpg"), #imageLiteral(resourceName: "2_front.jpg"), #imageLiteral(resourceName: "3_front.jpg"), #imageLiteral(resourceName: "4_front.jpg"), #imageLiteral(resourceName: "5_front.jpg"), #imageLiteral(resourceName: "6_front.jpg"), #imageLiteral(resourceName: "7_front.jpg"), #imageLiteral(resourceName: "8_front.jpg"), #imageLiteral(resourceName: "9_front.jpg")]
    /// back-ground images object as array of UIImage
    let bgImages: [UIImage] = [#imageLiteral(resourceName: "0_bg.jpg"), #imageLiteral(resourceName: "1_bg.jpg"), #imageLiteral(resourceName: "2_bg.jpg"), #imageLiteral(resourceName: "3_bg.jpg"), #imageLiteral(resourceName: "4_bg.jpg"), #imageLiteral(resourceName: "5_bg.jpg"), #imageLiteral(resourceName: "6_bg.jpg"), #imageLiteral(resourceName: "7_bg.jpg"), #imageLiteral(resourceName: "8_bg.jpg"), #imageLiteral(resourceName: "9_bg.jpg")]
    /// manage the pagecontroller current index update throught this delegate
    weak var delegate: ImageSliderDelegate?
    /// class object of small image slider
    var smallImageSlider: iCarousel!
    /// class object of back-groung image slider
    var bgImageSlider: iCarousel!
    
    // MARK: - Initializing methods
    
    /// Initializing
    /// - Parameter sliderView: object of iCarousel
    convenience init(_ smallSliderView: iCarousel, _ bgSliderView: iCarousel) {
        self.init()
        // initializ the small ImageSlider using mutable object of iCarousel
        smallImageSlider = smallSliderView
        // initializ the back-grond ImageSlider using mutable object of iCarousel
        bgImageSlider = bgSliderView
        
        // Set delegate of small slider view
        smallSliderView.delegate = self
        // Set datasource of small slider view
        smallSliderView.dataSource = self
        
        // Set delegate of back-ground slider view
        bgSliderView.delegate = self
        // Set datasource of back-ground slider view
        bgSliderView.dataSource = self
    }
    
    // MARK: - Helper methods
    
    /// Set bottom shadow of view
    /// - Parameter imageView: object of UIImageView()
    func setBottomShadow(_ imageView: UIImageView) {
        imageView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 3)
        imageView.layer.shadowOpacity = 1.0
        imageView.layer.shadowRadius = 4.0
        imageView.layer.masksToBounds = false
    }
}

// MARK: - SmallImageSilderDS extension for handle the iCarousel DataSource and Delegate callback
extension ImageSilderDS: iCarouselDataSource, iCarouselDelegate {
    // MARK: SmallImageSilderDS extension for handle the iCarousel DataSource and Delegate callback methods
    
    /// Set the item view count for slider
    func numberOfItems(in carousel: iCarousel) -> Int {
        // check the carousel view and return count accordingly
        if carousel == smallImageSlider {
            return smallImages.count
        } else {
            return bgImages.count
        }
    }
    /// Set the gap between images in slider
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        // check the carousel view and retunt value accordingly
        if carousel == smallImageSlider {
            if (option == .spacing) {
                return value * 1.05
            }
        }
        return value
    }
    /// Set slider view with image
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let frontView: UIImageView
        // check reusing view is empty or not and create UIImageView object accordingly
        if let view = view as? UIImageView {
            frontView = view
            // check carousel view and set image of UIImageView
            if carousel == smallImageSlider {
                frontView.image = smallImages[index]
            } else {
                frontView.image = bgImages[index]
            }
        } else {
            // check carousel view and create UIImageView object accordingly with it's image
            if carousel == smallImageSlider {
                frontView = UIImageView(frame: CGRect(x: 30, y: 40, width: 220, height: 130))
                frontView.image = smallImages[index]
            } else {
                frontView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
                frontView.image = bgImages[index]
            }
        }
        // check carousel view is smallImageSlider then set the bottom shadow od UIImageView
        if carousel == smallImageSlider {
            setBottomShadow(frontView)
        }
        return frontView
    }
    /// mange the back-ground image slider scroll animation through small image slider scrolling
    func carouselDidScroll(_ carousel: iCarousel) {
        if carousel == smallImageSlider {
            bgImageSlider.scrollOffset = carousel.scrollOffset
            bgImageSlider.scrollToItem(at: carousel.currentItemIndex, animated: true)
        }
    }
    /// Handle the slider dragging event of bigning
    func carouselWillBeginDragging(_ carousel: iCarousel) {
        delegate?.imageSliderChange(carousel.currentItemIndex)
    }
    /// Handle the slider dragging event of end
    func carouselDidEndDragging(_ carousel: iCarousel, willDecelerate decelerate: Bool) {
        delegate?.sliderDragingEnd()
    }
}
