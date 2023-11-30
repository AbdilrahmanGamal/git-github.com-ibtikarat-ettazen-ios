//
//  onboardingViewModel.swift
//  Ettizan_ios
//
//  Created by Abdilrahman Gamal on 28/11/2023.
//

import Foundation
import FSPagerView



class onboardingViewModel {
    
    var objects = Constants.shared.intoSliders ?? []
    
    var currentPage: Int = 0
    
    
    var VC : onboardingVC?
    init(VC: onboardingVC) {
        self.VC = VC
        
        Constants.shared.getConfiugration { constantsList in
            
            self.objects = Constants.shared.intoSliders ?? []
            self.setupView()
        }
    }
    
    
    func getCount() -> Int{
        return objects.count
    }
    
    func getCell( pagerView: FSPagerView , index : Int) -> FSPagerViewCell{
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "WalkthroughPagerCell", at: index) as! WalkthroughPagerCell
        cell.contentView.transform = Language.isRTL ? CGAffineTransform(scaleX: -1, y: 1) : CGAffineTransform(scaleX: 1, y: 1)
        let obj = objects[index]
        cell.lblTitle.text = obj.title
        print("obj.imageUrl == \(obj.imageUrl)")
        cell.img.setImageFromURL(urlString: obj.imageUrl ?? "")
        cell.btnSkip.isHidden = (self.objects.count - 1) == index
        cell.btnNext.setTitle((self.objects.count - 1) == index ? "StartNow".localized : "Next".localized, for: .normal)
        cell.buttonNextTapped = {
            debugPrint("index is : " + index.description)
            if self.currentPage ?? 0 < (self.objects.count ?? 0) - 1 {
                self.currentPage += 1
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1){
                    self.VC?.pagerView.scrollToItem(at: self.currentPage, animated: true)
                    self.VC?.pageControl.currentPage = self.currentPage
                    
                }
                self.VC?.pagerView.reloadData()
            }else {
                self.pushView()
            }
        }
        
        cell.SkipView = {
            self.pushView()
        }
        return cell
    }
    
    
    func pagerViewWillEnd(targetIndex : Int){
        VC?.pageControl.currentPage = targetIndex
        currentPage = targetIndex
    }
    
    
    func pagerViewDidEnd(index : Int){
        self.VC?.pageControl.currentPage = index
        currentPage = index
    }
    
    func pushView(){
        UIApplication.initWindow()
    }
}

extension onboardingViewModel {
    func setupView(){
        
        Cache.shared.isFirstTime = true
        
        VC?.pagerView.delegate = VC
        VC?.pagerView.dataSource = VC
        VC?.pagerView.register(UINib.init(nibName: "WalkthroughPagerCellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WalkthroughPagerCell")
        self.VC?.pagerView.decelerationDistance = FSPagerView.automaticDistance
        if Language.isRTL {
            VC?.pagerView.transform = CGAffineTransform(scaleX: -1, y: 1)
            VC?.pageControl.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
        
        VC?.pageControl.hidesForSinglePage = true
        VC?.pageControl.interitemSpacing = 10
        VC?.pageControl.itemSpacing = 6
        self.VC?.pageControl.numberOfPages = objects.count
        VC?.pageControl.setImage("icSelectedPager".image_, for: .selected)
        VC?.pageControl.setImage("icUnSelectedPager".image_, for: .normal)
        VC?.pageControl.contentHorizontalAlignment = .center
        VC?.pagerView.reloadData()
    }
}
