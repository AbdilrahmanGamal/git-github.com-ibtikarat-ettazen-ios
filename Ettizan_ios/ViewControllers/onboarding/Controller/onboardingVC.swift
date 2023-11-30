//
//  onboardingVC.swift
//  Ettizan_ios
//
//  Created by Abdilrahman Gamal on 28/11/2023.
//

import UIKit
import FSPagerView


class onboardingVC : UIViewController{
    
    @IBOutlet weak var pageControl: FSPageControl!
    @IBOutlet weak var pagerView: FSPagerView!
    
 
    var viewModel : onboardingViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = onboardingViewModel(VC: self)
    }
}



extension onboardingVC: FSPagerViewDelegate, FSPagerViewDataSource {
    
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return viewModel?.getCount() ?? 0
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        return viewModel?.getCell(pagerView: pagerView, index: index) ?? FSPagerViewCell()
    }
    
    // MARK:- FSPagerView Delegate
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        viewModel?.pagerViewWillEnd(targetIndex: targetIndex)
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        viewModel?.pagerViewDidEnd(index: pagerView.currentIndex)
    }
    
}
