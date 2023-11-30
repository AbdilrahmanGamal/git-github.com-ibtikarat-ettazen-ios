//
//  WalkthroughPagerCellCollectionViewCell.swift
//  Ettizan_ios
//
//  Created by Abdilrahman Gamal on 28/11/2023.
//

import UIKit
import FSPagerView

class WalkthroughPagerCell: FSPagerViewCell {
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var btnSkip: UIButton!
    
    @IBOutlet weak var btnNext: UIButton!
    
    var buttonNextTapped : (() -> Void)? = nil
    var SkipView : (()->())?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell() {
        
    }
    
    @IBAction func btnNext(_ sender: Any) {
        if let btnAction = self.buttonNextTapped{
            btnAction()
        }
        
    }
    
    @IBAction func btnSkip(_ sender: Any) {
        SkipView?()
        // Go To Home ...
//        let vc = HomeTabbarViewController.storyboard_
//        vc.rootPush()
    }
}
