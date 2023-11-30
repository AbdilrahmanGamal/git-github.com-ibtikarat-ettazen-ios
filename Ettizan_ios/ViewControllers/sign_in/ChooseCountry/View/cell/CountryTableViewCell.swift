//
//  CountryTableViewCell.swift
//  Ettizan_ios
//
//  Created by Abdilrahman Gamal on 28/11/2023.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    static let ID = "CountryTableViewCell"
    
    @IBOutlet weak var countryFlag : UIImageView!
    @IBOutlet weak var countryMobileDigits : UILabel!
    @IBOutlet weak var countryname : UILabel!
    @IBOutlet weak var countrymark : UIImageView!
    @IBOutlet weak var selectBtn : UIButton!

    var selectRow : ((Int)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(country : Country , countrySelect : Bool , row : Int){
        self.countryFlag.setImageFromURL(urlString: country.imageUrl ?? "")
        self.countryMobileDigits.text = "\(country.prefix ?? 0)"
        self.countryname.text = country.name
        
        let markCountry = countrySelect ? "icselected".image_ : "icunselected".image_
        self.countrymark.image = markCountry

        self.selectBtn.tag = row
    }

    
    
    // MARK: Configure Selection
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func selectClick(_ sender : UIButton){
        selectRow?(sender.tag)
    }
}
