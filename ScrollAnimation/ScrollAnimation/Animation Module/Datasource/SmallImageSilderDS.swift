//
//  SmallImageSilderDS.swift
//  ScrollAnimation
//
//  Created by RoH!T on 13/11/20.
//  Copyright © 2020 RoH!T. All rights reserved.
//

import UIKit

///
protocol ImageSliderDelegate: class {
    ///
    func imageSliderChange(_ index: Int)
}
/// Manage the small image sliders
class ImageSilderDS: NSObject {
    
    // MARK: - Variable
    ///
    let smallImages: [UIImage] = [#imageLiteral(resourceName: "0_front.jpg"), #imageLiteral(resourceName: "1_front.jpg"), #imageLiteral(resourceName: "2_front.jpg"), #imageLiteral(resourceName: "3_front.jpg"), #imageLiteral(resourceName: "4_front.jpg"), #imageLiteral(resourceName: "5_front.jpg"), #imageLiteral(resourceName: "6_front.jpg"), #imageLiteral(resourceName: "7_front.jpg"), #imageLiteral(resourceName: "8_front.jpg"), #imageLiteral(resourceName: "9_front.jpg")]
    ///
    let bgImages: [UIImage] = [#imageLiteral(resourceName: "0_bg.jpg"), #imageLiteral(resourceName: "1_bg.jpg"), #imageLiteral(resourceName: "2_bg.jpg"), #imageLiteral(resourceName: "3_bg.jpg"), #imageLiteral(resourceName: "4_bg.jpg"), #imageLiteral(resourceName: "5_bg.jpg"), #imageLiteral(resourceName: "6_bg.jpg"), #imageLiteral(resourceName: "7_bg.jpg"), #imageLiteral(resourceName: "8_bg.jpg"), #imageLiteral(resourceName: "9_bg.jpg")]
    ///
    weak var delegate: ImageSliderDelegate?
    ///
    var smallImageSlider: iCarousel!
    ///
    var bgImageSlider: iCarousel!
    
    // MARK: - Initializing methods
    
    /// Initializing
    /// - Parameter sliderView: object of iCarousel
    convenience init(_ smallSliderView: iCarousel, _ bgSliderView: iCarousel) {
        self.init()
        smallImageSlider = smallSliderView
        bgImageSlider = bgSliderView
        smallSliderView.delegate = self
        smallSliderView.dataSource = self
        bgSliderView.delegate = self
        bgSliderView.dataSource = self
    }
}

// MARK: - SmallImageSilderDS extension for handle the iCarousel DataSource and Delegate callback
extension ImageSilderDS: iCarouselDataSource, iCarouselDelegate {
    // MARK: SmallImageSilderDS extension for handle the iCarousel DataSource and Delegate callback methods
    ///
    func numberOfItems(in carousel: iCarousel) -> Int {
        if carousel == smallImageSlider {
            return smallImages.count
        } else {
            return bgImages.count
        }
    }
    ///
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if carousel == smallImageSlider {
            if (option == .spacing) {
                return value * 1.05
            }
        }
        return value
    }
    ///
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let frontView: UIImageView
        if let view = view as? UIImageView {
            frontView = view
            if carousel == smallImageSlider {
                frontView.image = smallImages[index]
            } else {
                frontView.image = bgImages[index]
            }
        } else {
            if carousel == smallImageSlider {
                frontView = UIImageView(frame: CGRect(x: 30, y: 40, width: 220, height: 130))
                frontView.image = smallImages[index]
            } else {
                frontView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
                frontView.image = bgImages[index]
            }
        }
        return frontView
    }
    ///
    func carouselDidScroll(_ carousel: iCarousel) {
        if carousel == smallImageSlider {
            bgImageSlider.scrollOffset = carousel.scrollOffset
            bgImageSlider.scrollToItem(at: carousel.currentItemIndex, animated: true)
        }
    }
    ///
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        delegate?.imageSliderChange(carousel.currentItemIndex)
    }
}
